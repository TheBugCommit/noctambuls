import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
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

class FakeObservationSession extends Fake implements ObservationSession {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockWatchActiveSessionUseCase mockWatchActiveSession;
  late MockCreateSessionUseCase mockCreateSession;
  late MockUpdateSessionUseCase mockUpdateSession;
  late MockDeleteSessionUseCase mockDeleteSession;
  late MockLogger mockLogger;

  // endTime == null, !isLocked → SessionObserving
  final tObservingSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  // endTime != null, !isLocked → SessionReviewing
  final tReviewingSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    endTime: DateTime(2024, 1, 2),
  );

  // isLocked = true → SessionFinished
  final tFinishedSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    endTime: DateTime(2024, 1, 2),
    isLocked: true,
  );

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockWatchActiveSession = MockWatchActiveSessionUseCase();
    mockCreateSession = MockCreateSessionUseCase();
    mockUpdateSession = MockUpdateSessionUseCase();
    mockDeleteSession = MockDeleteSessionUseCase();
    mockLogger = MockLogger();
  });

  ObservingSessionBloc buildBloc() => ObservingSessionBloc(
    watchActiveSessionUseCase: mockWatchActiveSession,
    createSessionUseCase: mockCreateSession,
    updateSessionUseCase: mockUpdateSession,
    deleteSessionUseCase: mockDeleteSession,
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
      "hauria d'emetre SessionReviewing quan l'stream emet una sessió"
      ' en revisió',
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
      expect: () => [SessionReviewing(session: tReviewingSession)],
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre SessionFinished quan l'stream emet una sessió tancada",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchObservingSession());
        sessionStream.add(tFinishedSession);
      },
      expect: () => [SessionFinished(session: tFinishedSession)],
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
      "hauria d'emetre Loading i cridar createSession amb l'entitat construïda",
      build: () {
        when(
          () => mockCreateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [const ObservingSessionLoading()],
      verify: (_) {
        final captured = verify(() => mockCreateSession(captureAny())).captured;
        final session = captured.first as ObservationSession;
        expect(session.sessionType, SessionType.census);
        expect(session.annotatorId, 'user-1');
        expect(session.id, isNotEmpty);
        expect(session.startTime, isNotNull);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si ja hi ha una sessió activa",
      build: buildBloc,
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(tEvent),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockCreateSession(any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error si ja existeix sessió activa a la BD",
      build: () {
        when(() => mockCreateSession(any())).thenAnswer(
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
        when(() => mockCreateSession(any())).thenAnswer(
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

  // ─── UpdateSessionProperties ──────────────────────────────────────────────────

  group('UpdateSessionProperties', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      'hauria de cridar updateSession amb la temperatura actualitzada',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(
        const UpdateObservingSessionLocation(
          temperature: TemperatureRange.tenToTwenty,
        ),
      ),
      expect: () => <ObservingSessionState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.temperature, TemperatureRange.tenToTwenty);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      'hauria de cridar updateSession amb les coordenades actualitzades',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(
        const UpdateObservingSessionLocation(
          latitude: 41.3874,
          longitude: 2.1686,
        ),
      ),
      expect: () => <ObservingSessionState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.latitude, 41.3874);
        expect(updated.longitude, 2.1686);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si no hi ha sessió activa",
      build: buildBloc,
      act: (bloc) => bloc.add(
        const UpdateObservingSessionLocation(wind: WindLevel.breeze),
      ),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
    );
  });

  // ─── StopObservationPhase ─────────────────────────────────────────────────────

  group('StopObservationPhase', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria de cridar updateSession quan l'estat és SessionObserving",
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.endTime, isNotNull);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si l'estat no és SessionObserving",
      build: buildBloc,
      seed: () => SessionReviewing(session: tReviewingSession),
      act: (bloc) => bloc.add(StopObservingSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'emetre Error(database) si updateSession falla",
      build: () {
        when(() => mockUpdateSession(any())).thenAnswer(
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

  // ─── FinishAndLockSession ─────────────────────────────────────────────────────

  group('FinishAndLockSession', () {
    blocTest<ObservingSessionBloc, ObservingSessionState>(
      'hauria de cridar updateSession amb isLocked=true des de SessionReviewing',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionReviewing(session: tReviewingSession),
      act: (bloc) => bloc.add(FinishAndLockSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.isLocked, isTrue);
      },
    );

    blocTest<ObservingSessionBloc, ObservingSessionState>(
      "hauria d'ignorar l'event si l'estat no és SessionReviewing",
      build: buildBloc,
      seed: () => ObservingSessionActive(session: tObservingSession),
      act: (bloc) => bloc.add(FinishAndLockSession()),
      expect: () => <ObservingSessionState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
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
