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
    this.censusId,
  });

  final SessionType sessionType;
  final String annotatorId;
  final String? censusId;

  @override
  List<Object?> get props => [sessionType, annotatorId, censusId];
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

class DeleteObservingRecord extends ObservingSessionEvent {
  const DeleteObservingRecord(this.recordId);

  final String recordId;

  @override
  List<Object?> get props => [recordId];
}

/// Transition event to SessionReviewing
class StopObservingSession extends ObservingSessionEvent {}

/// Delete active session event
class DeleteObservingSession extends ObservingSessionEvent {}

/// Changes the globally selected observation date for incidental sessions.
class ChangeSessionDate extends ObservingSessionEvent {
  const ChangeSessionDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class DismissObservingError extends ObservingSessionEvent {}

class ObservingBirdsReloadRequested extends ObservingSessionEvent {
  const ObservingBirdsReloadRequested();
}
