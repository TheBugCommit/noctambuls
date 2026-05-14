import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/fetch_participated_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/fetch_session_history_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/retry_session_sync_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_own_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_participated_sessions_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_state.dart';

class SessionListBloc extends Bloc<SessionListEvent, SessionListState> {
  SessionListBloc({
    required this.watchOwnSessionsUseCase,
    required this.watchParticipatedSessionsUseCase,
    required this.fetchSessionHistoryUseCase,
    required this.fetchParticipatedSessionsUseCase,
    required this.syncPendingSessionsUseCase,
    required this.retrySessionSyncUseCase,
    required this.logger,
  }) : super(const SessionListInitial()) {
    on<SessionListStarted>(_onStarted);
    on<OwnSessionsUpdated>(_onOwnSessionsUpdated);
    on<ParticipatedSessionsUpdated>(_onParticipatedSessionsUpdated);
    on<FetchHistoryRequested>(_onFetchHistory);
    on<FetchParticipatedRequested>(_onFetchParticipated);
    on<HistoryScrollReachedEnd>(_onHistoryScrollEnd);
    on<ParticipatedScrollReachedEnd>(_onParticipatedScrollEnd);
    on<SyncAllPendingRequested>(_onSyncAllPending);
    on<RetrySyncSessionRequested>(_onRetrySync);
  }

  final WatchOwnSessionsUseCase watchOwnSessionsUseCase;
  final WatchParticipatedSessionsUseCase watchParticipatedSessionsUseCase;
  final FetchSessionHistoryUseCase fetchSessionHistoryUseCase;
  final FetchParticipatedSessionsUseCase fetchParticipatedSessionsUseCase;
  final SyncPendingSessionsUseCase syncPendingSessionsUseCase;
  final RetrySessionSyncUseCase retrySessionSyncUseCase;
  final IAppLogger logger;

  StreamSubscription<List<ObservationSession>>? _ownSubscription;
  StreamSubscription<List<ObservationSession>>? _participatedSubscription;

  Future<void> _onStarted(
    SessionListStarted event,
    Emitter<SessionListState> emit,
  ) async {
    emit(const SessionListData());

    await _ownSubscription?.cancel();
    _ownSubscription = watchOwnSessionsUseCase(event.annotatorId).listen(
      (sessions) => add(OwnSessionsUpdated(sessions)),
      onError: (Object error) => logger.warning(error.toString()),
    );

    await _participatedSubscription?.cancel();
    _participatedSubscription =
        watchParticipatedSessionsUseCase(event.annotatorId).listen(
          (sessions) => add(ParticipatedSessionsUpdated(sessions)),
          onError: (Object error) => logger.warning(error.toString()),
        );
  }

  void _onOwnSessionsUpdated(
    OwnSessionsUpdated event,
    Emitter<SessionListState> emit,
  ) {
    final current = _data;
    if (current == null) return;
    emit(current.copyWith(ownSessions: event.sessions));
  }

  void _onParticipatedSessionsUpdated(
    ParticipatedSessionsUpdated event,
    Emitter<SessionListState> emit,
  ) {
    final current = _data;
    if (current == null) return;
    emit(current.copyWith(participatedSessions: event.sessions));
  }

  Future<void> _onFetchHistory(
    FetchHistoryRequested event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null || current.isLoadingHistory) return;

    emit(current.copyWith(isLoadingHistory: true, historyError: null));

    final result = await fetchSessionHistoryUseCase(refresh: event.isRefresh);

    result.when(
      success: (meta) {
        emit(
          _data!.copyWith(
            isLoadingHistory: false,
            hasMoreHistory: meta.hasMore,
            historyError: null,
          ),
        );
      },
      failure: (failure) {
        logger.warning(failure.debugMessage);
        emit(
          _data!.copyWith(
            isLoadingHistory: false,
            historyError: failure,
          ),
        );
      },
    );
  }

  Future<void> _onFetchParticipated(
    FetchParticipatedRequested event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null || current.isLoadingParticipated) return;

    emit(current.copyWith(isLoadingParticipated: true, participatedError: null));

    final result = await fetchParticipatedSessionsUseCase(
      refresh: event.isRefresh,
    );

    result.when(
      success: (meta) {
        emit(
          _data!.copyWith(
            isLoadingParticipated: false,
            hasMoreParticipated: meta.hasMore,
            participatedError: null,
          ),
        );
      },
      failure: (failure) {
        logger.warning(failure.debugMessage);
        emit(
          _data!.copyWith(
            isLoadingParticipated: false,
            participatedError: failure,
          ),
        );
      },
    );
  }

  Future<void> _onHistoryScrollEnd(
    HistoryScrollReachedEnd event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null ||
        current.isLoadingHistory ||
        !current.hasMoreHistory) {
      return;
    }
    await _onFetchHistory(const FetchHistoryRequested(), emit);
  }

  Future<void> _onParticipatedScrollEnd(
    ParticipatedScrollReachedEnd event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null ||
        current.isLoadingParticipated ||
        !current.hasMoreParticipated) {
      return;
    }
    await _onFetchParticipated(const FetchParticipatedRequested(), emit);
  }

  Future<void> _onSyncAllPending(
    SyncAllPendingRequested event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null || current.isSyncing) return;

    emit(current.copyWith(isSyncing: true, syncError: null));

    final result = await syncPendingSessionsUseCase();

    result.when(
      success: (_) => emit(_data!.copyWith(isSyncing: false, syncError: null)),
      failure: (failure) {
        logger.warning(failure.debugMessage);
        emit(_data!.copyWith(isSyncing: false, syncError: failure));
      },
    );
  }

  Future<void> _onRetrySync(
    RetrySyncSessionRequested event,
    Emitter<SessionListState> emit,
  ) async {
    final current = _data;
    if (current == null || current.isSyncing) return;

    emit(current.copyWith(isSyncing: true, syncError: null));

    final result = await retrySessionSyncUseCase(event.sessionId);

    result.when(
      success: (_) => emit(_data!.copyWith(isSyncing: false, syncError: null)),
      failure: (failure) {
        logger.warning(failure.debugMessage);
        emit(_data!.copyWith(isSyncing: false, syncError: failure));
      },
    );
  }

  SessionListData? get _data {
    final s = state;
    return s is SessionListData ? s : null;
  }

  @override
  Future<void> close() async {
    await _ownSubscription?.cancel();
    await _participatedSubscription?.cancel();
    return super.close();
  }
}
