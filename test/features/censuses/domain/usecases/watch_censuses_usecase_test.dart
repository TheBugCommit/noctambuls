import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/watch_censuses_usecase.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

void main() {
  late MockCensusRepository mockRepository;
  late WatchCensusesUseCase usecase;

  setUp(() {
    mockRepository = MockCensusRepository();
    usecase = WatchCensusesUseCase(mockRepository);
  });

  final tToday = DateTime.now().toUtc();
  final tCensus = Census(
    id: 'c1',
    title: 'Cens',
    startTime: tToday,
    createdAt: tToday,
    updatedAt: tToday,
  );

  group('WatchCensusesUseCase', () {
    test('call() delega a repository.watchAll() i retorna stream', () {
      when(() => mockRepository.watchAll())
          .thenAnswer((_) => Stream.value([tCensus]));

      final stream = usecase();

      expect(stream, emits([tCensus]));
      verify(() => mockRepository.watchAll()).called(1);
    });
  });
}
