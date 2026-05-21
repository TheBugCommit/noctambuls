import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/remove_session_participant_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late RemoveSessionParticipantUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = RemoveSessionParticipantUseCase(mockRepository);
  });

  final now = DateTime(2024);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: now,
    updatedAt: now,
    participants: ['#OR-AB-2024', '#OR-CD-2025'],
  );

  group('RemoveSessionParticipantUseCase', () {
    test(
      'hauria d\'eliminar el participant i retornar Ok(session)',
      () async {
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(tSession, '#OR-AB-2024');

        expect(result.isOk, isTrue);
        final updated = (result as Ok<ObservationSession>).value;
        expect(updated.participants, isNot(contains('#OR-AB-2024')));
        expect(updated.participants, contains('#OR-CD-2025'));
      },
    );

    test(
      'no hauria de llançar si el codi no existia a la llista',
      () async {
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(tSession, '#OR-ZZ-9999');

        expect(result.isOk, isTrue);
        verify(() => mockRepository.saveSession(any())).called(1);
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
