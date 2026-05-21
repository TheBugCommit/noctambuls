import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_session_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/stop_observation_phase_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_location_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';

class MockWatchActiveSessionUseCase extends Mock
    implements WatchActiveSessionUseCase {}

class MockCreateSessionUseCase extends Mock implements CreateSessionUseCase {}

class MockUpdateSessionUseCase extends Mock
    implements UpdateSessionPropertiesUseCase {}

class MockUpdateSessionLocationUseCase extends Mock
    implements UpdateSessionLocationUseCase {}

class MockDeleteSessionUseCase extends Mock implements DeleteSessionUseCase {}

class MockDeleteObservationUseCase extends Mock
    implements DeleteObservationUseCase {}

class MockStopObservationPhaseUseCase extends Mock
    implements StopObservationPhaseUseCase {}

class MockChangeSessionDateUseCase extends Mock
    implements ChangeSessionDateUseCase {}

class MockGetBirdsUseCase extends Mock implements GetBirdsUseCase {}

class MockGetLanguageUseCase extends Mock implements GetLanguageUseCase {}

class FakeObservationSession extends Fake implements ObservationSession {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockWatchActiveSessionUseCase mockWatchActiveSession;
  late MockCreateSessionUseCase mockCreateSession;
  late MockUpdateSessionUseCase mockUpdateSession;
  late MockUpdateSessionLocationUseCase mockUpdateSessionLocation;
  late MockDeleteSessionUseCase mockDeleteSession;
  late MockDeleteObservationUseCase mockDeleteObservation;
  late MockStopObservationPhaseUseCase mockStopObservationPhase;
  late MockChangeSessionDateUseCase mockChangeSessionDate;
  late MockGetBirdsUseCase mockGetBirds;
  late MockGetLanguageUseCase mockGetLanguage;
  late MockLogger mockLogger;

