import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/fetch_censuses_usecase.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

void main() {
  late MockCensusRepository mockRepository;
  late FetchCensusesUseCase usecase;

  setUp(() {
    mockRepository = MockCensusRepository();
    usecase = FetchCensusesUseCase(mockRepository);
  });

  group('FetchCensusesUseCase', () {
    test('call() èxit → Ok(Unit)', () async {
      when(() => mockRepository.fetchAndSync())
          .thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRepository.fetchAndSync()).called(1);
    });

    test('call() error → Err(CensusFetchFailure)', () async {
      when(() => mockRepository.fetchAndSync())
          .thenAnswer((_) async => const Err(CensusFetchFailure()));

      final result = await usecase();

      expect(result, isA<Err<Unit>>());
    });
  });
}
