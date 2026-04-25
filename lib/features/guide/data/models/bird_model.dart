import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

class BirdModel extends Bird {
  const BirdModel({
    required super.id,
    required super.commonName,
    required super.scientificName,
    required super.description,
    required super.imagePath,
    required super.audioPath,
    required super.infoUrl,
  });

  factory BirdModel.fromDrift(BirdEntityData bird, BirdNameEntityData name) {
    return BirdModel(
      id: bird.id,
      commonName: name.commonName,
      scientificName: bird.scientificName,
      description: name.description,
      imagePath: bird.imagePath,
      audioPath: bird.audioPath,
      infoUrl: bird.infoUrl ?? '',
    );
  }
}
