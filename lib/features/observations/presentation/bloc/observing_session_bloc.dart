import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_observations_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/stop_observation_phase_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';

class ObservingSessionBloc
    extends Bloc<ObservingSessionEvent, ObservingSessionState> {
  ObservingSessionBloc({
    required this.watchActiveSessionUseCase,
    required this.createSessionUseCase,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
    required this.stopObservationPhaseUseCase,
    required this.changeObservationDateUseCase,
    required this.logger,
  }) : super(const ObservingSessionIdle()) {
    on<WatchObservingSession>(_onWatchSession);
    on<ObservingSessionStreamUpdated>(_onSessionStreamUpdated);
    on<StartObservingSession>(_onStartNewSession);
    on<UpdateObservingSessionLocation>(_onUpdateSessionLocation);
    on<StopObservingSession>(_onStopObservationPhase);
    on<DeleteObservingSession>(_onDeleteSession);
    on<ChangeObservingDate>(_onChangeObservationDate);
    on<DismissObservingError>(_onDismissError);
  }

  final WatchActiveSessionUseCase watchActiveSessionUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final UpdateSessionUseCase updateSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final StopObservationPhaseUseCase stopObservationPhaseUseCase;
  final ChangeObservationDateUseCase changeObservationDateUseCase;
  final IAppLogger logger;

  StreamSubscription<ObservationSession?>? _sessionSubscription;

  ObservingSessionState _stateFromSession(
    ObservationSession session, {
    DateTime? selectedObservationDate,
  }) {
    if (session.isObserving) {
      return ObservingSessionActive(
        session: session,
        selectedObservationDate: selectedObservationDate,
      );
    }

    return const ObservingSessionIdle();
  }

  Future<void> _onWatchSession(
    WatchObservingSession event,
    Emitter<ObservingSessionState> emit,
  ) async {
    await _sessionSubscription?.cancel();
    _sessionSubscription = watchActiveSessionUseCase().listen(
      (session) => add(ObservingSessionStreamUpdated(session)),
      onError: (Object error, StackTrace stackTrace) {
        addError(error, stackTrace);
      },
    );
  }

  Future<void> _onSessionStreamUpdated(
    ObservingSessionStreamUpdated event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (event.session == null) {
      emit(const ObservingSessionIdle());
      return;
    }
    final preservedDate = state is ObservingSessionActive
        ? (state as ObservingSessionActive).selectedObservationDate
        : null;
    emit(
      _stateFromSession(event.session!, selectedObservationDate: preservedDate),
    );
  }

  Future<void> _onStartNewSession(
    StartObservingSession event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is ActiveObservingState || state is ObservingSessionLoading) {
      return;
    }
    emit(const ObservingSessionLoading());
    final result = await createSessionUseCase(
      event.sessionType,
      event.annotatorId,
    );
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
  }

  Future<void> _onUpdateSessionLocation(
    UpdateObservingSessionLocation event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ActiveObservingState) return;
    //TODO: implementar
    /*final current = (state as ActiveSessionLifecycleState).session;

    final result = await updateSessionUseCase(updated);

    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(SessionLifecycleError(failure: failure));
      },
    );*/
  }

  Future<void> _onStopObservationPhase(
    StopObservingSession event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ObservingSessionActive) return;
    final current = (state as ObservingSessionActive).session;

    final result = await stopObservationPhaseUseCase(current);
    result.when(
      success: (updatedSession) {
        emit(ObservingSessionNavigatingToReview(session: updatedSession));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
  }

  Future<void> _onDeleteSession(
    DeleteObservingSession event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ActiveObservingState) return;
    final current = (state as ActiveObservingState).session;

    emit(const ObservingSessionLoading());
    final result = await deleteSessionUseCase(current.id);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
  }

  Future<void> _onChangeObservationDate(
    ChangeObservingDate event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ObservingSessionActive) return;
    final current = state as ObservingSessionActive;
    if (!current.session.canEditObservationDate) return;

    final result = await changeObservationDateUseCase(
      current.session,
      event.date,
    );

    result.when(
      success: (updatedSession) {
        emit(
          ObservingSessionActive(
            session: updatedSession,
            selectedObservationDate: event.date,
          ),
        );
      },
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
  }

  void _onDismissError(
    DismissObservingError event,
    Emitter<ObservingSessionState> emit,
  ) {
    if (state is ObservingSessionError) emit(const ObservingSessionIdle());
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    return super.close();
  }
}
