import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

enum SessionLifecycleErrorType {
  sessionAlreadyExists,
  unknown,
}

sealed class SessionLifecycleState extends Equatable {
  const SessionLifecycleState();
}

/// No existent active session
final class SessionLifecycleIdle extends SessionLifecycleState {
  const SessionLifecycleIdle();

  @override
  List<Object?> get props => [];
}

/// Transition event for create, update or delete events
final class SessionLifecycleLoading extends SessionLifecycleState {
  const SessionLifecycleLoading();

  @override
  List<Object?> get props => [];
}

sealed class ActiveSessionLifecycleState extends SessionLifecycleState {
  const ActiveSessionLifecycleState({required this.session});

  final ObservationSession session;
}

/// Active session isObserving
final class SessionObserving extends ActiveSessionLifecycleState {
  const SessionObserving({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Active session isReviewing
final class SessionReviewing extends ActiveSessionLifecycleState {
  const SessionReviewing({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Active session isFinished (Locked)
final class SessionFinished extends ActiveSessionLifecycleState {
  const SessionFinished({required super.session});

  @override
  List<Object?> get props => [session];
}

/// Session state error
final class SessionLifecycleError extends SessionLifecycleState {
  const SessionLifecycleError({required this.errorType});

  final SessionLifecycleErrorType errorType;

  @override
  List<Object?> get props => [errorType];
}
