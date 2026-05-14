import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';

part 'sync_request_model.freezed.dart';
part 'sync_request_model.g.dart';

@freezed
abstract class SyncRequestModel with _$SyncRequestModel {
  const factory SyncRequestModel({
    required List<SyncSessionDto> sessions,
  }) = _SyncRequestModel;

  factory SyncRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SyncRequestModelFromJson(json);
}

@freezed
abstract class SyncSessionDto with _$SyncSessionDto {
  const factory SyncSessionDto({
    required String id,
    required int sessionType,
    required String startTime,
    required String endTime,
    required int temperature,
    required int wind,
    required int sky,
    required int rain,
    required int visibility,
    required int moon,
    required String createdAt,
    required String updatedAt,
    required List<SyncObservationDto> observations,
    required List<SyncParticipantDto> participants,
    String? censusId,
    int? listeningPoint,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? altitudeAccuracy,
    int? locationSource,
  }) = _SyncSessionDto;

  factory SyncSessionDto.fromJson(Map<String, dynamic> json) =>
      _$SyncSessionDtoFromJson(json);

  factory SyncSessionDto.fromModel(ObservationSessionModel s) => SyncSessionDto(
    id: s.id,
    censusId: null,
    sessionType: s.sessionType.value,
    startTime: (s.startTime ?? s.createdAt).toUtc().toIso8601String(),
    endTime: (s.endTime ?? s.updatedAt).toUtc().toIso8601String(),
    temperature: s.temperature.value,
    wind: s.wind.value,
    sky: s.sky.value,
    rain: s.rain.value,
    visibility: s.visibility.value,
    moon: s.moon.value,
    listeningPoint: s.listeningPoint,
    latitude: s.location?.latitude,
    longitude: s.location?.longitude,
    accuracy: s.location?.accuracy,
    altitude: s.location?.altitude,
    altitudeAccuracy: s.location?.altitudeAccuracy,
    locationSource: s.location?.locationSource.value,
    createdAt: s.createdAt.toUtc().toIso8601String(),
    updatedAt: s.updatedAt.toUtc().toIso8601String(),
    observations: s.observations
        .where((o) => !o.isDeleted)
        .map(SyncObservationDto.fromModel)
        .toList(),
    participants: s.participants
        .map((code) => SyncParticipantDto(ornithologistCode: code))
        .toList(),
  );
}

@freezed
abstract class SyncObservationDto with _$SyncObservationDto {
  const factory SyncObservationDto({
    required String id,
    required String speciesId,
    required int contactType,
    required int quantity,
    required String startTime,
    required String endTime,
    required String createdAt,
    required String updatedAt,
    required double bearing,
    String? notes,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? altitudeAccuracy,
    int? locationSource,
  }) = _SyncObservationDto;

  factory SyncObservationDto.fromJson(Map<String, dynamic> json) =>
      _$SyncObservationDtoFromJson(json);

  factory SyncObservationDto.fromModel(ObservationRecordModel o) =>
      SyncObservationDto(
        id: o.id,
        speciesId: o.speciesId,
        contactType: o.contactType.value,
        quantity: o.quantity,
        startTime: o.startTime.toUtc().toIso8601String(),
        endTime: o.endTime.toUtc().toIso8601String(),
        notes: o.notes,
        latitude: o.location?.latitude,
        longitude: o.location?.longitude,
        accuracy: o.location?.accuracy,
        altitude: o.location?.altitude,
        altitudeAccuracy: o.location?.altitudeAccuracy,
        locationSource: o.location?.locationSource.value,
        bearing: o.bearing,
        createdAt: o.createdAt.toUtc().toIso8601String(),
        updatedAt: o.updatedAt.toUtc().toIso8601String(),
      );
}

@freezed
abstract class SyncParticipantDto with _$SyncParticipantDto {
  const factory SyncParticipantDto({
    required String ornithologistCode,
  }) = _SyncParticipantDto;

  factory SyncParticipantDto.fromJson(Map<String, dynamic> json) =>
      _$SyncParticipantDtoFromJson(json);
}
