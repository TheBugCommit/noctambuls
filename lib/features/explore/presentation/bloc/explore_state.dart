import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/explore/domain/entities/bubble_cluster.dart';
import 'package:noctambuls/features/explore/domain/entities/explore_filters.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

class ExploreState extends Equatable {
  const ExploreState({
    this.isConnected = true,
    this.isSyncing = false,
    this.syncError,
    this.allBubbles = const [],
    this.filteredBubbles = const [],
    this.visibleClusters = const [],
    this.filters = const ExploreFilters(),
    this.tappedCluster,
    this.speciesNames = const {},
    this.availableYears = const [],
  });

  final bool isConnected;
  final bool isSyncing;
  final String? syncError;
  final List<MapBubble> allBubbles;
  final List<MapBubble> filteredBubbles;
  final List<BubbleCluster> visibleClusters;
  final ExploreFilters filters;
  final BubbleCluster? tappedCluster;
  final Map<String, Bird> speciesNames;
  final List<int> availableYears;

  bool get hasLocalData => allBubbles.isNotEmpty;

  ExploreState copyWith({
    bool? isConnected,
    bool? isSyncing,
    Object? syncError = _absent,
    List<MapBubble>? allBubbles,
    List<MapBubble>? filteredBubbles,
    List<BubbleCluster>? visibleClusters,
    ExploreFilters? filters,
    Object? tappedCluster = _absent,
    Map<String, Bird>? speciesNames,
    List<int>? availableYears,
  }) {
    return ExploreState(
      isConnected: isConnected ?? this.isConnected,
      isSyncing: isSyncing ?? this.isSyncing,
      syncError: syncError == _absent ? this.syncError : syncError as String?,
      allBubbles: allBubbles ?? this.allBubbles,
      filteredBubbles: filteredBubbles ?? this.filteredBubbles,
      visibleClusters: visibleClusters ?? this.visibleClusters,
      filters: filters ?? this.filters,
      tappedCluster:
          tappedCluster == _absent ? this.tappedCluster : tappedCluster as BubbleCluster?,
      speciesNames: speciesNames ?? this.speciesNames,
      availableYears: availableYears ?? this.availableYears,
    );
  }

  @override
  List<Object?> get props => [
    isConnected,
    isSyncing,
    syncError,
    allBubbles,
    filteredBubbles,
    visibleClusters,
    filters,
    tappedCluster,
    speciesNames,
    availableYears,
  ];
}

const _absent = Object();
