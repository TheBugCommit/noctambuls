import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

part 'observation_session_model.freezed.dart';

@freezed
abstract class ObservationSessionModel with _$ObservationSessionModel {
  const factory ObservationSessionModel({
    required String id,
    required String annotatorId,
    required SessionType sessionType,
    required bool isLocked,
    required SyncStatus syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isDeleted,
    @Default(TemperatureRange.belowZero) TemperatureRange temperature,
    @Default(WindLevel.calm) WindLevel wind,
    @Default(SkyCondition.clear) SkyCondition sky,
    @Default(RainLevel.none) RainLevel rain,
    @Default(VisibilityLevel.poor) VisibilityLevel visibility,
    @Default(MoonPresence.absent) MoonPresence moon,
    DateTime? startTime,
    DateTime? endTime,
    int? listeningPoint,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? altitudeAccuracy,
    DateTime? positionTimestamp,
    LocationErrorType? locationError,
    @Default([]) List<String> participants,
  }) = _ObservationSessionModel;

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
      latitude: entity.location?.latitude,
      longitude: entity.location?.longitude,
      accuracy: entity.location?.accuracy,
      altitude: entity.location?.altitude,
      altitudeAccuracy: entity.location?.altitudeAccuracy,
      positionTimestamp: entity.location?.timestamp,
      locationError: entity.locationError,
      participants: entity.participants,
      isLocked: entity.isLocked,
      syncStatus: entity.syncStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationSessionModel.fromData(
    SessionEntityData data, {
    List<String> participants = const [],
  }) {
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
      accuracy: data.accuracy,
      altitude: data.altitude,
      altitudeAccuracy: data.altitudeAccuracy,
      positionTimestamp: data.positionTimestamp,
      locationError: data.locationError,
      participants: participants,
      isLocked: data.isLocked,
      syncStatus: data.syncStatus,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }
}

extension ObservationSessionModelX on ObservationSessionModel {
  ObservationSession toDomain() {
    GeoPosition? geoPosition;
    if (latitude != null &&
        longitude != null &&
        accuracy != null &&
        altitude != null &&
        altitudeAccuracy != null &&
        positionTimestamp != null) {
      geoPosition = GeoPosition(
        latitude: latitude!,
        longitude: longitude!,
        accuracy: accuracy!,
        altitude: altitude!,
        altitudeAccuracy: altitudeAccuracy!,
        timestamp: positionTimestamp!,
      );
    }

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
      location: geoPosition,
      locationError: locationError,
      participants: participants,
      isLocked: isLocked,
      syncStatus: syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
