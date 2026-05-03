import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionLifecycleState extends Equatable {
  const SessionLifecycleState();
}

/// No active session exists.
final class SessionLifecycleIdle extends SessionLifecycleState {
  const SessionLifecycleIdle();

  @override
  List<Object?> get props => [];
}

/// Transition state for create, update or delete operations.
final class SessionLifecycleLoading extends SessionLifecycleState {
  const SessionLifecycleLoading();

  @override
  List<Object?> get props => [];
}

sealed class ActiveSessionLifecycleState extends SessionLifecycleState {
  const ActiveSessionLifecycleState({required this.session});

  final ObservationSession session;
}

/// Active session in observation phase.
final class SessionObserving extends ActiveSessionLifecycleState {
  const SessionObserving({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Active session in review phase.
final class SessionReviewing extends ActiveSessionLifecycleState {
  const SessionReviewing({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Active session finished (locked).
final class SessionFinished extends ActiveSessionLifecycleState {
  const SessionFinished({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Session operation failure state.
final class SessionLifecycleError extends SessionLifecycleState {
  const SessionLifecycleError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
