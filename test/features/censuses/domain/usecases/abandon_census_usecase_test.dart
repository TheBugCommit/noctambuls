import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/abandon_census_usecase.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

class FakeCensus extends Fake implements Census {}

void main() {
  late MockCensusRepository mockRepository;
  late AbandonCensusUseCase usecase;

  const tCensusId = 'c1';

  setUpAll(() {
    registerFallbackValue(FakeCensus());
  });

  setUp(() {
    mockRepository = MockCensusRepository();
    usecase = AbandonCensusUseCase(mockRepository);
  });

  final tToday = DateTime.now().toUtc();
  final tCensus = Census(
    id: tCensusId,
    title: 'Cens test',
    startTime: tToday,
    createdAt: tToday,
    updatedAt: tToday,
    isJoined: true,
  );

  group('AbandonCensusUseCase', () {
    test('cens trobat → guarda cens amb isJoined=false i retorna Ok', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => Ok(tCensus));
      when(() => mockRepository.save(any()))
          .thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase(tCensusId);

      expect(result, isA<Ok<Unit>>());
      final captured = verify(() => mockRepository.save(captureAny())).captured;
      final savedCensus = captured.single as Census;
      expect(savedCensus.isJoined, isFalse);
      expect(savedCensus.id, tCensusId);
    });

    test('getById retorna null → Err(CensusNotFoundFailure)', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => const Ok(null));

      final result = await usecase(tCensusId);

      expect(result, isA<Err<Unit>>());
      final failure = (result as Err<Unit>).failure;
      expect(failure, isA<CensusNotFoundFailure>());
      verifyNever(() => mockRepository.save(any()));
    });

    test('getById retorna error → propaga Err', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => const Err(CensusDatabaseFailure()));

      final result = await usecase(tCensusId);

      expect(result, isA<Err<Unit>>());
      verifyNever(() => mockRepository.save(any()));
    });

    test('save falla → propaga Err', () async {
      when(() => mockRepository.getById(tCensusId))
          .thenAnswer((_) async => Ok(tCensus));
      when(() => mockRepository.save(any()))
          .thenAnswer((_) async => const Err(CensusDatabaseFailure()));

      final result = await usecase(tCensusId);

      expect(result, isA<Err<Unit>>());
    });
  });
}