  // endTime == null, !isLocked → isObserving = true
  final tObservingSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  // sessionType = incidental → canEditObservationDate
  final tIncidentalSession = ObservationSession(
    id: 'sess-inc',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  // endTime != null, !isLocked → isReviewing (no activa per al bloc)
  final tReviewingSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    endTime: DateTime(2024, 1, 2),
  );

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
    registerFallbackValue(SessionType.census);
  });

  setUp(() {
    mockWatchActiveSession = MockWatchActiveSessionUseCase();
    mockCreateSession = MockCreateSessionUseCase();
    mockUpdateSession = MockUpdateSessionUseCase();
    mockUpdateSessionLocation = MockUpdateSessionLocationUseCase();
    mockDeleteSession = MockDeleteSessionUseCase();
    mockDeleteObservation = MockDeleteObservationUseCase();
    mockStopObservationPhase = MockStopObservationPhaseUseCase();
    mockChangeSessionDate = MockChangeSessionDateUseCase();
    mockGetBirds = MockGetBirdsUseCase();
    mockGetLanguage = MockGetLanguageUseCase();
    mockLogger = MockLogger();

    when(() => mockGetLanguage()).thenReturn(AppLanguage.catalan);
    when(() => mockGetBirds(any())).thenAnswer((_) async => const Ok([]));
  });

  ObservingSessionBloc buildBloc() => ObservingSessionBloc(
    watchActiveSessionUseCase: mockWatchActiveSession,
    createSessionUseCase: mockCreateSession,
    updateSessionUseCase: mockUpdateSession,
    updateSessionLocationUseCase: mockUpdateSessionLocation,
    deleteSessionUseCase: mockDeleteSession,
    deleteObservationUseCase: mockDeleteObservation,
    stopObservationPhaseUseCase: mockStopObservationPhase,
    changeSessionDateUseCase: mockChangeSessionDate,
    getBirdsUseCase: mockGetBirds,
    getLanguageUseCase: mockGetLanguage,
    logger: mockLogger,
  );

  test("l'estat inicial hauria de ser ObservingSessionIdle", () {
    expect(buildBloc().state, const ObservingSessionIdle());
  });

  group('WatchObservingSession', () {
    late StreamController<ObservationSession?> sessionStream;

    setUp(() => sessionStream = StreamController<ObservationSession?>());
    tearDown(() => sessionStream.close());

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre ObservingSessionActive quan l'stream emet una sessió "
      'en observació',
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchObservingSession());
        sessionStream.add(tObservingSession);
      },
      expect: () => [
        ObservingSessionActive(
          session: tObservingSession,
          birdsMap: const {},
        ),
      ],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Idle quan l'stream emet una sessió en revisió",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchObservingSession());
        sessionStream.add(tReviewingSession);
      },
      expect: () => [const ObservingSessionIdle()],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Idle quan l'stream emet null",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) {
        bloc.add(WatchObservingSession());
        sessionStream.add(null);
      },
      expect: () => [const ObservingSessionIdle()],
    );
  });

  group('StartObservingSession', () {
    const tEvent = StartObservingSession(
      sessionType: SessionType.census,
      annotatorId: 'user-1',
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Loading i cridar createSession",
      build: () {
        when(
          () => mockCreateSession(any(), any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [const ObservingSessionLoading()],
      verify: (_) {
        verify(
          () => mockCreateSession(SessionType.census, 'user-1'),
        ).called(1);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si ja hi ha una sessió activa",
      build: buildBloc,
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(tEvent),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockCreateSession(any(), any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error(ActiveSessionAlreadyExistsFailure) si ja existeix",
      build: () {
        when(() => mockCreateSession(any(), any())).thenAnswer(
          (_) async => const Err(ActiveSessionAlreadyExistsFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [
        const ObservingSessionLoading(),
        const ObservingSessionError(
          failure: ActiveSessionAlreadyExistsFailure(),
        ),
      ],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error(DatabaseFailure) si createSession falla",
      build: () {
        when(() => mockCreateSession(any(), any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [
        const ObservingSessionLoading(),
        const ObservingSessionError(failure: DatabaseFailure()),
      ],
    );
  });

  group('StopObservingSession', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria de cridar stopObservationPhase i emetre NavigatingToReview",
      build: () {
        when(
          () => mockStopObservationPhase(any()),
        ).thenAnswer(
          (_) async => Ok(
            tObservingSession.copyWith(
              endTime: DateTime(2024, 1, 2),
              updatedAt: DateTime(2024, 1, 2),
            ),
          ),
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => [
        ObservingSessionNavigatingToReview(
          session: tObservingSession.copyWith(
            endTime: DateTime(2024, 1, 2),
            updatedAt: DateTime(2024, 1, 2),
          ),
        ),
      ],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si l'estat no és ObservingSessionActive",
      build: buildBloc,
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockStopObservationPhase(any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error si stopObservationPhase falla",
      build: () {
        when(() => mockStopObservationPhase(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => [
        const ObservingSessionError(failure: DatabaseFailure()),
      ],
    );
  });

  group('DeleteObservingSession', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Loading i cridar deleteSession",
      build: () {
        when(
          () => mockDeleteSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(DeleteObservingSession()),
      expect: () => [const ObservingSessionLoading()],
      verify: (_) =>
          verify(() => mockDeleteSession(tObservingSession.id)).called(1),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si no hi ha sessió activa",
      build: buildBloc,
      act: (bloc) => bloc.add(DeleteObservingSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockDeleteSession(any())),
    );
  });

  group('DeleteObservingRecord', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      'hauria de cridar deleteObservationUseCase amb sessionId i recordId',
      build: () {
        when(
          () => mockDeleteObservation(any(), any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(const DeleteObservingRecord('obs-1')),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verify(
        () => mockDeleteObservation(tObservingSession.id, 'obs-1'),
      ).called(1),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si no hi ha sessió activa",
      build: buildBloc,
      act: (bloc) => bloc.add(const DeleteObservingRecord('obs-1')),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockDeleteObservation(any(), any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error si deleteObservation falla",
      build: () {
        when(() => mockDeleteObservation(any(), any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(const DeleteObservingRecord('obs-1')),
      expect: () => [
        const ObservingSessionError(failure: DatabaseFailure()),
      ],
    );
  });

  group('ChangeSessionDate', () {
    final tNewDate = DateTime(2024, 3, 15);
    final tUpdatedSession = ObservationSession(
      id: 'sess-inc',
      annotatorId: 'user-1',
      sessionType: SessionType.incidental,
      startTime: DateTime(2024, 3, 15),
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024, 3, 15),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      'hauria de cridar changeSessionDateUseCase i actualitzar l\'estat',
      build: () {
        when(
          () => mockChangeSessionDate(
            sessionId: any(named: 'sessionId'),
            newDate: any(named: 'newDate'),
          ),
        ).thenAnswer((_) async => Ok(tUpdatedSession));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(
        session: tIncidentalSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(ChangeSessionDate(tNewDate)),
      expect: () => [
        ObservingSessionActive(session: tUpdatedSession, birdsMap: const {}),
      ],
      verify: (_) => verify(
        () => mockChangeSessionDate(
          sessionId: 'sess-inc',
          newDate: tNewDate,
        ),
      ).called(1),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar si la sessió no és incidental",
      build: buildBloc,
      seed: () => ObservingSessionActive(
        session: tObservingSession,
        birdsMap: const {},
      ),
      act: (bloc) => bloc.add(ChangeSessionDate(tNewDate)),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(
        () => mockChangeSessionDate(
          sessionId: any(named: 'sessionId'),
          newDate: any(named: 'newDate'),
        ),
      ),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si l'estat no és ObservingSessionActive",
      build: buildBloc,
      act: (bloc) => bloc.add(ChangeSessionDate(tNewDate)),
      expect: () => <ObservingSessionState>[],
    );
  });

  group('DismissObservingError', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Idle quan l'estat és ObservingSessionError",
      build: buildBloc,
      seed: () => const ObservingSessionError(failure: UnknownFailure()),
      act: (bloc) => bloc.add(DismissObservingError()),
      expect: () => [const ObservingSessionIdle()],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si l'estat no és Error",
      build: buildBloc,
      act: (bloc) => bloc.add(DismissObservingError()),
      expect: () => <ObservingSessionState>[],
    );
  });
}
