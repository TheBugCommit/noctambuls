import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';

sealed class SessionObservationEvent extends Equatable {
  const SessionObservationEvent();

  @override
  List<Object?> get props => [];
}

/// Start watching observations
class WatchObservations extends SessionObservationEvent {}

/// Stream updated (datasource) event
class ObservationsStreamUpdated extends SessionObservationEvent {
  const ObservationsStreamUpdated(this.observations);

  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [observations];
}

/// Add observation event
class AddRecord extends SessionObservationEvent {
  const AddRecord(this.record);

  final ObservationRecord record;

  @override
  List<Object?> get props => [record];
}

/// Update observation event
class UpdateRecord extends SessionObservationEvent {
  const UpdateRecord(this.record);

  final ObservationRecord record;

  @override
  List<Object?> get props => [record];
}

/// Delete observation event
class DeleteRecord extends SessionObservationEvent {
  const DeleteRecord(this.recordId);

  final String recordId;

  @override
  List<Object?> get props => [recordId];
}

/// Updates the date of all current observations (incidental sessions only).
/// Preserves each observation's time components (hour, minute).
class UpdateAllObservationsDate extends SessionObservationEvent {
  const UpdateAllObservationsDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}
