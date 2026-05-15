// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'censuses_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CensusesResponseModel _$CensusesResponseModelFromJson(
  Map<String, dynamic> json,
) => _CensusesResponseModel(
  censuses: (json['censuses'] as List<dynamic>)
      .map((e) => CensusRemoteDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  serverTime: json['serverTime'] as String,
);

Map<String, dynamic> _$CensusesResponseModelToJson(
  _CensusesResponseModel instance,
) => <String, dynamic>{
  'censuses': instance.censuses,
  'serverTime': instance.serverTime,
};

_CensusRemoteDto _$CensusRemoteDtoFromJson(Map<String, dynamic> json) =>
    _CensusRemoteDto(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      updatedAt: json['updatedAt'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationName: json['locationName'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CensusRemoteDtoToJson(_CensusRemoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'updatedAt': instance.updatedAt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'description': instance.description,
    };
