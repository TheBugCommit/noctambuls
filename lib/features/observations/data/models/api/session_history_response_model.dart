import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

part 'session_history_response_model.freezed.dart';
part 'session_history_response_model.g.dart';

@freezed
abstract class SessionHistoryResponseModel with _$SessionHistoryResponseModel {
  const factory SessionHistoryResponseModel({
    required List<SessionRemoteDto> sessions,
    required PaginationMetaDto meta,
    required String serverTime,
  }) = _SessionHistoryResponseModel;

  factory SessionHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SessionHistoryResponseModelFromJson(json);
}

@freezed
abstract class PaginationMetaDto with _$PaginationMetaDto {
  const factory PaginationMetaDto({
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required bool hasMore,
  }) = _PaginationMetaDto;

  factory PaginationMetaDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaDtoFromJson(json);
}

@freezed
abstract class SessionRemoteDto with _$SessionRemoteDto {
  const factory SessionRemoteDto({
    required String id,
    required String annotatorId,
    required int sessionType,
    required int temperature,
    required int wind,
    required int sky,
    required int rain,
    required int visibility,
    required int moon,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isDeleted,
    @Default([]) List<ObservationRemoteDto> observations,
    @Default([]) List<ParticipantRemoteDto> participants,
    String? censusId,
    DateTime? startTime,
    DateTime? endTime,
    int? listeningPoint,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? altitudeAccuracy,
    int? locationSource,
  }) = _SessionRemoteDto;

  factory SessionRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$SessionRemoteDtoFromJson(json);
}

@freezed
abstract class ObservationRemoteDto with _$ObservationRemoteDto {
  const factory ObservationRemoteDto({
    required String id,
    required String sessionId,
    required String speciesId,
    required int contactType,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
    required DateTime createdAt,
    required DateTime updatedAt,
    required double bearing,
    required bool isDeleted,
    String? notes,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? altitudeAccuracy,
    int? locationSource,
  }) = _ObservationRemoteDto;

  factory ObservationRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$ObservationRemoteDtoFromJson(json);
}

@freezed
abstract class ParticipantRemoteDto with _$ParticipantRemoteDto {
  const factory ParticipantRemoteDto({
    required String sessionId,
    required String ornithologistCode,
  }) = _ParticipantRemoteDto;

  factory ParticipantRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$ParticipantRemoteDtoFromJson(json);
}

extension SessionRemoteDtoX on SessionRemoteDto {
  ObservationSessionModel toModel() {
    GeoPosition? location;
    if (latitude != null && longitude != null) {
      location = GeoPosition(
        latitude: latitude!,
        longitude: longitude!,
        accuracy: accuracy ?? 0.0,
        altitude: altitude ?? 0.0,
        altitudeAccuracy: altitudeAccuracy ?? 0.0,
        timestamp: createdAt.toUtc(),
        locationSource: locationSource != null
            ? LocationSource.values.firstWhere(
                (e) => e.value == locationSource,
                orElse: () => LocationSource.gps,
              )
            : LocationSource.gps,
      );
    }

    return ObservationSessionModel(
      id: id,
      annotatorId: annotatorId,
      sessionType: SessionType.values.firstWhere(
        (e) => e.value == sessionType,
        orElse: () => SessionType.incidental,
      ),
      startTime: startTime?.toUtc(),
      endTime: endTime?.toUtc(),
      temperature: TemperatureRange.values.firstWhere(
        (e) => e.value == temperature,
        orElse: () => TemperatureRange.values.first,
      ),
      wind: WindLevel.values.firstWhere(
        (e) => e.value == wind,
        orElse: () => WindLevel.values.first,
      ),
      sky: SkyCondition.values.firstWhere(
        (e) => e.value == sky,
        orElse: () => SkyCondition.values.first,
      ),
      rain: RainLevel.values.firstWhere(
        (e) => e.value == rain,
        orElse: () => RainLevel.values.first,
      ),
      visibility: VisibilityLevel.values.firstWhere(
        (e) => e.value == visibility,
        orElse: () => VisibilityLevel.values.first,
      ),
      moon: MoonPresence.values.firstWhere(
        (e) => e.value == moon,
        orElse: () => MoonPresence.values.first,
      ),
      listeningPoint: listeningPoint,
      location: location,
      participants: participants.map((p) => p.ornithologistCode).toList(),
      observations: observations
          .map((o) => o.toModel(sessionId: id))
          .toList(),
      isLocked: true,
      syncStatus: SyncStatus.synced,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      isDeleted: isDeleted,
    );
  }
}

extension ObservationRemoteDtoX on ObservationRemoteDto {
  ObservationRecordModel toModel({required String sessionId}) {
    GeoPosition? location;
    if (latitude != null && longitude != null) {
      location = GeoPosition(
        latitude: latitude!,
        longitude: longitude!,
        accuracy: accuracy ?? 0.0,
        altitude: altitude ?? 0.0,
        altitudeAccuracy: altitudeAccuracy ?? 0.0,
        timestamp: createdAt.toUtc(),
        locationSource: locationSource != null
            ? LocationSource.values.firstWhere(
                (e) => e.value == locationSource,
                orElse: () => LocationSource.gps,
              )
            : LocationSource.gps,
      );
    }

    return ObservationRecordModel(
      id: id,
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: ContactType.values.firstWhere(
        (e) => e.value == contactType,
        orElse: () => ContactType.values.first,
      ),
      quantity: quantity,
      startTime: startTime.toUtc(),
      endTime: endTime.toUtc(),
      notes: notes,
      location: location,
      bearing: bearing,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      isDeleted: isDeleted,
    );
  }
}
