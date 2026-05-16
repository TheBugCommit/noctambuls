// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_bubbles_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapBubblesResponseModel _$MapBubblesResponseModelFromJson(
  Map<String, dynamic> json,
) => _MapBubblesResponseModel(
  serverTime: json['serverTime'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => MapBubbleDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MapBubblesResponseModelToJson(
  _MapBubblesResponseModel instance,
) => <String, dynamic>{
  'serverTime': instance.serverTime,
  'items': instance.items,
};

_MapBubbleDto _$MapBubbleDtoFromJson(Map<String, dynamic> json) =>
    _MapBubbleDto(
      speciesId: json['species_id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      year: (json['year'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$MapBubbleDtoToJson(_MapBubbleDto instance) =>
    <String, dynamic>{
      'species_id': instance.speciesId,
      'lat': instance.lat,
      'lon': instance.lon,
      'year': instance.year,
      'count': instance.count,
      'updated_at': instance.updatedAt,
    };
