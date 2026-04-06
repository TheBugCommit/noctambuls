import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/exceptions/active_session_already_exists_exception.dart';
import 'package:uuid/uuid.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';

class SessionLifecycleBloc
    extends Bloc<SessionLifecycleEvent, SessionLifecycleState> {
  SessionLifecycleBloc({
    required this.watchActiveSessionUseCase,
    required this.createSessionUseCase,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
  }) : super(const SessionLifecycleIdle()) {
    on<WatchSession>(_onWatchSession);
    on<SessionStreamUpdated>(_onSessionStreamUpdated);
    on<StartNewSession>(_onStartNewSession);
    on<UpdateSessionProperties>(_onUpdateSessionProperties);
    on<StopObservationPhase>(_onStopObservationPhase);
    on<ResumeObservationPhase>(_onResumeObservationPhase);
    on<FinishAndLockSession>(_onFinishAndLockSession);
    on<DeleteActiveSession>(_onDeleteActiveSession);
    on<DismissError>(_onDismissError);
  }

  final WatchActiveSessionUseCase watchActiveSessionUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final UpdateSessionUseCase updateSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;

  StreamSubscription<ObservationSession?>? _sessionSubscription;

  SessionLifecycleState _stateFromSession(ObservationSession session) {
    if (session.isObserving) return SessionObserving(session: session);
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
    emit(_stateFromSession(event.session!));
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
    try {
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
      await createSessionUseCase(session);
    } on ActiveSessionAlreadyExistsException {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.sessionAlreadyExists,
        ),
      );
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
  }

  Future<void> _onUpdateSessionProperties(
    UpdateSessionProperties event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! ActiveSessionLifecycleState) return;
    final current = (state as ActiveSessionLifecycleState).session;

    try {
      final updated = current.copyWith(
        weatherNotes: event.weatherNotes ?? current.weatherNotes,
        latitude: event.latitude ?? current.latitude,
        longitude: event.longitude ?? current.longitude,
        updatedAt: DateTime.now(),
      );

      await updateSessionUseCase(updated);
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
  }

  Future<void> _onStopObservationPhase(
    StopObservationPhase event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionObserving) return;
    final current = (state as SessionObserving).session;

    try {
      final now = DateTime.now();
      final updated = current.copyWith(
        endTime: now,
        updatedAt: now,
      );
      await updateSessionUseCase(updated);
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
  }

  Future<void> _onResumeObservationPhase(
    ResumeObservationPhase event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionReviewing) return;
    final current = (state as SessionReviewing).session;

    try {
      final updated = current.copyWith(
        endTime: null,
        updatedAt: DateTime.now(),
      );
      await updateSessionUseCase(updated);
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
  }

  Future<void> _onFinishAndLockSession(
    FinishAndLockSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! SessionReviewing) return;
    final current = (state as SessionReviewing).session;

    try {
      final updated = current.copyWith(
        isLocked: true,
        updatedAt: DateTime.now(),
      );
      await updateSessionUseCase(updated);
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
  }

  Future<void> _onDeleteActiveSession(
    DeleteActiveSession event,
    Emitter<SessionLifecycleState> emit,
  ) async {
    if (state is! ActiveSessionLifecycleState) return;
    final current = (state as ActiveSessionLifecycleState).session;

    emit(const SessionLifecycleLoading());
    try {
      await deleteSessionUseCase(current.id);
    } on Object catch (_) {
      emit(
        const SessionLifecycleError(
          errorType: SessionLifecycleErrorType.unknown,
        ),
      );
    }
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
