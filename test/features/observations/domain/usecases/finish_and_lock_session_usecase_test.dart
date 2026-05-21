import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/finish_and_lock_session_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class MockCensusRepository extends Mock implements CensusRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

class FakeCensus extends Fake implements Census {}

void main() {
  late FinishAndLockSessionUseCase usecase;
  late MockSessionRepository mockSessionRepository;
  late MockCensusRepository mockCensusRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
    registerFallbackValue(FakeCensus());
  });

  setUp(() {
    mockSessionRepository = MockSessionRepository();
    mockCensusRepository = MockCensusRepository();
    usecase = FinishAndLockSessionUseCase(
      mockSessionRepository,
      mockCensusRepository,
    );
  });

  final now = DateTime(2024, 6, 15, 10);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    startTime: now,
    createdAt: now,
    updatedAt: now,
  );

  final tCensusSession = ObservationSession(
    id: 'sess-census',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    censusId: 'census-1',
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  final tCensus = Census(
    id: 'census-1',
    title: 'Test Census',
    startTime: now,
    createdAt: now,
    updatedAt: now,
  );

  group('FinishAndLockSessionUseCase', () {
    test('hauria de finalitzar i bloquejar la sessió', () async {
      when(
        () => mockSessionRepository.saveSession(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase(tSession);

      expect(result.isOk, isTrue);

      final captured = verify(
        () => mockSessionRepository.saveSession(captureAny()),
      ).captured.first as ObservationSession;
      expect(captured.isLocked, isTrue);
      expect(captured.syncStatus, SyncStatus.pending);
      expect(captured.endTime, isNotNull);
    });

    test(
      'hauria de propagar DatabaseFailure si saveSession falla',
      () async {
        when(
          () => mockSessionRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(tSession);

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );

    test(
      'cas census: hauria de cridar censusRepository.save amb census.markAsDone()',
      () async {
        when(
          () => mockSessionRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        when(
          () => mockCensusRepository.getById('census-1'),
        ).thenAnswer((_) async => Ok(tCensus));
        when(
          () => mockCensusRepository.save(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase(tCensusSession);

        verify(() => mockCensusRepository.getById('census-1')).called(1);
        final captured = verify(
          () => mockCensusRepository.save(captureAny()),
        ).captured.first as Census;
        expect(captured.alreadyDone, isTrue);
      },
    );

    test(
      'cas no-census: no hauria d\'interactuar amb censusRepository',
      () async {
        when(
          () => mockSessionRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase(tSession);

        verifyNever(() => mockCensusRepository.getById(any()));
        verifyNever(() => mockCensusRepository.save(any()));
      },
    );
  });
}
