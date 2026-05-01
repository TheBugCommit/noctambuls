import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/database/app_database.dart';

part 'bird_remote_model.freezed.dart';
part 'bird_remote_model.g.dart';

Object? _injectBirdIdInTranslations(Map map, String key) {
  final birdId = map['id'] as String?;
  final translations = map[key] as List<dynamic>?;

  if (birdId == null || translations == null) return translations;

  return translations.map((t) {
    final tMap = Map<String, dynamic>.from(t as Map);
    final langCode = tMap['languageCode'] as String;

    tMap['birdId'] = birdId;
    tMap['id'] = '${birdId}_$langCode';

    return tMap;
  }).toList();
}

@freezed
abstract class BirdRemoteModel with _$BirdRemoteModel {
  const factory BirdRemoteModel({
    required String id,
    required String scientificName,
    required String imagePath,
    required String audioPath,
    @JsonKey(readValue: _injectBirdIdInTranslations)
    required List<BirdNameRemoteModel> translations,
    @JsonKey(name: 'informationUrl') String? infoUrl,
  }) = _BirdRemoteModel;

  const BirdRemoteModel._();

  factory BirdRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$BirdRemoteModelFromJson(json);

  BirdEntityData toEntityData({
    required String? localImagePath,
    required String? localAudioPath,
  }) {
    return BirdEntityData(
      id: id,
      scientificName: scientificName,
      imageUrl: '${EnvConfig.serverUrl}$imagePath',
      audioUrl: '${EnvConfig.serverUrl}$audioPath',
      infoUrl: infoUrl,
      localImagePath: localImagePath,
      localAudioPath: localAudioPath,
    );
  }
}

@freezed
abstract class BirdNameRemoteModel with _$BirdNameRemoteModel {
  const factory BirdNameRemoteModel({
    required String id,
    required String birdId,
    required String languageCode,
    required String commonName,
    required String description,
  }) = _BirdNameRemoteModel;

  const BirdNameRemoteModel._();

  factory BirdNameRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$BirdNameRemoteModelFromJson(json);

  BirdNameEntityData toEntityData() {
    return BirdNameEntityData(
      id: id,
      birdId: birdId,
      languageCode: languageCode,
      commonName: commonName,
      description: description,
    );
  }
}
