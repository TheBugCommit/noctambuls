import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';

class ObservationRecordModel extends ObservationRecord {
  const ObservationRecordModel({
    required super.id,
    required super.sessionId,
    required super.speciesId,
    required super.contactType,
    required super.quantity,
    required super.startTime,
    required super.endTime,
    required super.createdAt,
    required super.updatedAt,
    super.notes,
    super.latitude,
    super.longitude,
    super.validationStatus,
    super.syncStatus,
    super.isDeleted,
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
      validationStatus: entity.validationStatus,
      syncStatus: entity.syncStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationRecordModel.toModel(ObservationEntityData data) {
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
      validationStatus: data.validationStatus,
      syncStatus: data.syncStatus,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }
}
