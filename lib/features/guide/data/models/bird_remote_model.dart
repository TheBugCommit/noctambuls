import 'package:noctambuls/core/database/app_database.dart';

class BirdRemoteModel {
  const BirdRemoteModel({
    required this.id,
    required this.scientificName,
    required this.imagePath,
    required this.audioPath,
    required this.translations,
    this.infoUrl,
  });

  factory BirdRemoteModel.fromJson(Map<String, dynamic> json) {
    final birdId = json['id'] as String;

    return BirdRemoteModel(
      id: birdId,
      scientificName: json['scientificName'] as String,
      imagePath: json['imagePath'] as String,
      audioPath: json['audioPath'] as String,
      infoUrl: json['informationUrl'] as String?,
      translations: (json['translations'] as List<dynamic>)
          .map(
            (t) => BirdNameRemoteModel.fromJson(
              t as Map<String, dynamic>,
              birdId,
            ),
          )
          .toList(),
    );
  }

  final String id;
  final String scientificName;
  final String imagePath;
  final String audioPath;
  final String? infoUrl;
  final List<BirdNameRemoteModel> translations;

  BirdEntityData toEntityData({
    required String localImagePath,
    required String localAudioPath,
  }) {
    return BirdEntityData(
      id: id,
      scientificName: scientificName,
      imagePath: localImagePath,
      audioPath: localAudioPath,
      infoUrl: infoUrl,
    );
  }
}

class BirdNameRemoteModel {
  const BirdNameRemoteModel({
    required this.id,
    required this.birdId,
    required this.languageCode,
    required this.commonName,
    required this.description,
  });

  factory BirdNameRemoteModel.fromJson(
    Map<String, dynamic> json,
    String birdId,
  ) {
    final langCode = json['languageCode'] as String;

    return BirdNameRemoteModel(
      id: '${birdId}_$langCode',
      birdId: birdId,
      languageCode: langCode,
      commonName: json['commonName'] as String,
      description: json['description'] as String,
    );
  }

  final String id;
  final String birdId;
  final String languageCode;
  final String commonName;
  final String description;

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
