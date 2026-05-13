import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/validation_failures.dart';

sealed class SessionReviewState extends Equatable {
  const SessionReviewState();

  @override
  List<Object?> get props => [];
}

final class SessionReviewEditing extends SessionReviewState {
  const SessionReviewEditing({
    required this.session,
    required this.birdsMap,
    this.isSaving = false,
    this.validationError,
  });

  final ObservationSession session;
  final bool isSaving;
  final SessionValidationFailure? validationError;
  final Map<String, Bird> birdsMap;

  bool get isValid => validationError == null;

  SessionReviewEditing copyWith({
    ObservationSession? session,
    Map<String, Bird>? birdsMap,
    bool? isSaving,
    SessionValidationFailure? validationError,
    bool clearError = false,
  }) {
    return SessionReviewEditing(
      session: session ?? this.session,
      birdsMap: birdsMap ?? this.birdsMap,
      isSaving: isSaving ?? this.isSaving,
      validationError: clearError
          ? null
          : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [session, isSaving, validationError, birdsMap];
}

final class SessionReviewFinalized extends SessionReviewState {}

final class SessionReviewDeleted extends SessionReviewState {}

final class SessionReviewError extends SessionReviewState {
  const SessionReviewError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
