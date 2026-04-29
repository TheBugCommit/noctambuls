import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';

class ObservationSessionModel {
  const ObservationSessionModel({
    required this.id,
    required this.annotatorId,
    required this.sessionType,
    required this.isLocked,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    this.startTime,
    this.endTime,
    this.weatherNotes,
    this.latitude,
    this.longitude,
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

  factory ObservationSessionModel.fromData(SessionEntityData data) {
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

  final String id;
  final String annotatorId;
  final SessionType sessionType;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? weatherNotes;
  final double? latitude;
  final double? longitude;
  final bool isLocked;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  ObservationSession toDomain() {
    return ObservationSession(
      id: id,
      annotatorId: annotatorId,
      sessionType: sessionType,
      startTime: startTime,
      endTime: endTime,
      weatherNotes: weatherNotes,
      latitude: latitude,
      longitude: longitude,
      isLocked: isLocked,
      syncStatus: syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
