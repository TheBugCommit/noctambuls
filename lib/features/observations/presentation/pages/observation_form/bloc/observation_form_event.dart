import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';

sealed class ObservationFormEvent extends Equatable {
  const ObservationFormEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFormDataRequested extends ObservationFormEvent {
  const LoadFormDataRequested(this.langCode);

  final String langCode;

  @override
  List<Object?> get props => [langCode];
}

final class SaveObservationRequested extends ObservationFormEvent {
  const SaveObservationRequested({
    required this.sessionBloc,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.quantity,
    required this.bearing,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.existingRecord,
  });

  final SessionObservationBloc sessionBloc;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final double bearing;
  final String? notes;
  final ObservationRecord? existingRecord;
  final double latitude;
  final double longitude;
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
    latitude,
    longitude,
    startTime,
    endTime,
  ];
}
