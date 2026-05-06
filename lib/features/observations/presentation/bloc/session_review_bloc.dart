import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';

import 'session_review_event.dart';
import 'session_review_state.dart';

class SessionReviewBloc extends Bloc<SessionReviewEvent, SessionReviewState> {
  SessionReviewBloc({
    required ObservationSession initialSession,
    required this.updateSessionUseCase,
    required this.deleteSessionUseCase,
  }) : super(SessionReviewEditing(session: initialSession)) {
    on<ReviewUpdateProperties>(_onUpdateProperties);
    on<ReviewFinalizeSession>(_onFinalizeSession);
    on<ReviewDeleteSession>(_onDeleteSession);
  }

  final UpdateSessionUseCase updateSessionUseCase;
  final DeleteSessionUseCase deleteSessionUseCase;

  Future<void> _onUpdateProperties(
    ReviewUpdateProperties event,
    Emitter<SessionReviewState> emit,
  ) async {
    if (state is! SessionReviewEditing) return;
    final currentSession = (state as SessionReviewEditing).session;

    emit(SessionReviewEditing(session: currentSession, isSaving: true));

    // 1. Apliquem els canvis localment
    final updatedSession = currentSession.copyWith(
      temperature: event.temperature ?? currentSession.temperature,
      wind: event.wind ?? currentSession.wind,
      sky: event.sky ?? currentSession.sky,
      rain: event.rain ?? currentSession.rain,
      visibility: event.visibility ?? currentSession.visibility,
      moon: event.moon ?? currentSession.moon,
      listeningPoint: event.listeningPoint ?? currentSession.listeningPoint,
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
    final currentSession = (state as SessionReviewEditing).session;

    final updatedSession = currentSession.copyWith(
      isLocked: true,
      syncStatus: SyncStatus.pending,
      updatedAt: DateTime.now(),
    );

    final result = await updateSessionUseCase(updatedSession);
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
}
