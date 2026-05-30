import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';

class MockBirdsRepository extends Mock implements BirdsRepository {}

void main() {
  late MockBirdsRepository mockRepo;
  late GetBirdsUseCase usecase;

  const tBird = Bird(
    id: 'b1',
    commonName: 'Merla',
    scientificName: 'Turdus merula',
    description: 'Ocell comú',
    imageUrl: 'https://example.com/image.jpg',
    audioUrl: 'https://example.com/audio.mp3',
    infoUrl: 'https://example.com/info',
  );

  setUp(() {
    mockRepo = MockBirdsRepository();
    usecase = GetBirdsUseCase(mockRepo);
  });

  test("call('ca') → delega a repository.getBirds('ca') i retorna Ok(birds)", () async {
    when(() => mockRepo.getBirds('ca'))
        .thenAnswer((_) async => const Ok([tBird]));

    final result = await usecase('ca');

    expect(result, isA<Ok<List<Bird>>>());
    expect((result as Ok<List<Bird>>).value, [tBird]);
    verify(() => mockRepo.getBirds('ca')).called(1);
  });

  test("call('ca') error → propaga Err", () async {
    when(() => mockRepo.getBirds('ca'))
        .thenAnswer((_) async => const Err(GuideFetchFailure()));

    final result = await usecase('ca');

    expect(result, isA<Err<List<Bird>>>());
  });
}
