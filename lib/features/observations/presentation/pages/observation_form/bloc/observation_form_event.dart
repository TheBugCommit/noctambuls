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
    this.notes,
    this.existingRecord,
  });

  final SessionObservationBloc sessionBloc;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final String? notes;
  final ObservationRecord? existingRecord;

  @override
  List<Object?> get props => [
    sessionId,
    speciesId,
    contactType,
    quantity,
    notes,
    existingRecord,
  ];
}
