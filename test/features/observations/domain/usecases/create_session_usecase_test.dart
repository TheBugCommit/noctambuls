import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

class MockLocationService extends Mock implements LocationService {}

class FakeObservationSession extends Fake implements ObservationSession {}

class FakeGeoPosition extends Fake implements GeoPosition {}

void main() {
  late CreateSessionUseCase usecase;
  late MockObservationRepository mockRepository;
  late MockLocationService mockLocationService;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
    registerFallbackValue(FakeGeoPosition());
  });

  setUp(() {
    mockRepository = MockObservationRepository();
    mockLocationService = MockLocationService();
    usecase = CreateSessionUseCase(
      observationRepository: mockRepository,
      locationService: mockLocationService,
    );
  });

  void _stubLocationServiceNoSignal() {
    when(
      () => mockLocationService.getLastKnownLocation(),
    ).thenAnswer((_) async => Err(const DatabaseFailure()));
    when(
      () => mockLocationService.getLocation(),
    ).thenAnswer((_) async => Err(const DatabaseFailure()));
  }

  group('CreateSessionUseCase', () {
    test(
      'hauria de crear la sessió quan no hi ha cap sessió activa',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => const Ok(null));
        when(
          () => mockRepository.createSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        when(
          () => mockRepository.updateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        _stubLocationServiceNoSignal();

        final result = await usecase(SessionType.incidental, 'user-1');

        expect(result.isOk, isTrue);
        verify(() => mockRepository.createSession(any())).called(1);
      },
    );

    test(
      'hauria de retornar Err(ActiveSessionAlreadyExistsFailure) si ja hi ha'
      ' una sessió activa',
      () async {
        final existingSession = ObservationSession(
          id: 'existing',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        );
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => Ok(existingSession));

        final result = await usecase(SessionType.incidental, 'user-1');

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<ActiveSessionAlreadyExistsFailure>(),
        );
        verifyNever(() => mockRepository.createSession(any()));
      },
    );

    test(
      'hauria de consultar el repositori per sessions actives abans de crear',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => const Ok(null));
        when(
          () => mockRepository.createSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        when(
          () => mockRepository.updateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        _stubLocationServiceNoSignal();

        await usecase(SessionType.incidental, 'user-1');

        verifyInOrder([
          () => mockRepository.getActiveSession(),
          () => mockRepository.createSession(any()),
        ]);
      },
    );

    test(
      'hauria de crear la sessió amb el tipus de sessió correcte',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => const Ok(null));
        when(
          () => mockRepository.createSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        when(
          () => mockRepository.updateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        _stubLocationServiceNoSignal();

        await usecase(SessionType.census, 'user-42');

        final captured =
            verify(() => mockRepository.createSession(captureAny())).captured;
        final session = captured.first as ObservationSession;
        expect(session.sessionType, SessionType.census);
        expect(session.annotatorId, 'user-42');
        expect(session.id, isNotEmpty);
      },
    );
  });
}
