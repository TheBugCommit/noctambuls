// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionHistoryResponseModel _$SessionHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _SessionHistoryResponseModel(
  sessions: (json['sessions'] as List<dynamic>)
      .map((e) => SessionRemoteDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: PaginationMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
  serverTime: json['serverTime'] as String,
);

Map<String, dynamic> _$SessionHistoryResponseModelToJson(
  _SessionHistoryResponseModel instance,
) => <String, dynamic>{
  'sessions': instance.sessions,
  'meta': instance.meta,
  'serverTime': instance.serverTime,
};

_PaginationMetaDto _$PaginationMetaDtoFromJson(Map<String, dynamic> json) =>
    _PaginationMetaDto(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$PaginationMetaDtoToJson(_PaginationMetaDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'hasMore': instance.hasMore,
    };

_SessionRemoteDto _$SessionRemoteDtoFromJson(
  Map<String, dynamic> json,
) => _SessionRemoteDto(
  id: json['id'] as String,
  annotatorId: json['annotatorId'] as String,
  sessionType: (json['sessionType'] as num).toInt(),
  temperature: (json['temperature'] as num).toInt(),
  wind: (json['wind'] as num).toInt(),
  sky: (json['sky'] as num).toInt(),
  rain: (json['rain'] as num).toInt(),
  visibility: (json['visibility'] as num).toInt(),
  moon: (json['moon'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool,
  observations:
      (json['observations'] as List<dynamic>?)
          ?.map((e) => ObservationRemoteDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => ParticipantRemoteDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  censusId: json['censusId'] as String?,
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  listeningPoint: (json['listeningPoint'] as num?)?.toInt(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  accuracy: (json['accuracy'] as num?)?.toDouble(),
  altitude: (json['altitude'] as num?)?.toDouble(),
  altitudeAccuracy: (json['altitudeAccuracy'] as num?)?.toDouble(),
  locationSource: (json['locationSource'] as num?)?.toInt(),
);

Map<String, dynamic> _$SessionRemoteDtoToJson(_SessionRemoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'annotatorId': instance.annotatorId,
      'sessionType': instance.sessionType,
      'temperature': instance.temperature,
      'wind': instance.wind,
      'sky': instance.sky,
      'rain': instance.rain,
      'visibility': instance.visibility,
      'moon': instance.moon,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'observations': instance.observations,
      'participants': instance.participants,
      'censusId': instance.censusId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'listeningPoint': instance.listeningPoint,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'altitudeAccuracy': instance.altitudeAccuracy,
      'locationSource': instance.locationSource,
    };

_ObservationRemoteDto _$ObservationRemoteDtoFromJson(
  Map<String, dynamic> json,
) => _ObservationRemoteDto(
  id: json['id'] as String,
  sessionId: json['sessionId'] as String,
  speciesId: json['speciesId'] as String,
  contactType: (json['contactType'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  bearing: (json['bearing'] as num).toDouble(),
  isDeleted: json['isDeleted'] as bool,
  notes: json['notes'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  accuracy: (json['accuracy'] as num?)?.toDouble(),
  altitude: (json['altitude'] as num?)?.toDouble(),
  altitudeAccuracy: (json['altitudeAccuracy'] as num?)?.toDouble(),
  locationSource: (json['locationSource'] as num?)?.toInt(),
);

Map<String, dynamic> _$ObservationRemoteDtoToJson(
  _ObservationRemoteDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'sessionId': instance.sessionId,
  'speciesId': instance.speciesId,
  'contactType': instance.contactType,
  'quantity': instance.quantity,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'bearing': instance.bearing,
  'isDeleted': instance.isDeleted,
  'notes': instance.notes,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'accuracy': instance.accuracy,
  'altitude': instance.altitude,
  'altitudeAccuracy': instance.altitudeAccuracy,
  'locationSource': instance.locationSource,
};

_ParticipantRemoteDto _$ParticipantRemoteDtoFromJson(
  Map<String, dynamic> json,
) => _ParticipantRemoteDto(
  sessionId: json['sessionId'] as String,
  ornithologistCode: json['ornithologistCode'] as String,
);

Map<String, dynamic> _$ParticipantRemoteDtoToJson(
  _ParticipantRemoteDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'ornithologistCode': instance.ornithologistCode,
};
