import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/get_census_usecase.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

void main() {
  late MockCensusRepository mockRepository;
  late GetCensusUseCase usecase;

  const tCensusId = 'census-id-1';

  setUp(() {
    mockRepository = MockCensusRepository();
    usecase = GetCensusUseCase(mockRepository);
  });

  final tToday = DateTime.now().toUtc();
  final tCensus = Census(
    id: tCensusId,
    title: 'Cens test',
    startTime: tToday,
    createdAt: tToday,
    updatedAt: tToday,
  );

  group('GetCensusUseCase', () {
    test('call(id) cens trobat → Ok(census)', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => Ok(tCensus));

      final result = await usecase(tCensusId);

      expect(result, isA<Ok<Census?>>());
      expect((result as Ok<Census?>).value, tCensus);
    });

    test('call(id) cens no trobat → Ok(null)', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => const Ok(null));

      final result = await usecase(tCensusId);

      expect(result, isA<Ok<Census?>>());
      expect((result as Ok<Census?>).value, isNull);
    });

    test('call(id) error de base de dades → Err(CensusDatabaseFailure)', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => const Err(CensusDatabaseFailure()));

      final result = await usecase(tCensusId);

      expect(result, isA<Err<Census?>>());
    });
  });
}
