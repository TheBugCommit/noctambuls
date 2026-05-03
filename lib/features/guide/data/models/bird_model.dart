import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

part 'bird_model.freezed.dart';

@freezed
abstract class BirdModel with _$BirdModel {
  const factory BirdModel({
    required String id,
    required String commonName,
    required String scientificName,
    required String description,
    required String imageUrl,
    required String audioUrl,
    required String infoUrl,
    String? localAudioPath,
    String? localImagePath,
  }) = _BirdModel;

  factory BirdModel.fromEntity(BirdEntityData bird, BirdNameEntityData name) {
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

extension BirdModelX on BirdModel {
  Bird toDomain() => Bird(
    id: id,
    commonName: commonName,
    scientificName: scientificName,
    description: description,
    imageUrl: imageUrl,
    audioUrl: audioUrl,
    infoUrl: infoUrl,
    localAudioPath: localAudioPath,
    localImagePath: localImagePath,
  );
}
