import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late UpdateSessionPropertiesUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = UpdateSessionPropertiesUseCase(mockRepository);
  });

  final now = DateTime(2024);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: now,
    updatedAt: now,
  );

  group('UpdateSessionPropertiesUseCase', () {
    test(
      'hauria de cridar getSessionById i saveSession i retornar Ok(session)',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(
          sessionId: 'sess-1',
          temperature: TemperatureRange.tenToTwenty,
          wind: WindLevel.breeze,
        );

        expect(result.isOk, isTrue);
        verify(() => mockRepository.getSessionById('sess-1')).called(1);
        verify(() => mockRepository.saveSession(any())).called(1);
      },
    );

    test(
      'hauria d\'aplicar les propietats indicades a la sessió guardada',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase(
          sessionId: 'sess-1',
          temperature: TemperatureRange.aboveThirty,
          wind: WindLevel.moderate,
        );

        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured;
        final saved = captured.first as ObservationSession;
        expect(saved.temperature, TemperatureRange.aboveThirty);
        expect(saved.wind, WindLevel.moderate);
      },
    );

    test(
      'hauria de mantenir les propietats anteriors per als paràmetres nuls',
      () async {
        final sessionWithTemp = ObservationSession(
          id: 'sess-1',
          annotatorId: 'user-1',
          sessionType: SessionType.census,
          temperature: TemperatureRange.tenToTwenty,
          createdAt: now,
          updatedAt: now,
        );

        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(sessionWithTemp));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase(sessionId: 'sess-1', wind: WindLevel.moderate);

        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured;
        final saved = captured.first as ObservationSession;
        expect(saved.temperature, TemperatureRange.tenToTwenty);
        expect(saved.wind, WindLevel.moderate);
      },
    );

    test(
      'hauria de retornar SessionNotFoundFailure si la sessió no existeix',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Ok(null));

        final result = await usecase(sessionId: 'sess-1');

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<SessionNotFoundFailure>(),
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

        final result = await usecase(sessionId: 'sess-1');

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

        final result = await usecase(sessionId: 'sess-1');

        expect(result, isA<Err<ObservationSession>>());
        expect(
          (result as Err<ObservationSession>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );
  });
}
