import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/usecases/abandon_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/fetch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/join_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/watch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/whatch_joined_census_usecase.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_event.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_state.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';

class _CensusStreamUpdated extends CensusEvent {
  const _CensusStreamUpdated(this.censuses);

  final List<Census> censuses;

  @override
  List<Object?> get props => [censuses];
}

class _LobbyStreamUpdated extends CensusEvent {
  const _LobbyStreamUpdated(this.lobbyCensus);

  final Census? lobbyCensus;

  @override
  List<Object?> get props => [lobbyCensus];
}

class CensusBloc extends Bloc<CensusEvent, CensusState> {
  CensusBloc({
    required this.watchCensusesUseCase,
    required this.watchJoinedCensusUseCase,
    required this.joinCensusUseCase,
    required this.abandonCensusUseCase,
    required this.fetchCensusesUseCase,
    required this.createSessionUseCase,
  }) : super(const CensusInitial()) {
    on<CensusStarted>(_onStarted);
    on<CensusRefreshRequested>(_onRefreshRequested);
    on<_CensusStreamUpdated>(_onStreamUpdated);
    on<_LobbyStreamUpdated>(_onLobbyStreamUpdated);
    on<StartCensusSession>(_onStartCensusSession);
    on<JoinCensusByUrl>(_onJoinByUrl);
    on<AbandonCensus>(_onAbandon);
    on<DismissCensusError>(_onDismissError);
  }

  final WatchJoinedCensusUseCase watchJoinedCensusUseCase;
  final WatchCensusesUseCase watchCensusesUseCase;
  final JoinCensusUseCase joinCensusUseCase;
  final AbandonCensusUseCase abandonCensusUseCase;
  final FetchCensusesUseCase fetchCensusesUseCase;
  final CreateSessionUseCase createSessionUseCase;

  StreamSubscription<List<Census>>? _censusSubscription;
  StreamSubscription<Census?>? _lobbySubscription;

  Future<void> _onRefreshRequested(
    CensusRefreshRequested event,
    Emitter<CensusState> emit,
  ) async {
    await fetchCensusesUseCase();
  }

  Future<void> _onStarted(
    CensusStarted event,
    Emitter<CensusState> emit,
  ) async {
    await _censusSubscription?.cancel();
    await _lobbySubscription?.cancel();

    _censusSubscription = watchCensusesUseCase().listen((censuses) {
      add(_CensusStreamUpdated(censuses));
    });

    _lobbySubscription = watchJoinedCensusUseCase().listen((lobbyCensus) {
      add(_LobbyStreamUpdated(lobbyCensus));
    });
    unawaited(fetchCensusesUseCase());
  }

  void _onStreamUpdated(
    _CensusStreamUpdated event,
    Emitter<CensusState> emit,
  ) {
    final lobbyCensus = event.censuses.where((c) => c.isJoined).firstOrNull;
    if (state is CensusJoinError) {
      final currentState = state as CensusJoinError;
      emit(
        CensusJoinError(
          failure: currentState.failure,
          censuses: event.censuses,
          lobbyCensus: lobbyCensus,
        ),
      );
    } else {
      emit(CensusLoaded(censuses: event.censuses, lobbyCensus: lobbyCensus));
    }
  }

  void _onLobbyStreamUpdated(
    _LobbyStreamUpdated event,
    Emitter<CensusState> emit,
  ) {
    if (state is CensusJoinError) {
      final currentState = state as CensusJoinError;
      emit(
        CensusJoinError(
          failure: currentState.failure,
          censuses: currentState.censuses,
          lobbyCensus: event.lobbyCensus,
        ),
      );
    } else {
      emit(
        CensusLoaded(
          censuses: _currentCensuses,
          lobbyCensus: event.lobbyCensus,
        ),
      );
    }
  }

  Future<void> _onJoinByUrl(
    JoinCensusByUrl event,
    Emitter<CensusState> emit,
  ) async {
    final currentCensuses = _currentCensuses;
    final result = await joinCensusUseCase(event.url);
    result.when(
      failure: (failure) {
        emit(
          CensusJoinError(
            failure: failure,
            censuses: currentCensuses,
            lobbyCensus: _currentLobbyCensus,
          ),
        );
      },
      success: (_) {},
    );
  }

  Future<void> _onStartCensusSession(
    StartCensusSession event,
    Emitter<CensusState> emit,
  ) async {
    final currentCensuses = _currentCensuses;
    final result = await createSessionUseCase(
      SessionType.census,
      event.annotatorId,
      censusId: event.census.id,
    );

    result.when(
      failure: (failure) {
        emit(
          CensusJoinError(
            failure: failure,
            censuses: currentCensuses,
            lobbyCensus: _currentLobbyCensus,
          ),
        );
      },
      success: (_) {},
    );
  }

  Future<void> _onAbandon(
    AbandonCensus event,
    Emitter<CensusState> emit,
  ) async {
    await abandonCensusUseCase(event.censusId);
  }

  List<Census> get _currentCensuses => switch (state) {
    CensusLoaded(:final censuses) => censuses,
    CensusJoinError(:final censuses) => censuses,
    _ => const [],
  };

  Census? get _currentLobbyCensus => switch (state) {
    CensusLoaded(:final lobbyCensus) => lobbyCensus,
    CensusJoinError(:final lobbyCensus) => lobbyCensus,
    _ => null,
  };

  void _onDismissError(
    DismissCensusError event,
    Emitter<CensusState> emit,
  ) {
    if (state is CensusJoinError) {
      final currentState = state as CensusJoinError;
      emit(
        CensusLoaded(
          censuses: currentState.censuses,
          lobbyCensus: currentState.lobbyCensus,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    unawaited(_censusSubscription?.cancel());
    unawaited(_lobbySubscription?.cancel());
    return super.close();
  }
}
