import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

void main() {
  const tBirdEntity = BirdEntityData(
    id: 'b1',
    scientificName: 'Turdus merula',
    imageUrl: 'https://example.com/image.jpg',
    audioUrl: 'https://example.com/audio.mp3',
    infoUrl: 'https://example.com/info',
    localImagePath: '/local/image.jpg',
    localAudioPath: '/local/audio.mp3',
  );

  const tNameEntity = BirdNameEntityData(
    id: 'b1_ca',
    birdId: 'b1',
    languageCode: 'ca',
    commonName: 'Merla',
    description: 'Ocell de mida mitjana',
  );

  group('BirdModel.fromEntity', () {
    test('tots els camps mapeats correctament', () {
      final model = BirdModel.fromEntity(tBirdEntity, tNameEntity);

      expect(model.id, 'b1');
      expect(model.commonName, 'Merla');
      expect(model.scientificName, 'Turdus merula');
      expect(model.description, 'Ocell de mida mitjana');
      expect(model.imageUrl, 'https://example.com/image.jpg');
      expect(model.audioUrl, 'https://example.com/audio.mp3');
      expect(model.infoUrl, 'https://example.com/info');
      expect(model.localImagePath, '/local/image.jpg');
      expect(model.localAudioPath, '/local/audio.mp3');
    });

    test('infoUrl null → infoUrl buit al model', () {
      const entityNoInfo = BirdEntityData(
        id: 'b2',
        scientificName: 'Erithacus rubecula',
        imageUrl: 'https://example.com/image2.jpg',
        audioUrl: 'https://example.com/audio2.mp3',
      );
      const name = BirdNameEntityData(
        id: 'b2_ca',
        birdId: 'b2',
        languageCode: 'ca',
        commonName: 'Pit-roig',
        description: 'Ocell petit',
      );

      final model = BirdModel.fromEntity(entityNoInfo, name);

      expect(model.infoUrl, '');
    });
  });

  group('BirdModel.toDomain', () {
    test('genera Bird amb tots els camps', () {
      const model = BirdModel(
        id: 'b1',
        commonName: 'Merla',
        scientificName: 'Turdus merula',
        description: 'Ocell de mida mitjana',
        imageUrl: 'https://example.com/image.jpg',
        audioUrl: 'https://example.com/audio.mp3',
        infoUrl: 'https://example.com/info',
        localImagePath: '/local/image.jpg',
        localAudioPath: '/local/audio.mp3',
      );

      final bird = model.toDomain();

      expect(bird.id, model.id);
      expect(bird.commonName, model.commonName);
      expect(bird.scientificName, model.scientificName);
      expect(bird.description, model.description);
      expect(bird.imageUrl, model.imageUrl);
      expect(bird.audioUrl, model.audioUrl);
      expect(bird.infoUrl, model.infoUrl);
      expect(bird.localImagePath, model.localImagePath);
      expect(bird.localAudioPath, model.localAudioPath);
    });

    test('roundtrip fromEntity → toDomain preserva les dades', () {
      final model = BirdModel.fromEntity(tBirdEntity, tNameEntity);
      final bird = model.toDomain();

      expect(bird, isA<Bird>());
      expect(bird.id, tBirdEntity.id);
      expect(bird.commonName, tNameEntity.commonName);
      expect(bird.scientificName, tBirdEntity.scientificName);
      expect(bird.localImagePath, tBirdEntity.localImagePath);
    });
  });
}
