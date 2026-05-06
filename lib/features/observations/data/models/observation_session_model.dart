import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

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
    this.temperature = TemperatureRange.belowZero,
    this.wind = WindLevel.calm,
    this.sky = SkyCondition.clear,
    this.rain = RainLevel.none,
    this.visibility = VisibilityLevel.poor,
    this.moon = MoonPresence.absent,
    this.startTime,
    this.endTime,
    this.listeningPoint,
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
      temperature: entity.temperature,
      wind: entity.wind,
      sky: entity.sky,
      rain: entity.rain,
      visibility: entity.visibility,
      moon: entity.moon,
      listeningPoint: entity.listeningPoint,
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
      temperature: data.temperature,
      wind: data.wind,
      sky: data.sky,
      rain: data.rain,
      visibility: data.visibility,
      moon: data.moon,
      listeningPoint: data.listeningPoint,
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
  final TemperatureRange temperature;
  final WindLevel wind;
  final SkyCondition sky;
  final RainLevel rain;
  final VisibilityLevel visibility;
  final MoonPresence moon;
  final int? listeningPoint;
  final DateTime? startTime;
  final DateTime? endTime;
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
      temperature: temperature,
      wind: wind,
      sky: sky,
      rain: rain,
      visibility: visibility,
      moon: moon,
      listeningPoint: listeningPoint,
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
