import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_observations_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/stop_observation_phase_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';

class MockWatchActiveSessionUseCase extends Mock
    implements WatchActiveSessionUseCase {}

class MockCreateSessionUseCase extends Mock implements CreateSessionUseCase {}

class MockUpdateSessionUseCase extends Mock implements UpdateSessionUseCase {}

class MockDeleteSessionUseCase extends Mock implements DeleteSessionUseCase {}

class MockStopObservationPhaseUseCase extends Mock
    implements StopObservationPhaseUseCase {}

class MockChangeObservationDateUseCase extends Mock
    implements ChangeObservationDateUseCase {}

class FakeObservationSession extends Fake implements ObservationSession {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockWatchActiveSessionUseCase mockWatchActiveSession;
  late MockCreateSessionUseCase mockCreateSession;
  late MockUpdateSessionUseCase mockUpdateSession;
  late MockDeleteSessionUseCase mockDeleteSession;
  late MockStopObservationPhaseUseCase mockStopObservationPhase;
  late MockChangeObservationDateUseCase mockChangeObservationDate;
  late MockLogger mockLogger;

  // endTime == null, !isLocked → SessionObserving
  final tObservingSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  // endTime != null, !isLocked → no es considera activa al stream del bloc
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
    mockDeleteSession = MockDeleteSessionUseCase();
    mockStopObservationPhase = MockStopObservationPhaseUseCase();
    mockChangeObservationDate = MockChangeObservationDateUseCase();
    mockLogger = MockLogger();
  });

  ObservingSessionBloc buildBloc() => ObservingSessionBloc(
    watchActiveSessionUseCase: mockWatchActiveSession,
    createSessionUseCase: mockCreateSession,
    updateSessionUseCase: mockUpdateSession,
    deleteSessionUseCase: mockDeleteSession,
    stopObservationPhaseUseCase: mockStopObservationPhase,
    changeObservationDateUseCase: mockChangeObservationDate,
    logger: mockLogger,
  );

  // Idle state
  test("l'estat inicial hauria de ser SessionLifecycleIdle", () {
    expect(buildBloc().state, const ObservingSessionIdle());
  });

  // Watch session
  group('WatchSession', () {
    late StreamController<ObservationSession?> sessionStream;

    setUp(() => sessionStream = StreamController<ObservationSession?>());
    tearDown(() => sessionStream.close());

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre SessionObserving quan l'stream emet una sessió"
      ' en observació',
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
      expect: () => [ObservingSessionActive(session: tObservingSession)],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Idle quan l'stream emet una sessió que ja no és activa",
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
      "hauria d'emetre SessionLifecycleIdle quan l'stream emet null",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) {
        bloc.add(WatchObservingSession());
        sessionStream.add(null);
      },
      expect: () => [const ObservingSessionIdle()],
    );
  });

  // ─── StartNewSession ──────────────────────────────────────────────────────────

  group('StartNewSession', () {
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
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(tEvent),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockCreateSession(any(), any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error si ja existeix sessió activa a la BD",
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
      "hauria d'emetre Error(database) si createSession falla",
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

  // ─── StopObservationPhase ─────────────────────────────────────────────────────

  group('StopObservationPhase', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria de cridar stopObservationPhase quan l'estat és SessionObserving",
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
      seed: () => ObservingSessionActive(session: tObservingSession),
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
      "hauria d'ignorar l'event si l'estat no és SessionObserving",
      build: buildBloc,
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockStopObservationPhase(any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error(database) si stopObservationPhase falla",
      build: () {
        when(() => mockStopObservationPhase(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => [
        const ObservingSessionError(failure: DatabaseFailure()),
      ],
    );
  });

  // ─── DeleteActiveSession ──────────────────────────────────────────────────────

  group('DeleteActiveSession', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Loading i cridar deleteSession quan hi ha sessió activa",
      build: () {
        when(
          () => mockDeleteSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
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

  // ─── DismissError ─────────────────────────────────────────────────────────────

  group('DismissError', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Idle quan l'estat és SessionLifecycleError",
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
