import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/connectivity/check_internet_connection_usecase.dart';
import 'package:noctambuls/features/explore/domain/entities/bubble_cluster.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bounds.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';
import 'package:noctambuls/features/explore/domain/service/map_clustering_service.dart';
import 'package:noctambuls/features/explore/domain/usecases/sync_map_bubbles_usecase.dart';
import 'package:noctambuls/features/explore/domain/usecases/watch_map_bubbles_usecase.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_event.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_state.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';

class _BubblesStreamUpdated extends ExploreEvent {
  const _BubblesStreamUpdated(this.bubbles);

  final List<MapBubble> bubbles;

  @override
  List<Object?> get props => [bubbles];
}

class _SyncCompleted extends ExploreEvent {
  const _SyncCompleted();
}

class _SyncFailed extends ExploreEvent {
  const _SyncFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class _ClustersComputed extends ExploreEvent {
  const _ClustersComputed(this.clusters);

  final List<BubbleCluster> clusters;

  @override
  List<Object?> get props => [clusters];
}

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({
    required this.watchBubbles,
    required this.syncBubbles,
    required this.getBirds,
    required this.checkInternet,
    required this.clusteringService,
  }) : super(const ExploreState()) {
    on<ExploreStarted>(_onStarted);
    on<ExploreRetrySync>(_onRetrySync);
    on<ExploreFilterChanged>(_onFilterChanged);
    on<ExploreMapCameraChanged>(_onMapCameraChanged);
    on<ExploreBubbleTapped>(_onBubbleTapped);
    on<_BubblesStreamUpdated>(_onBubblesStreamUpdated);
    on<_SyncCompleted>(_onSyncCompleted);
    on<_SyncFailed>(_onSyncFailed);
    on<_ClustersComputed>(_onClustersComputed);
  }

  final WatchMapBubblesUseCase watchBubbles;
  final SyncMapBubblesUseCase syncBubbles;
  final GetBirdsUseCase getBirds;
  final CheckInternetConnectionUseCase checkInternet;
  final MapClusteringService clusteringService;

  StreamSubscription<List<MapBubble>>? _bubblesSubscription;
  MapBounds? _lastBounds;
  double? _lastZoom;

  Future<void> _onStarted(
    ExploreStarted event,
    Emitter<ExploreState> emit,
  ) async {
    await _bubblesSubscription?.cancel();

    final isConnected = await checkInternet();
    final birdsResult = await getBirds(event.languageCode);
    final birdMap = birdsResult.when(
      success: (birds) => {for (final b in birds) b.id: b},
      failure: (_) => <String, Bird>{},
    );

    emit(
      state.copyWith(
        isConnected: isConnected,
        isSyncing: isConnected,
        syncError: null,
        speciesNames: birdMap,
      ),
    );

    _bubblesSubscription = watchBubbles().listen((bubbles) {
      add(_BubblesStreamUpdated(bubbles));
    });

    if (isConnected) {
      unawaited(_runSync());
    }
  }

  Future<void> _onRetrySync(
    ExploreRetrySync event,
    Emitter<ExploreState> emit,
  ) async {
    final isConnected = await checkInternet();
    if (!isConnected) {
      emit(state.copyWith(isConnected: false));
      return;
    }
    emit(state.copyWith(isConnected: true, isSyncing: true, syncError: null));
    unawaited(_runSync(force: true));
  }

  void _onFilterChanged(
    ExploreFilterChanged event,
    Emitter<ExploreState> emit,
  ) {
    final filtered = event.filters.apply(state.allBubbles);
    emit(state.copyWith(filters: event.filters, filteredBubbles: filtered));
    final bounds = _lastBounds;
    final zoom = _lastZoom;
    if (bounds != null && zoom != null) {
      add(ExploreMapCameraChanged(bounds: bounds, zoom: zoom));
    }
  }

  Future<void> _onMapCameraChanged(
    ExploreMapCameraChanged event,
    Emitter<ExploreState> emit,
  ) async {
    final bounds = event.bounds;
    if (bounds == null) return;

    _lastBounds = bounds;
    _lastZoom = event.zoom;

    final clusters = await clusteringService.clusterize(
      bubbles: state.filteredBubbles,
      bounds: bounds,
      zoom: event.zoom,
    );

    add(_ClustersComputed(clusters));
  }

  void _onBubbleTapped(
    ExploreBubbleTapped event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(tappedCluster: event.cluster));
  }

  void _onBubblesStreamUpdated(
    _BubblesStreamUpdated event,
    Emitter<ExploreState> emit,
  ) {
    final years = event.bubbles.map((b) => b.year).toSet().toList()..sort();
    final filtered = state.filters.apply(event.bubbles);
    emit(
      state.copyWith(
        allBubbles: event.bubbles,
        filteredBubbles: filtered,
        availableYears: years,
      ),
    );
    final bounds = _lastBounds;
    final zoom = _lastZoom;
    if (bounds != null && zoom != null) {
      add(ExploreMapCameraChanged(bounds: bounds, zoom: zoom));
    }
  }

  void _onSyncCompleted(
    _SyncCompleted event,
    Emitter<ExploreState> emit,
  ) {
    final filtered = state.filters.apply(state.allBubbles);
    emit(
      state.copyWith(
        isSyncing: false,
        syncError: null,
        filteredBubbles: filtered,
      ),
    );
  }

  void _onSyncFailed(
    _SyncFailed event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(isSyncing: false, syncError: event.message));
  }

  void _onClustersComputed(
    _ClustersComputed event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(visibleClusters: event.clusters));
  }

  Future<void> _runSync({bool force = false}) async {
    final result = await syncBubbles(force: force);
    result.when(
      success: (_) => add(const _SyncCompleted()),
      failure: (f) => add(_SyncFailed(f.debugMessage)),
    );
  }

  @override
  Future<void> close() {
    unawaited(_bubblesSubscription?.cancel());
    return super.close();
  }
}
