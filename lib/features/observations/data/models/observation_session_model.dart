import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
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
    @Default([]) List<String> participants,
    @Default([]) List<ObservationRecordModel> observations,
    DateTime? startTime,
    DateTime? endTime,
    int? listeningPoint,
    GeoPosition? location,
    LocationErrorType? locationError,
    SyncErrorType? syncError,
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
      location: entity.location,
      locationError: entity.locationError,
      participants: entity.participants,
      observations: entity.observations
          .map(ObservationRecordModel.fromEntity)
          .toList(),
      isLocked: entity.isLocked,
      syncStatus: entity.syncStatus,
      syncError: entity.syncError,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationSessionModel.fromData(
    SessionEntityData data, {
    List<String> participants = const [],
    List<ObservationRecordModel> observations = const [],
  }) {
    GeoPosition? location;
    if (data.latitude != null && data.longitude != null) {
      location = GeoPosition(
        latitude: data.latitude!,
        longitude: data.longitude!,
        accuracy: data.accuracy ?? 0.0,
        altitude: data.altitude ?? 0.0,
        altitudeAccuracy: data.altitudeAccuracy ?? 0.0,
        timestamp: data.positionTimestamp ?? data.createdAt,
        locationSource: data.locationSource ?? LocationSource.gps,
      );
    }

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
      location: location,
      locationError: data.locationError,
      participants: participants,
      observations: observations,
      isLocked: data.isLocked,
      syncStatus: data.syncStatus,
      syncError: data.syncError,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }
}

extension ObservationSessionModelX on ObservationSessionModel {
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
      location: location,
      locationError: locationError,
      participants: participants,
      observations: observations.map((obs) => obs.toDomain()).toList(),
      isLocked: isLocked,
      syncStatus: syncStatus,
      syncError: syncError,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
