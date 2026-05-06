import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';
import 'package:uuid/uuid.dart';

class SessionLifecycleBloc
    extends Bloc<SessionLifecycleEvent, SessionLifecycleState> {
  SessionLifecycleBloc({
    required this.watchActiveSessionUseCase,
    required this.createSessionUseCase,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
    required this.logger,
  }) : super(const SessionLifecycleIdle()) {
    on<WatchSession>(_onWatchSession);
    on<SessionStreamUpdated>(_onSessionStreamUpdated);
    on<StartNewSession>(_onStartNewSession);
    on<UpdateSessionProperties>(_onUpdateSessionProperties);
    on<StopObservationPhase>(_onStopObservationPhase);
    on<ResumeObservationPhase>(_onResumeObservationPhase);
    on<FinishAndLockSession>(_onFinishAndLockSession);
    on<DeleteSession>(_onDeleteSession);
    on<ChangeObservationDate>(_onChangeObservationDate);
    on<DismissError>(_onDismissError);
  }

  final WatchActiveSessionUseCase watchActiveSessionUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final UpdateSessionUseCase updateSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final IAppLogger logger;

  StreamSubscription<ObservationSession?>? _sessionSubscription;

  SessionLifecycleState _stateFromSession(
    ObservationSession session, {
    DateTime? selectedObservationDate,
  }) {
    if (session.isObserving) {
      return SessionObserving(
        session: session,
        selectedObservationDate: selectedObservationDate,
      );
    }
    if (session.isReviewing) return SessionReviewing(session: session);
    return SessionFinished(session: session);
  }

  Future<void> _onWatchSession(
    WatchSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    await _sessionSubscription?.cancel();
    _sessionSubscription = watchActiveSessionUseCase().listen(
      (session) => add(SessionStreamUpdated(session)),
      onError: (Object error, StackTrace stackTrace) {
        addError(error, stackTrace);
      },
    );
  }

  Future<void> _onSessionStreamUpdated(
    SessionStreamUpdated event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (event.session == null) {
      emit(const SessionLifecycleIdle());
      return;
    }
    final preservedDate = state is SessionObserving
        ? (state as SessionObserving).selectedObservationDate
        : null;
    emit(_stateFromSession(event.session!, selectedObservationDate: preservedDate));
  }

  Future<void> _onStartNewSession(
    StartNewSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is ActiveSessionLifecycleState ||
        state is SessionLifecycleLoading) {
      return;
    }

    emit(const SessionLifecycleLoading());
    const uuid = Uuid();
    final now = DateTime.now();
    final session = ObservationSession(
      id: uuid.v4(),
      annotatorId: event.annotatorId,
      sessionType: event.sessionType,
      startTime: now,
      createdAt: now,
      updatedAt: now,
    );

    final result = await createSessionUseCase(session);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onUpdateSessionProperties(
    UpdateSessionProperties event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! ActiveSessionLifecycleState) return;
    final current = (state as ActiveSessionLifecycleState).session;

    final updated = current.copyWith(
      temperature: event.temperature ?? current.temperature,
      wind: event.wind ?? current.wind,
      sky: event.sky ?? current.sky,
      rain: event.rain ?? current.rain,
      visibility: event.visibility ?? current.visibility,
      moon: event.moon ?? current.moon,
      listeningPoint: event.listeningPoint ?? current.listeningPoint,
      latitude: event.latitude ?? current.latitude,
      longitude: event.longitude ?? current.longitude,
      updatedAt: DateTime.now(),
    );

    final result = await updateSessionUseCase(updated);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onStopObservationPhase(
    StopObservationPhase event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionObserving) return;
    final current = (state as SessionObserving).session;

    final now = DateTime.now();
    final updated = current.copyWith(endTime: now, updatedAt: now);

    final result = await updateSessionUseCase(updated);
    result.when(
      success: (_) {
        emit(SessionNavigatingToReview(session: updated));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onResumeObservationPhase(
    ResumeObservationPhase event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionReviewing) return;
    final current = (state as SessionReviewing).session;

    final updated = current.copyWith(endTime: null, updatedAt: DateTime.now());

    final result = await updateSessionUseCase(updated);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onFinishAndLockSession(
    FinishAndLockSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionReviewing) return;
    final current = (state as SessionReviewing).session;

    final updated = current.copyWith(
      isLocked: true,
      syncStatus: SyncStatus.pending,
      updatedAt: DateTime.now(),
    );

    final result = await updateSessionUseCase(updated);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onDeleteSession(
    DeleteSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! ActiveSessionLifecycleState) return;
    final current = (state as ActiveSessionLifecycleState).session;

    emit(const SessionLifecycleLoading());
    final result = await deleteSessionUseCase(current.id);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  Future<void> _onChangeObservationDate(
    ChangeObservationDate event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionObserving) return;
    final current = state as SessionObserving;
    if (!current.session.canEditObservationDate) return;

    final d = event.date;
    final oldStart = current.session.startTime;
    final newStartTime = oldStart != null
        ? DateTime(d.year, d.month, d.day, oldStart.hour, oldStart.minute)
        : DateTime(d.year, d.month, d.day);

    final now = DateTime.now();
    final updatedSession = current.session.copyWith(
      startTime: newStartTime,
      updatedAt: now,
    );

    final result = await updateSessionUseCase(updatedSession);
    result.when(
      success: (_) {
        emit(SessionObserving(
          session: updatedSession,
          selectedObservationDate: event.date,
        ));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );
  }

  void _onDismissError(
    DismissError event,
    Emitter<SessionLifecycleState> emit,
  ) {
    if (state is SessionLifecycleError) emit(const SessionLifecycleIdle());
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    return super.close();
  }
}
