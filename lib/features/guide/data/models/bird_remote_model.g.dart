// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bird_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BirdRemoteModel _$BirdRemoteModelFromJson(Map<String, dynamic> json) =>
    _BirdRemoteModel(
      id: json['id'] as String,
      scientificName: json['scientificName'] as String,
      imagePath: json['imagePath'] as String,
      audioPath: json['audioPath'] as String,
      translations:
          (_injectBirdIdInTranslations(json, 'translations') as List<dynamic>)
              .map(
                (e) => BirdNameRemoteModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      infoUrl: json['informationUrl'] as String?,
    );

Map<String, dynamic> _$BirdRemoteModelToJson(_BirdRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scientificName': instance.scientificName,
      'imagePath': instance.imagePath,
      'audioPath': instance.audioPath,
      'translations': instance.translations,
      'informationUrl': instance.infoUrl,
    };

_BirdNameRemoteModel _$BirdNameRemoteModelFromJson(Map<String, dynamic> json) =>
    _BirdNameRemoteModel(
      id: json['id'] as String,
      birdId: json['birdId'] as String,
      languageCode: json['languageCode'] as String,
      commonName: json['commonName'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BirdNameRemoteModelToJson(
  _BirdNameRemoteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'birdId': instance.birdId,
  'languageCode': instance.languageCode,
  'commonName': instance.commonName,
  'description': instance.description,
};
