import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionReviewState extends Equatable {
  const SessionReviewState();

  @override
  List<Object?> get props => [];
}

final class SessionReviewEditing extends SessionReviewState {
  const SessionReviewEditing({required this.session, this.isSaving = false});

  final ObservationSession session;
  final bool isSaving;

  @override
  List<Object?> get props => [session, isSaving];
}

final class SessionReviewFinalized extends SessionReviewState {}

final class SessionReviewDeleted extends SessionReviewState {}

final class SessionReviewError extends SessionReviewState {
  const SessionReviewError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
