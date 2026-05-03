import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late CreateSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = CreateSessionUseCase(mockRepository);
  });

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('CreateSessionUseCase', () {
    test('hauria de crear la sessió quan no hi ha cap sessió activa', () async {
      when(
        () => mockRepository.getActiveSession(),
      ).thenAnswer((_) async => const Ok(null));
      when(
        () => mockRepository.createSession(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      await usecase(tSession);

      verify(() => mockRepository.createSession(tSession)).called(1);
    });

    test(
      'hauria de retornar Err(ActiveSessionAlreadyExistsFailure) si ja hi ha'
      ' una sessió activa',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => Ok(tSession));

        final result = await usecase(tSession);

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<ActiveSessionAlreadyExistsFailure>(),
        );
        verifyNever(() => mockRepository.createSession(any()));
      },
    );

    test(
      'hauria de consultar el repositori per a sessions actives abans de crear',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => const Ok(null));
        when(
          () => mockRepository.createSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase(tSession);

        verifyInOrder([
          () => mockRepository.getActiveSession(),
          () => mockRepository.createSession(tSession),
        ]);
      },
    );
  });
}
