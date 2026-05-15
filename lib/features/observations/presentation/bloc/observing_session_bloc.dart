import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_session_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/stop_observation_phase_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_location_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';

class ObservingSessionBloc
    extends Bloc<ObservingSessionEvent, ObservingSessionState> {
  ObservingSessionBloc({
    required this.watchActiveSessionUseCase,
    required this.createSessionUseCase,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
    required this.stopObservationPhaseUseCase,
    required this.changeSessionDateUseCase,
    required this.updateSessionLocationUseCase,
    required this.deleteObservationUseCase,
    required this.getBirdsUseCase,
    required this.getLanguageUseCase,
    required this.logger,
  }) : super(const ObservingSessionIdle()) {
    on<WatchObservingSession>(_onWatchSession);
    on<ObservingSessionStreamUpdated>(_onSessionStreamUpdated);
    on<StartObservingSession>(_onStartNewSession);
    on<UpdateObservingSessionLocation>(_onUpdateSessionLocation);
    on<StopObservingSession>(_onStopObservationPhase);
    on<DeleteObservingSession>(_onDeleteSession);
    on<ChangeSessionDate>(_onChangeSessionDate);
    on<DeleteObservingRecord>(_onDeleteRecord);
    on<DismissObservingError>(_onDismissError);
    on<ObservingBirdsReloadRequested>(_onReloadBirds);
  }

  final WatchActiveSessionUseCase watchActiveSessionUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final UpdateSessionPropertiesUseCase updateSessionUseCase;
  final UpdateSessionLocationUseCase updateSessionLocationUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final StopObservationPhaseUseCase stopObservationPhaseUseCase;
  final ChangeSessionDateUseCase changeSessionDateUseCase;
  final DeleteObservationUseCase deleteObservationUseCase;
  final GetBirdsUseCase getBirdsUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  final IAppLogger logger;

  Map<String, Bird> _birdsMap = {};
  StreamSubscription<ObservationSession?>? _sessionSubscription;

  Future<void> _onWatchSession(
    WatchObservingSession event,
    Emitter<ObservingSessionState> emit,
  ) async {
    final langCode = getLanguageUseCase().toLanguageCode;
    final result = await getBirdsUseCase(langCode);
    result.when(
      success: (birds) => _birdsMap = {for (final b in birds) b.id: b},
      failure: logger.failure,
    );

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

    if (event.session!.isObserving) {
      emit(
        ObservingSessionActive(
          session: event.session!,
          birdsMap: _birdsMap,
        ),
      );
    } else {
      emit(const ObservingSessionIdle());
    }
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
      censusId: event.censusId,
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
    if (state is! ObservingSessionActive) return;
    final currentSession = (state as ObservingSessionActive).session;

    final result = await updateSessionLocationUseCase(
      sessionId: currentSession.id,
      location: event.geoPosition,
    );

    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
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

  Future<void> _onChangeSessionDate(
    ChangeSessionDate event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ObservingSessionActive) return;
    final current = state as ObservingSessionActive;
    if (!current.session.canEditObservationDate) return;

    final result = await changeSessionDateUseCase(
      sessionId: current.session.id,
      newDate: event.date,
    );

    result.when(
      success: (updatedSession) {
        emit(
          ObservingSessionActive(
            session: updatedSession,
            birdsMap: _birdsMap,
          ),
        );
      },
      failure: (failure) {
        logger.failure(failure);
        emit(ObservingSessionError(failure: failure));
      },
    );
  }

  Future<void> _onDeleteRecord(
    DeleteObservingRecord event,
    Emitter<ObservingSessionState> emit,
  ) async {
    if (state is! ObservingSessionActive) return;
    final currentSession = (state as ObservingSessionActive).session;

    final result = await deleteObservationUseCase(
      currentSession.id,
      event.recordId,
    );
    result.when(
      success: (_) {},
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

  Future<void> _onReloadBirds(
    ObservingBirdsReloadRequested event,
    Emitter<ObservingSessionState> emit,
  ) async {
    final langCode = getLanguageUseCase().toLanguageCode;
    final result = await getBirdsUseCase(langCode);

    result.when(
      success: (birds) {
        _birdsMap = {for (final b in birds) b.id: b};

        if (state is ObservingSessionActive) {
          final currentState = state as ObservingSessionActive;
          emit(
            ObservingSessionActive(
              session: currentState.session,
              birdsMap: _birdsMap,
            ),
          );
        }
      },
      failure: logger.failure,
    );
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    return super.close();
  }
}
