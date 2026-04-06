import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';

class MockWatchActiveSessionUseCase extends Mock
    implements WatchActiveSessionUseCase {}

class MockCreateSessionUseCase extends Mock implements CreateSessionUseCase {}

class MockUpdateSessionUseCase extends Mock implements UpdateSessionUseCase {}

class MockDeleteSessionUseCase extends Mock implements DeleteSessionUseCase {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late MockWatchActiveSessionUseCase mockWatchActiveSession;
  late MockCreateSessionUseCase mockCreateSession;
  late MockUpdateSessionUseCase mockUpdateSession;
  late MockDeleteSessionUseCase mockDeleteSession;

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
  });

  SessionLifecycleBloc buildBloc() => SessionLifecycleBloc(
    watchActiveSessionUseCase: mockWatchActiveSession,
    createSessionUseCase: mockCreateSession,
    updateSessionUseCase: mockUpdateSession,
    deleteSessionUseCase: mockDeleteSession,
  );

  // Idle state
  test("l'estat inicial hauria de ser SessionLifecycleIdle", () {
    expect(buildBloc().state, const SessionLifecycleIdle());
  });

  // Watch session
  group('WatchSession', () {
    late StreamController<ObservationSession?> sessionStream;

    setUp(() => sessionStream = StreamController<ObservationSession?>());
    tearDown(() => sessionStream.close());

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre SessionObserving quan l'stream emet una sessió"
      ' en observació',
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchSession());
        sessionStream.add(tObservingSession);
      },
      expect: () => [SessionObserving(session: tObservingSession)],
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre SessionReviewing quan l'stream emet una sessió"
      ' en revisió',
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchSession());
        sessionStream.add(tReviewingSession);
      },
      expect: () => [SessionReviewing(session: tReviewingSession)],
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre SessionFinished quan l'stream emet una sessió tancada",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchSession());
        sessionStream.add(tFinishedSession);
      },
      expect: () => [SessionFinished(session: tFinishedSession)],
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre SessionLifecycleIdle quan l'stream emet null",
      build: () {
        when(() => mockWatchActiveSession()).thenAnswer(
          (_) => sessionStream.stream,
        );
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) {
        bloc.add(WatchSession());
        sessionStream.add(null);
      },
      expect: () => [const SessionLifecycleIdle()],
    );
  });

  // ─── StartNewSession ──────────────────────────────────────────────────────────

  group('StartNewSession', () {
    const tEvent = StartNewSession(
      sessionType: SessionType.census,
      annotatorId: 'user-1',
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Loading i cridar createSession amb l'entitat construïda",
      build: () {
        when(
          () => mockCreateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [const SessionLifecycleLoading()],
      verify: (_) {
        final captured = verify(() => mockCreateSession(captureAny())).captured;
        final session = captured.first as ObservationSession;
        expect(session.sessionType, SessionType.census);
        expect(session.annotatorId, 'user-1');
        expect(session.id, isNotEmpty);
        expect(session.startTime, isNotNull);
      },
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si ja hi ha una sessió activa",
      build: buildBloc,
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(tEvent),
      expect: () => <SessionLifecycleState>[],
      verify: (_) => verifyNever(() => mockCreateSession(any())),
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Error si ja existeix sessió activa a la BD",
      build: () {
        when(() => mockCreateSession(any())).thenAnswer(
          (_) async => const Err(ActiveSessionAlreadyExistsFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [
        const SessionLifecycleLoading(),
        const SessionLifecycleError(
          failure: ActiveSessionAlreadyExistsFailure(),
        ),
      ],
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Error(database) si createSession falla",
      build: () {
        when(() => mockCreateSession(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(tEvent),
      expect: () => [
        const SessionLifecycleLoading(),
        const SessionLifecycleError(failure: DatabaseFailure()),
      ],
    );
  });

  // ─── UpdateSessionProperties ──────────────────────────────────────────────────

  group('UpdateSessionProperties', () {
    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      'hauria de cridar updateSession amb les notes actualitzades',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(
        const UpdateSessionProperties(weatherNotes: 'vent suau, assolellat'),
      ),
      expect: () => <SessionLifecycleState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.weatherNotes, 'vent suau, assolellat');
      },
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      'hauria de cridar updateSession amb les coordenades actualitzades',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(
        const UpdateSessionProperties(latitude: 41.3874, longitude: 2.1686),
      ),
      expect: () => <SessionLifecycleState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.latitude, 41.3874);
        expect(updated.longitude, 2.1686);
      },
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si no hi ha sessió activa",
      build: buildBloc,
      act: (bloc) => bloc.add(
        const UpdateSessionProperties(weatherNotes: 'notes'),
      ),
      expect: () => <SessionLifecycleState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
    );
  });

  // ─── StopObservationPhase ─────────────────────────────────────────────────────

  group('StopObservationPhase', () {
    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria de cridar updateSession quan l'estat és SessionObserving",
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(StopObservationPhase()),
      expect: () => <SessionLifecycleState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.endTime, isNotNull);
      },
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si l'estat no és SessionObserving",
      build: buildBloc,
      seed: () => SessionReviewing(session: tReviewingSession),
      act: (bloc) => bloc.add(StopObservationPhase()),
      expect: () => <SessionLifecycleState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Error(database) si updateSession falla",
      build: () {
        when(() => mockUpdateSession(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(StopObservationPhase()),
      expect: () => [
        const SessionLifecycleError(failure: DatabaseFailure()),
      ],
    );
  });

  // ─── FinishAndLockSession ─────────────────────────────────────────────────────

  group('FinishAndLockSession', () {
    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      'hauria de cridar updateSession amb isLocked=true des de SessionReviewing',
      build: () {
        when(
          () => mockUpdateSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionReviewing(session: tReviewingSession),
      act: (bloc) => bloc.add(FinishAndLockSession()),
      expect: () => <SessionLifecycleState>[],
      verify: (_) {
        final captured = verify(() => mockUpdateSession(captureAny())).captured;
        final updated = captured.first as ObservationSession;
        expect(updated.isLocked, isTrue);
      },
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si l'estat no és SessionReviewing",
      build: buildBloc,
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(FinishAndLockSession()),
      expect: () => <SessionLifecycleState>[],
      verify: (_) => verifyNever(() => mockUpdateSession(any())),
    );
  });

  // ─── DeleteActiveSession ──────────────────────────────────────────────────────

  group('DeleteActiveSession', () {
    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Loading i cridar deleteSession quan hi ha sessió activa",
      build: () {
        when(
          () => mockDeleteSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => SessionObserving(session: tObservingSession),
      act: (bloc) => bloc.add(DeleteActiveSession()),
      expect: () => [const SessionLifecycleLoading()],
      verify: (_) =>
          verify(() => mockDeleteSession(tObservingSession.id)).called(1),
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si no hi ha sessió activa",
      build: buildBloc,
      act: (bloc) => bloc.add(DeleteActiveSession()),
      expect: () => <SessionLifecycleState>[],
      verify: (_) => verifyNever(() => mockDeleteSession(any())),
    );
  });

  // ─── DismissError ─────────────────────────────────────────────────────────────

  group('DismissError', () {
    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'emetre Idle quan l'estat és SessionLifecycleError",
      build: buildBloc,
      seed: () => const SessionLifecycleError(failure: UnknownFailure()),
      act: (bloc) => bloc.add(DismissError()),
      expect: () => [const SessionLifecycleIdle()],
    );

    blocTest<SessionLifecycleBloc, SessionLifecycleState>(
      "hauria d'ignorar l'event si l'estat no és Error",
      build: buildBloc,
      act: (bloc) => bloc.add(DismissError()),
      expect: () => <SessionLifecycleState>[],
    );
  });
}
