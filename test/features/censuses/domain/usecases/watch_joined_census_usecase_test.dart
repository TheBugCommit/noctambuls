import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/whatch_joined_census_usecase.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

void main() {
  late MockCensusRepository mockRepository;
  late WatchJoinedCensusUseCase usecase;

  setUp(() {
    mockRepository = MockCensusRepository();
    usecase = WatchJoinedCensusUseCase(mockRepository);
  });

  final tToday = DateTime.now().toUtc();
  final tCensus = Census(
    id: 'c1',
    title: 'Cens',
    startTime: tToday,
    createdAt: tToday,
    updatedAt: tToday,
    isJoined: true,
  );

  group('WatchJoinedCensusUseCase', () {
    test('call() delega a repository.watchJoinedCensus() i retorna stream', () {
      when(() => mockRepository.watchJoinedCensus())
          .thenAnswer((_) => Stream.value(tCensus));

      final stream = usecase();

      expect(stream, emits(tCensus));
      verify(() => mockRepository.watchJoinedCensus()).called(1);
    });

    test('call() propaga null quan no hi ha cens unit', () {
      when(() => mockRepository.watchJoinedCensus())
          .thenAnswer((_) => Stream.value(null));

      expect(usecase(), emits(isNull));
    });
  });
}
