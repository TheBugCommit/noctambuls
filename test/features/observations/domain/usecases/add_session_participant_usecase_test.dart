import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_session_participant_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late AddSessionParticipantUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = AddSessionParticipantUseCase(mockRepository);
  });

  final now = DateTime(2024);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: now,
    updatedAt: now,
  );

  final tLockedSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    isLocked: true,
    createdAt: now,
    updatedAt: now,
  );

  group('AddSessionParticipantUseCase', () {
    test(
      'hauria d\'afegir un participant vàlid i retornar Ok(session)',
      () async {
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(tSession, '#OR-AB-2024');

        expect(result.isOk, isTrue);
        final updated = (result as Ok<ObservationSession>).value;
        expect(updated.participants, contains('#OR-AB-2024'));
        verify(() => mockRepository.saveSession(any())).called(1);
      },
    );

    test(
      'hauria de retornar InvalidParticipantCodeFailure per format incorrecte',
      () async {
        final result = await usecase(tSession, 'CODI_INVÀLID');

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<InvalidParticipantCodeFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de retornar SessionLockedFailure si la sessió és locked',
      () async {
        final result = await usecase(tLockedSession, '#OR-AB-2024');

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
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(tSession, '#OR-AB-2024');

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );
  });
}
