import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

class ObservationSessionModel extends ObservationSession {
  const ObservationSessionModel({
    required super.id,
    required super.annotatorId,
    required super.sessionType,
    required super.isLocked,
    required super.syncStatus,
    required super.createdAt,
    required super.updatedAt,
    required super.isDeleted,
    super.startTime,
    super.endTime,
    super.weatherNotes,
    super.latitude,
    super.longitude,
  });

  factory ObservationSessionModel.fromEntity(ObservationSession entity) {
    return ObservationSessionModel(
      id: entity.id,
      annotatorId: entity.annotatorId,
      sessionType: entity.sessionType,
      startTime: entity.startTime,
      endTime: entity.endTime,
      weatherNotes: entity.weatherNotes,
      latitude: entity.latitude,
      longitude: entity.longitude,
      isLocked: entity.isLocked,
      syncStatus: entity.syncStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationSessionModel.toModel(SessionEntityData data) {
    return ObservationSessionModel(
      id: data.id,
      annotatorId: data.annotatorId,
      sessionType: data.sessionType,
      startTime: data.startTime,
      endTime: data.endTime,
      weatherNotes: data.weatherNotes,
      latitude: data.latitude,
      longitude: data.longitude,
      isLocked: data.isLocked,
      syncStatus: data.syncStatus,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }
}
