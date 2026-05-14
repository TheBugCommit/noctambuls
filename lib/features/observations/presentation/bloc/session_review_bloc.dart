import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/finish_and_lock_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/remove_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_session_by_id_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_state.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';

class SessionReviewBloc extends Bloc<SessionReviewEvent, SessionReviewState> {
  SessionReviewBloc({
    required ObservationSession initialSession,
    required this.watchSessionByIdUseCase,
    required this.getBirdsUseCase,
    required this.getLanguageUseCase,
    required this.updateSessionPropertiesUseCase,
    required this.deleteSessionUseCase,
    required this.finishAndLockSessionUseCase,
    required this.addSessionParticipantUseCase,
    required this.removeSessionParticipantUseCase,
    required this.syncPendingSessionsUseCase,
  }) : super(
         SessionReviewEditing(session: initialSession, birdsMap: const {}),
       ) {
    on<ReviewUpdateProperties>(_onUpdateProperties);
    on<ReviewFinalizeSession>(_onFinalizeSession);
    on<ReviewValidateData>(_onValidateData);
    on<ReviewDeleteSession>(_onDeleteSession);
    on<ReviewAddParticipant>(_onAddParticipant);
    on<ReviewRemoveParticipant>(_onRemoveParticipant);
    on<ReviewSessionStreamUpdated>(_onStreamUpdated);

    unawaited(_initReactivity(initialSession.id));
  }

  final UpdateSessionPropertiesUseCase updateSessionPropertiesUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final FinishAndLockSessionUseCase finishAndLockSessionUseCase;
  final AddSessionParticipantUseCase addSessionParticipantUseCase;
  final RemoveSessionParticipantUseCase removeSessionParticipantUseCase;
  final WatchSessionByIdUseCase watchSessionByIdUseCase;
  final GetBirdsUseCase getBirdsUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  final SyncPendingSessionsUseCase syncPendingSessionsUseCase;

  StreamSubscription<ObservationSession?>? _subscription;
  Map<String, Bird> _birdsMap = {};

  Future<void> _initReactivity(String sessionId) async {
    final langCode = getLanguageUseCase().toLanguageCode;
    final result = await getBirdsUseCase(langCode);
    result.when(
      success: (birds) {
        _birdsMap = {for (final b in birds) b.id: b};
        if (state is SessionReviewEditing) {
          add(
            ReviewSessionStreamUpdated((state as SessionReviewEditing).session),
          );
        }
      },
      failure: (_) {},
    );

    _subscription = watchSessionByIdUseCase(sessionId).listen((session) {
      if (session != null) {
        add(ReviewSessionStreamUpdated(session));
      } else {
        add(ReviewDeleteSession());
      }
    });
  }

  void _onStreamUpdated(
    ReviewSessionStreamUpdated event,
    Emitter<SessionReviewState> emit,
  ) {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    _runValidation(event.session, emit, currentState);
  }

  Future<void> _onUpdateProperties(
    ReviewUpdateProperties event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentSession = (state as SessionReviewEditing).session;
    final currentState = state as SessionReviewEditing;

    final result = await updateSessionPropertiesUseCase(
      sessionId: currentSession.id,
      temperature: event.temperature,
      wind: event.wind,
      sky: event.sky,
      rain: event.rain,
      visibility: event.visibility,
      moon: event.moon,
      listeningPoint: event.listeningPoint,
      location: event.location,
    );

    result.when(
      success: (updatedSession) {},
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(currentState.copyWith(isSaving: false));
      },
    );
  }

  Future<void> _onValidateData(
    ReviewValidateData event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final current = state as SessionReviewEditing;
    _runValidation(current.session, emit, current);
  }

  Future<void> _onFinalizeSession(
    ReviewFinalizeSession event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    if (!currentState.isValid) return;

    final result = await finishAndLockSessionUseCase(currentState.session);
    unawaited(syncPendingSessionsUseCase());

    result.when(
      success: (_) => emit(SessionReviewFinalized()),
      failure: (failure) => emit(SessionReviewError(failure)),
    );
  }

  Future<void> _onDeleteSession(
    ReviewDeleteSession event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    final result = await deleteSessionUseCase(currentState.session.id);
    result.when(
      success: (_) => emit(SessionReviewDeleted()),
      failure: (failure) => emit(SessionReviewError(failure)),
    );
  }

  Future<void> _onAddParticipant(
    ReviewAddParticipant event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    emit(currentState.copyWith(isSaving: true));

    final result = await addSessionParticipantUseCase(
      currentState.session,
      event.code,
    );

    result.when(
      success: (_) {},
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(currentState.copyWith(isSaving: false));
      },
    );
  }

  Future<void> _onRemoveParticipant(
    ReviewRemoveParticipant event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    emit(currentState.copyWith(isSaving: true));

    final result = await removeSessionParticipantUseCase(
      currentState.session,
      event.code,
    );

    result.when(
      success: (_) {},
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(currentState.copyWith(isSaving: false));
      },
    );
  }

  void _runValidation(
    ObservationSession session,
    Emitter<SessionReviewState> emit,
    SessionReviewEditing currentState,
  ) {
    final validationError = session.validateFinalization();

    emit(
      currentState.copyWith(
        session: session,
        birdsMap: _birdsMap,
        isSaving: false,
        validationError: validationError,
        clearError: validationError == null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
