import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';

sealed class SessionLifecycleEvent extends Equatable {
  const SessionLifecycleEvent();

  @override
  List<Object?> get props => [];
}

/// Start watching active session event
class WatchSession extends SessionLifecycleEvent {}

/// Stream updated (datasource) event
class SessionStreamUpdated extends SessionLifecycleEvent {
  const SessionStreamUpdated(this.session);

  final ObservationSession? session;

  @override
  List<Object?> get props => [session];
}

/// Crea una nova sessió del tipus indicat.
/// La construcció de l'entitat (UUID, timestamps) es fa al BLoC.
class StartNewSession extends SessionLifecycleEvent {
  const StartNewSession({
    required this.sessionType,
    required this.annotatorId,
  });

  final SessionType sessionType;
  final String annotatorId;

  @override
  List<Object?> get props => [sessionType, annotatorId];
}

/// Updates any session property event
class UpdateSessionProperties extends SessionLifecycleEvent {
  const UpdateSessionProperties({
    this.weatherNotes,
    this.latitude,
    this.longitude,
  });

  final String? weatherNotes;
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [weatherNotes, latitude, longitude];
}

/// Transition event to SessionReviewing
class StopObservationPhase extends SessionLifecycleEvent {}

/// Transition event from SessionReviewing back to SessionObserving
class ResumeObservationPhase extends SessionLifecycleEvent {}

/// Transition event to SessionFinished
class FinishAndLockSession extends SessionLifecycleEvent {}

/// Delete active session event
class DeleteActiveSession extends SessionLifecycleEvent {}

/// Dismiss an error an returns to SessionLifecycleIdle event
class DismissError extends SessionLifecycleEvent {}
