import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class MockLocationService extends Mock implements LocationService {}

class FakeObservationSession extends Fake implements ObservationSession {}

class FakeGeoPosition extends Fake implements GeoPosition {}

void main() {
  late CreateSessionUseCase usecase;
  late MockSessionRepository mockRepository;
  late MockLocationService mockLocationService;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
    registerFallbackValue(FakeGeoPosition());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    mockLocationService = MockLocationService();
    usecase = CreateSessionUseCase(
      sessionRepository: mockRepository,
      locationService: mockLocationService,
    );
  });

  void stubLocationNoSignal() {
    when(
      () => mockLocationService.getLastKnownLocation(),
    ).thenAnswer((_) async => const Err(DatabaseFailure()));
    when(
      () => mockLocationService.getLocation(),
    ).thenAnswer((_) async => const Err(DatabaseFailure()));
  }

  void stubNoActiveSession() {
    when(
      () => mockRepository.getActiveSession(),
    ).thenAnswer((_) async => const Ok(null));
  }

  void stubSaveOk() {
    when(
      () => mockRepository.saveSession(any()),
    ).thenAnswer((_) async => const Ok(Unit.instance));
  }

  void stubNoCensusSession() {
    when(
      () => mockRepository.getSessionByCensusId(any()),
    ).thenAnswer((_) async => const Ok(null));
  }

  final tExistingSession = ObservationSession(
    id: 'existing',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('CreateSessionUseCase', () {
    test(
      'hauria de crear la sessió quan no hi ha cap sessió activa',
      () async {
        stubNoActiveSession();
        stubSaveOk();
        stubLocationNoSignal();

        final result = await usecase(SessionType.incidental, 'user-1');

        expect(result.isOk, isTrue);
        verify(() => mockRepository.saveSession(any())).called(1);
      },
    );

    test(
      'hauria de retornar Err(ActiveSessionAlreadyExistsFailure) si ja hi ha '
      'una sessió activa',
      () async {
        when(
          () => mockRepository.getActiveSession(),
        ).thenAnswer((_) async => Ok(tExistingSession));

        final result = await usecase(SessionType.incidental, 'user-1');

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<ActiveSessionAlreadyExistsFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de consultar el repositori per sessions actives abans de crear',
      () async {
        stubNoActiveSession();
        stubSaveOk();
        stubLocationNoSignal();

        await usecase(SessionType.incidental, 'user-1');

        verifyInOrder([
          () => mockRepository.getActiveSession(),
          () => mockRepository.saveSession(any()),
        ]);
      },
    );

    test(
      'hauria de crear la sessió amb el tipus i annotatorId correctes',
      () async {
        stubNoActiveSession();
        stubSaveOk();
        stubLocationNoSignal();

        await usecase(SessionType.census, 'user-42');

        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured;
        final session = captured.first as ObservationSession;
        expect(session.sessionType, SessionType.census);
        expect(session.annotatorId, 'user-42');
        expect(session.id, isNotEmpty);
      },
    );

    test(
      'hauria de retornar Err(AlreadyCensusSessionCreatedFailure) si ja hi ha '
      'sessió per aquell censusId',
      () async {
        stubNoActiveSession();

        when(
          () => mockRepository.getSessionByCensusId('census-99'),
        ).thenAnswer((_) async => Ok(tExistingSession));

        final result = await usecase(
          SessionType.census,
          'user-1',
          censusId: 'census-99',
        );

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<AlreadyCensusSessionCreatedFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de crear sessió census quan no hi ha sessió prèvia per aquell censusId',
      () async {
        stubNoActiveSession();
        stubNoCensusSession();
        stubSaveOk();
        stubLocationNoSignal();

        final result = await usecase(
          SessionType.census,
          'user-1',
          censusId: 'census-1',
        );

        expect(result.isOk, isTrue);
        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured;
        final session = captured.first as ObservationSession;
        expect(session.censusId, 'census-1');
      },
    );

    test(
      'hauria de propagar DatabaseFailure si saveSession falla',
      () async {
        stubNoActiveSession();
        stubLocationNoSignal();

        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(SessionType.incidental, 'user-1');

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );

    test(
      'no hauria de bloquejar si LocationService no té senyal (incidental)',
      () async {
        stubNoActiveSession();
        stubSaveOk();
        when(
          () => mockLocationService.getLastKnownLocation(),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(SessionType.incidental, 'user-1');
        expect(result.isOk, isTrue);
      },
    );
  });
}
