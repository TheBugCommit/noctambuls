import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/features/guide/data/models/bird_remote_model.dart';

void main() {
  final tJson = {
    'id': 'b1',
    'scientificName': 'Turdus merula',
    'imagePath': '/images/b1.jpg',
    'audioPath': '/audio/b1.mp3',
    'informationUrl': 'https://example.com/b1',
    'translations': [
      {
        'languageCode': 'ca',
        'commonName': 'Merla',
        'description': 'Ocell de mida mitjana',
      },
      {
        'languageCode': 'es',
        'commonName': 'Mirlo',
        'description': 'Ave de tamaño medio',
      },
    ],
  };

  group('BirdRemoteModel.fromJson', () {
    test('tots els camps incloent informationUrl', () {
      final model = BirdRemoteModel.fromJson(tJson);

      expect(model.id, 'b1');
      expect(model.scientificName, 'Turdus merula');
      expect(model.imagePath, '/images/b1.jpg');
      expect(model.audioPath, '/audio/b1.mp3');
      expect(model.infoUrl, 'https://example.com/b1');
      expect(model.translations.length, 2);
    });

    test('informationUrl absent → infoUrl null', () {
      final json = Map<String, dynamic>.from(tJson)..remove('informationUrl');

      final model = BirdRemoteModel.fromJson(json);

      expect(model.infoUrl, isNull);
    });

    test('_injectBirdIdInTranslations → cada traducció rep birdId i id composat', () {
      final model = BirdRemoteModel.fromJson(tJson);

      expect(model.translations[0].birdId, 'b1');
      expect(model.translations[0].id, 'b1_ca');
      expect(model.translations[1].birdId, 'b1');
      expect(model.translations[1].id, 'b1_es');
    });
  });

  group('BirdNameRemoteModel.fromJson', () {
    test('tots els camps (amb birdId i id injectats)', () {
      final model = BirdRemoteModel.fromJson(tJson);
      final name = model.translations[0];

      expect(name.id, 'b1_ca');
      expect(name.birdId, 'b1');
      expect(name.languageCode, 'ca');
      expect(name.commonName, 'Merla');
      expect(name.description, 'Ocell de mida mitjana');
    });
  });

  group('BirdRemoteModel.toEntityData', () {
    final model = BirdRemoteModel.fromJson(tJson);

    test('imageUrl i audioUrl contenen EnvConfig.serverUrl com a prefix', () {
      final entity = model.toEntityData(
        localImagePath: '/local/b1.jpg',
        localAudioPath: '/local/b1.mp3',
      );

      expect(entity.imageUrl, '${EnvConfig.serverUrl}/images/b1.jpg');
      expect(entity.audioUrl, '${EnvConfig.serverUrl}/audio/b1.mp3');
    });

    test('localImagePath i localAudioPath propagats', () {
      final entity = model.toEntityData(
        localImagePath: '/local/b1.jpg',
        localAudioPath: '/local/b1.mp3',
      );

      expect(entity.localImagePath, '/local/b1.jpg');
      expect(entity.localAudioPath, '/local/b1.mp3');
    });

    test('paths locals null propagats com a null', () {
      final entity = model.toEntityData(
        localImagePath: null,
        localAudioPath: null,
      );

      expect(entity.localImagePath, isNull);
      expect(entity.localAudioPath, isNull);
    });
  });

  group('BirdNameRemoteModel.toEntityData', () {
    test('genera BirdNameEntityData correctament', () {
      final model = BirdRemoteModel.fromJson(tJson);
      final nameEntity = model.translations[0].toEntityData();

      expect(nameEntity.id, 'b1_ca');
      expect(nameEntity.birdId, 'b1');
      expect(nameEntity.languageCode, 'ca');
      expect(nameEntity.commonName, 'Merla');
      expect(nameEntity.description, 'Ocell de mida mitjana');
    });
  });
}
