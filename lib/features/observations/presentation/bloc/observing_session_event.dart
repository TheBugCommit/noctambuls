import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';

sealed class ObservingSessionEvent extends Equatable {
  const ObservingSessionEvent();

  @override
  List<Object?> get props => [];
}

/// Start watching active session event
class WatchObservingSession extends ObservingSessionEvent {}

/// Stream updated (datasource) event
class ObservingSessionStreamUpdated extends ObservingSessionEvent {
  const ObservingSessionStreamUpdated(this.session);

  final ObservationSession? session;

  @override
  List<Object?> get props => [session];
}

/// Crea una nova sessió del tipus indicat.
class StartObservingSession extends ObservingSessionEvent {
  const StartObservingSession({
    required this.sessionType,
    required this.annotatorId,
  });

  final SessionType sessionType;
  final String annotatorId;

  @override
  List<Object?> get props => [sessionType, annotatorId];
}

/// Updates any session property event
class UpdateObservingSessionLocation extends ObservingSessionEvent {
  const UpdateObservingSessionLocation({
    required this.geoPosition,
  });

  final GeoPosition geoPosition;

  @override
  List<Object?> get props => [geoPosition];
}

/// Transition event to SessionReviewing
class StopObservingSession extends ObservingSessionEvent {}

/// Delete active session event
class DeleteObservingSession extends ObservingSessionEvent {}

/// Changes the globally selected observation date for incidental sessions.
class ChangeObservingDate extends ObservingSessionEvent {
  const ChangeObservingDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class DismissObservingError extends ObservingSessionEvent {}

class RetryObservingSessionLocation extends ObservingSessionEvent {}
