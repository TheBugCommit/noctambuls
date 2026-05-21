import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_session_date_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late ChangeSessionDateUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = ChangeSessionDateUseCase(mockRepository);
  });

  final now = DateTime(2024, 6, 15, 10);

  final tIncidentalSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    startTime: now,
    createdAt: now,
    updatedAt: now,
  );

  final tLockedSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    isLocked: true,
    createdAt: now,
    updatedAt: now,
  );

  group('ChangeSessionDateUseCase', () {
    test(
      'hauria de canviar la data i retornar Ok(updatedSession)',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tIncidentalSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final newDate = DateTime(2024, 7, 1);
        final result = await usecase(
          sessionId: 'sess-1',
          newDate: newDate,
        );

        expect(result.isOk, isTrue);
        final updated = (result as Ok<ObservationSession>).value;
        expect(updated.startTime!.month, newDate.month);
        expect(updated.startTime!.day, newDate.day);
      },
    );

    test(
      'hauria de retornar SessionNotFoundFailure si la sessió no existeix',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Ok(null));

        final result = await usecase(
          sessionId: 'sess-1',
          newDate: DateTime(2024, 7, 1),
        );

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<SessionNotFoundFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de retornar SessionLockedFailure si la sessió és locked',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tLockedSession));

        final result = await usecase(
          sessionId: 'sess-1',
          newDate: DateTime(2024, 7, 1),
        );

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
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
        ).thenAnswer((_) async => Ok(tIncidentalSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(
          sessionId: 'sess-1',
          newDate: DateTime(2024, 7, 1),
        );

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );

    test(
      'hauria de propagar DatabaseFailure si getSessionById falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(
          sessionId: 'sess-1',
          newDate: DateTime(2024, 7, 1),
        );

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );
  });
}
