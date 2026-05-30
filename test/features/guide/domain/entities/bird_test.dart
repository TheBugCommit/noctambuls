import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

void main() {
  Bird makeBird({String? localImagePath, String? localAudioPath}) => Bird(
    id: 'b1',
    commonName: 'Merla',
    scientificName: 'Turdus merula',
    description: 'Ocell comú',
    imageUrl: 'https://example.com/image.jpg',
    audioUrl: 'https://example.com/audio.mp3',
    infoUrl: 'https://example.com/info',
    localImagePath: localImagePath,
    localAudioPath: localAudioPath,
  );

  group('hasLocalImage', () {
    test('localImagePath no-null → true', () {
      expect(makeBird(localImagePath: '/path/image.jpg').hasLocalImage, isTrue);
    });

    test('localImagePath null → false', () {
      expect(makeBird().hasLocalImage, isFalse);
    });
  });

  group('hasLocalAudio', () {
    test('localAudioPath no-null → true', () {
      expect(makeBird(localAudioPath: '/path/audio.mp3').hasLocalAudio, isTrue);
    });

    test('localAudioPath null → false', () {
      expect(makeBird().hasLocalAudio, isFalse);
    });
  });

  group('Equatable', () {
    test('mateixos valors → iguals', () {
      final a = makeBird(localImagePath: '/img.jpg');
      final b = makeBird(localImagePath: '/img.jpg');
      expect(a, equals(b));
    });

    test('id diferent → no iguals', () {
      const a = Bird(
        id: 'b1',
        commonName: 'Merla',
        scientificName: 'Turdus merula',
        description: 'Ocell comú',
        imageUrl: 'https://example.com/image.jpg',
        audioUrl: 'https://example.com/audio.mp3',
        infoUrl: 'https://example.com/info',
      );
      const b = Bird(
        id: 'b2',
        commonName: 'Merla',
        scientificName: 'Turdus merula',
        description: 'Ocell comú',
        imageUrl: 'https://example.com/image.jpg',
        audioUrl: 'https://example.com/audio.mp3',
        infoUrl: 'https://example.com/info',
      );
      expect(a, isNot(equals(b)));
    });
  });
}
