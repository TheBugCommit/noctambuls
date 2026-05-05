import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

class ObservationRecordModel {
  const ObservationRecordModel({
    required this.id,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.quantity,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.bearing,
    required this.latitude,
    required this.longitude,
    this.notes,
    this.validationStatus = ValidationStatus.pending,
    this.syncStatus = SyncStatus.draft,
    this.isDeleted = false,
  });

  factory ObservationRecordModel.fromEntity(ObservationRecord entity) {
    return ObservationRecordModel(
      id: entity.id,
      sessionId: entity.sessionId,
      speciesId: entity.speciesId,
      contactType: entity.contactType,
      quantity: entity.quantity,
      startTime: entity.startTime,
      endTime: entity.endTime,
      notes: entity.notes,
      latitude: entity.latitude,
      longitude: entity.longitude,
      bearing: entity.bearing,
      validationStatus: entity.validationStatus,
      syncStatus: entity.syncStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationRecordModel.fromData(ObservationEntityData data) {
    return ObservationRecordModel(
      id: data.id,
      sessionId: data.sessionId,
      speciesId: data.speciesId,
      contactType: data.contactType,
      quantity: data.quantity,
      startTime: data.startTime,
      endTime: data.endTime,
      notes: data.notes,
      latitude: data.latitude,
      longitude: data.longitude,
      bearing: data.bearing,
      validationStatus: data.validationStatus,
      syncStatus: data.syncStatus,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }

  final String id;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double latitude;
  final double longitude;
  final double bearing;
  final ValidationStatus validationStatus;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  ObservationRecord toDomain() {
    return ObservationRecord(
      id: id,
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity,
      startTime: startTime,
      endTime: endTime,
      notes: notes,
      latitude: latitude,
      longitude: longitude,
      bearing: bearing,
      validationStatus: validationStatus,
      syncStatus: syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
