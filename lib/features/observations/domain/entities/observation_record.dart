import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

class ObservationRecord extends Equatable {
  const ObservationRecord({
    required this.id,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    this.quantity = 1,
    this.notes,
    this.latitude,
    this.longitude,
    this.validationStatus = ValidationStatus.pending,
    this.syncStatus = SyncStatus.pending,
    this.isDeleted = false,
  });

  final String id;
  final String sessionId;
  final String speciesId;
  final String contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final ValidationStatus validationStatus;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  @override
  List<Object?> get props => [
    id,
    sessionId,
    speciesId,
    contactType,
    quantity,
    startTime,
    endTime,
    notes,
    latitude,
    longitude,
    validationStatus,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
