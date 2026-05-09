import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionReviewState extends Equatable {
  const SessionReviewState();

  @override
  List<Object?> get props => [];
}

final class SessionReviewEditing extends SessionReviewState {
  const SessionReviewEditing({
    required this.session,
    this.isSaving = false,
    this.missingObservationLocationIds = const {},
    this.showSessionLocationError = false,
    this.showListeningPointError = false,
  });

  final ObservationSession session;
  final bool isSaving;

  final Set<String> missingObservationLocationIds;
  final bool showSessionLocationError;
  final bool showListeningPointError;

  bool get isValid =>
      !showSessionLocationError &&
      !showListeningPointError &&
      missingObservationLocationIds.isEmpty;

  SessionReviewEditing copyWith({
    ObservationSession? session,
    bool? isSaving,
    Set<String>? missingObservationLocationIds,
    bool? showSessionLocationError,
    bool? showListeningPointError,
  }) {
    return SessionReviewEditing(
      session: session ?? this.session,
      isSaving: isSaving ?? this.isSaving,
      missingObservationLocationIds:
          missingObservationLocationIds ?? this.missingObservationLocationIds,
      showSessionLocationError:
          showSessionLocationError ?? this.showSessionLocationError,
      showListeningPointError:
          showListeningPointError ?? this.showListeningPointError,
    );
  }

  @override
  List<Object?> get props => [
    session,
    isSaving,
    missingObservationLocationIds,
    showSessionLocationError,
    showListeningPointError,
  ];
}

final class SessionReviewFinalized extends SessionReviewState {}

final class SessionReviewDeleted extends SessionReviewState {}

final class SessionReviewError extends SessionReviewState {
  const SessionReviewError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
