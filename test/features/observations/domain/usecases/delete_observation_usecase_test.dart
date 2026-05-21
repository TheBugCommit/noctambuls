import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late DeleteObservationUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = DeleteObservationUseCase(mockRepository);
  });

  final now = DateTime(2024);

  final tRecord = ObservationRecord(
    id: 'obs-1',
    sessionId: 'sess-1',
    speciesId: 'bubo_bubo',
    contactType: ContactType.visual,
    bearing: 0.0,
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: now,
    updatedAt: now,
    observations: [tRecord],
  );

  final tLockedRecord = ObservationRecord(
    id: 'obs-1',
    sessionId: 'sess-locked',
    speciesId: 'bubo_bubo',
    contactType: ContactType.visual,
    bearing: 0.0,
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  final tLockedSession = ObservationSession(
    id: 'sess-locked',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    isLocked: true,
    createdAt: now,
    updatedAt: now,
    observations: [tLockedRecord],
  );

  group('DeleteObservationUseCase', () {
    test(
      'hauria de cridar getSessionById i saveSession amb la sessió actualitzada',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase('sess-1', 'obs-1');

        expect(result.isOk, isTrue);
        verify(() => mockRepository.getSessionById('sess-1')).called(1);
        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured;
        final saved = captured.first as ObservationSession;
        expect(saved.observations, isEmpty);
      },
    );

    test(
      'hauria de retornar SessionNotFoundFailure si la sessió no existeix',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Ok(null));

        final result = await usecase('sess-1', 'obs-1');

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<SessionNotFoundFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de retornar SessionLockedFailure si la sessió és locked',
      () async {
        when(
          () => mockRepository.getSessionById('sess-locked'),
        ).thenAnswer((_) async => Ok(tLockedSession));

        final result = await usecase('sess-locked', 'obs-1');

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<SessionLockedFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de propagar DatabaseFailure si saveSession falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase('sess-1', 'obs-1');

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );

    test(
      'hauria de propagar DatabaseFailure si getSessionById falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase('sess-1', 'obs-1');

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );
  });
}
