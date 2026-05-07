import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class ObservingSessionState extends Equatable {
  const ObservingSessionState();

  @override
  List<Object?> get props => [];
}

final class ObservingSessionIdle extends ObservingSessionState {
  const ObservingSessionIdle();
}

/// Transition state for create, update or delete operations.
final class ObservingSessionLoading extends ObservingSessionState {
  const ObservingSessionLoading();

  @override
  List<Object?> get props => [];
}

sealed class ActiveObservingState extends ObservingSessionState {
  const ActiveObservingState({required this.session});

  final ObservationSession session;

  @override
  List<Object?> get props => [session];
}

final class ObservingSessionNavigatingToReview extends ActiveObservingState {
  const ObservingSessionNavigatingToReview({required super.session});
}

/// Active session in observation phase.
final class ObservingSessionActive extends ActiveObservingState {
  const ObservingSessionActive({
    required super.session,
    this.selectedObservationDate,
  });

  /// User-selected global date for new observations (incidental only).
  /// Null means "use the default" (session.startTime ?? now).
  final DateTime? selectedObservationDate;

  @override
  List<Object?> get props => [session, selectedObservationDate];
}

/// Session operation failure state.
final class ObservingSessionError extends ObservingSessionState {
  const ObservingSessionError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
