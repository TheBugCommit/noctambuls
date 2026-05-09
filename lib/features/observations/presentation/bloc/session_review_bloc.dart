import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/validation_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/finish_and_lock_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/remove_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/validate_session_finalization_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_state.dart';

class SessionReviewBloc extends Bloc<SessionReviewEvent, SessionReviewState> {
  SessionReviewBloc({
    required ObservationSession initialSession,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
    required this.finishAndLockSessionUseCase,
    required this.addSessionParticipantUseCase,
    required this.removeSessionParticipantUseCase,
    required this.validateSessionFinalizationUseCase,
  }) : super(SessionReviewEditing(session: initialSession)) {
    on<ReviewUpdateProperties>(_onUpdateProperties);
    on<ReviewFinalizeSession>(_onFinalizeSession);
    on<ReviewDeleteSession>(_onDeleteSession);
    on<ReviewAddParticipant>(_onAddParticipant);
    on<ReviewRemoveParticipant>(_onRemoveParticipant);
  }

  final UpdateSessionUseCase updateSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;
  final FinishAndLockSessionUseCase finishAndLockSessionUseCase;
  final AddSessionParticipantUseCase addSessionParticipantUseCase;
  final RemoveSessionParticipantUseCase removeSessionParticipantUseCase;
  final ValidateSessionFinalizationUseCase validateSessionFinalizationUseCase;

  Future<void> _onUpdateProperties(
    ReviewUpdateProperties event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentSession = (state as SessionReviewEditing).session;

    emit(SessionReviewEditing(session: currentSession, isSaving: true));

    final updatedSession = currentSession.copyWith(
      temperature: event.temperature ?? currentSession.temperature,
      wind: event.wind ?? currentSession.wind,
      sky: event.sky ?? currentSession.sky,
      rain: event.rain ?? currentSession.rain,
      visibility: event.visibility ?? currentSession.visibility,
      moon: event.moon ?? currentSession.moon,
      listeningPoint: event.listeningPoint ?? currentSession.listeningPoint,
      location: event.location ?? currentSession.location,
      updatedAt: DateTime.now(),
    );

    final result = await updateSessionUseCase(updatedSession);

    result.when(
      success: (_) {
        emit(SessionReviewEditing(session: updatedSession, isSaving: false));
      },
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(SessionReviewEditing(session: currentSession, isSaving: false));
      },
    );
  }

  Future<void> _onFinalizeSession(
    ReviewFinalizeSession event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentState = state as SessionReviewEditing;

    var hasValidationErrors = false;
    validateSessionFinalizationUseCase(
      session: currentState.session,
      observations: event.observations,
    ).when(
      success: (_) {
        hasValidationErrors = false;
      },
      failure: (failure) {
        hasValidationErrors = true;
        if (failure is SessionValidationFailure) {
          emit(
            currentState.copyWith(
              showSessionLocationError: failure.missingSessionLocation,
              missingObservationLocationIds:
                  failure.missingObservationLocationIds,
              showListeningPointError: failure.missingListeningPoint,
            ),
          );
        }
      },
    );

    if (hasValidationErrors) {
      return;
    }

    final result = await finishAndLockSessionUseCase(currentState.session);

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
    final currentSession = (state as SessionReviewEditing).session;

    final result = await deleteSessionUseCase(currentSession.id);
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
    final currentSession = (state as SessionReviewEditing).session;

    emit(SessionReviewEditing(session: currentSession, isSaving: true));

    final result = await addSessionParticipantUseCase(
      currentSession,
      event.code,
    );

    result.when(
      success: (updatedSession) {
        emit(SessionReviewEditing(session: updatedSession));
      },
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(SessionReviewEditing(session: currentSession));
      },
    );
  }

  Future<void> _onRemoveParticipant(
    ReviewRemoveParticipant event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentSession = (state as SessionReviewEditing).session;

    emit(SessionReviewEditing(session: currentSession, isSaving: true));

    final result = await removeSessionParticipantUseCase(
      currentSession,
      event.code,
    );

    result.when(
      success: (updatedSession) {
        emit(SessionReviewEditing(session: updatedSession));
      },
      failure: (failure) {
        emit(SessionReviewError(failure));
        emit(SessionReviewEditing(session: currentSession));
      },
    );
  }
}
