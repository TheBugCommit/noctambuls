// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncRequestModel _$SyncRequestModelFromJson(Map<String, dynamic> json) =>
    _SyncRequestModel(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SyncSessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncRequestModelToJson(_SyncRequestModel instance) =>
    <String, dynamic>{'sessions': instance.sessions};

_SyncSessionDto _$SyncSessionDtoFromJson(Map<String, dynamic> json) =>
    _SyncSessionDto(
      id: json['id'] as String,
      sessionType: (json['sessionType'] as num).toInt(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      temperature: (json['temperature'] as num).toInt(),
      wind: (json['wind'] as num).toInt(),
      sky: (json['sky'] as num).toInt(),
      rain: (json['rain'] as num).toInt(),
      visibility: (json['visibility'] as num).toInt(),
      moon: (json['moon'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      observations: (json['observations'] as List<dynamic>)
          .map((e) => SyncObservationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => SyncParticipantDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      censusId: json['censusId'] as String?,
      listeningPoint: (json['listeningPoint'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
      altitudeAccuracy: (json['altitudeAccuracy'] as num?)?.toDouble(),
      locationSource: (json['locationSource'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SyncSessionDtoToJson(_SyncSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionType': instance.sessionType,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'temperature': instance.temperature,
      'wind': instance.wind,
      'sky': instance.sky,
      'rain': instance.rain,
      'visibility': instance.visibility,
      'moon': instance.moon,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'observations': instance.observations,
      'participants': instance.participants,
      'censusId': instance.censusId,
      'listeningPoint': instance.listeningPoint,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'altitudeAccuracy': instance.altitudeAccuracy,
      'locationSource': instance.locationSource,
    };

_SyncObservationDto _$SyncObservationDtoFromJson(Map<String, dynamic> json) =>
    _SyncObservationDto(
      id: json['id'] as String,
      speciesId: json['speciesId'] as String,
      contactType: (json['contactType'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      bearing: (json['bearing'] as num).toDouble(),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
      altitudeAccuracy: (json['altitudeAccuracy'] as num?)?.toDouble(),
      locationSource: (json['locationSource'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SyncObservationDtoToJson(_SyncObservationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'speciesId': instance.speciesId,
      'contactType': instance.contactType,
      'quantity': instance.quantity,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bearing': instance.bearing,
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'altitudeAccuracy': instance.altitudeAccuracy,
      'locationSource': instance.locationSource,
    };

_SyncParticipantDto _$SyncParticipantDtoFromJson(Map<String, dynamic> json) =>
    _SyncParticipantDto(ornithologistCode: json['ornithologistCode'] as String);

Map<String, dynamic> _$SyncParticipantDtoToJson(_SyncParticipantDto instance) =>
    <String, dynamic>{'ornithologistCode': instance.ornithologistCode};
