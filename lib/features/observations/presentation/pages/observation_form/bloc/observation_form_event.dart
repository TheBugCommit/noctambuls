import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';

sealed class ObservationFormEvent extends Equatable {
  const ObservationFormEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFormDataRequested extends ObservationFormEvent {
  const LoadFormDataRequested({required this.langCode, this.existingLocation});

  final String langCode;
  final GeoPosition? existingLocation;

  @override
  List<Object?> get props => [langCode, existingLocation];
}

final class FormLocationUpdated extends ObservationFormEvent {
  const FormLocationUpdated(this.position);

  final GeoPosition position;

  @override
  List<Object?> get props => [position];
}

final class FormLocationErrorOccurred extends ObservationFormEvent {
  const FormLocationErrorOccurred(this.error);

  final LocationErrorType error;

  @override
  List<Object?> get props => [error];
}

final class ClearLocationRequested extends ObservationFormEvent {
  const ClearLocationRequested();
}

final class SaveObservationRequested extends ObservationFormEvent {
  const SaveObservationRequested({
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.quantity,
    required this.bearing,
    required this.startTime,
    required this.endTime,
    this.location,
    this.locationError,
    this.notes,
    this.existingRecord,
  });

  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final double bearing;
  final String? notes;
  final ObservationRecord? existingRecord;
  final GeoPosition? location;
  final LocationErrorType? locationError;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object?> get props => [
    sessionId,
    speciesId,
    contactType,
    quantity,
    notes,
    bearing,
    existingRecord,
    location,
    locationError,
    startTime,
    endTime,
  ];
}
