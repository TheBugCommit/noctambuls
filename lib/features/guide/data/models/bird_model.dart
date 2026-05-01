import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

class BirdModel extends Bird {
  const BirdModel({
    required super.id,
    required super.commonName,
    required super.scientificName,
    required super.description,
    required super.imageUrl,
    required super.audioUrl,
    required super.infoUrl,
    super.localImagePath,
    super.localAudioPath,
  });

  factory BirdModel.fromDrift(BirdEntityData bird, BirdNameEntityData name) {
    return BirdModel(
      id: bird.id,
      commonName: name.commonName,
      scientificName: bird.scientificName,
      description: name.description,
      imageUrl: bird.imageUrl,
      audioUrl: bird.audioUrl,
      infoUrl: bird.infoUrl ?? '',
      localAudioPath: bird.localAudioPath,
      localImagePath: bird.localImagePath,
    );
  }
}
