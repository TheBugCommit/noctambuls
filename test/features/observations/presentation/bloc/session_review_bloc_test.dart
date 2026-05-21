import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/finish_and_lock_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/remove_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_session_by_id_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_state.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';

class MockUpdateSessionPropertiesUseCase extends Mock
    implements UpdateSessionPropertiesUseCase {}

class MockDeleteSessionUseCase extends Mock implements DeleteSessionUseCase {}

class MockFinishAndLockSessionUseCase extends Mock
    implements FinishAndLockSessionUseCase {}

class MockAddSessionParticipantUseCase extends Mock
    implements AddSessionParticipantUseCase {}

class MockRemoveSessionParticipantUseCase extends Mock
    implements RemoveSessionParticipantUseCase {}

class MockWatchSessionByIdUseCase extends Mock
    implements WatchSessionByIdUseCase {}

class MockGetBirdsUseCase extends Mock implements GetBirdsUseCase {}

class MockGetLanguageUseCase extends Mock implements GetLanguageUseCase {}

class MockSyncPendingSessionsUseCase extends Mock
    implements SyncPendingSessionsUseCase {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late MockUpdateSessionPropertiesUseCase mockUpdateProperties;
  late MockDeleteSessionUseCase mockDeleteSession;
  late MockFinishAndLockSessionUseCase mockFinishAndLock;
  late MockAddSessionParticipantUseCase mockAddParticipant;
  late MockRemoveSessionParticipantUseCase mockRemoveParticipant;
  late MockWatchSessionByIdUseCase mockWatchSessionById;
  late MockGetBirdsUseCase mockGetBirds;
  late MockGetLanguageUseCase mockGetLanguage;
  late MockSyncPendingSessionsUseCase mockSyncPending;

  final now = DateTime(2024, 6, 15, 10);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockUpdateProperties = MockUpdateSessionPropertiesUseCase();
    mockDeleteSession = MockDeleteSessionUseCase();
    mockFinishAndLock = MockFinishAndLockSessionUseCase();
    mockAddParticipant = MockAddSessionParticipantUseCase();
    mockRemoveParticipant = MockRemoveSessionParticipantUseCase();
    mockWatchSessionById = MockWatchSessionByIdUseCase();
    mockGetBirds = MockGetBirdsUseCase();
    mockGetLanguage = MockGetLanguageUseCase();
    mockSyncPending = MockSyncPendingSessionsUseCase();

    when(() => mockGetLanguage()).thenReturn(AppLanguage.catalan);
    // Return Err by default so _initReactivity doesn't dispatch an extra
    // ReviewSessionStreamUpdated event that would pollute test expectations.
    when(
      () => mockGetBirds(any()),
    ).thenAnswer((_) async => const Err(DatabaseFailure()));
    when(
      () => mockWatchSessionById(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockSyncPending(),
    ).thenAnswer((_) async => const Err(SyncNetworkFailure()));
  });

  SessionReviewBloc buildBloc({ObservationSession? session}) =>
      SessionReviewBloc(
        initialSession: session ?? tSession,
        watchSessionByIdUseCase: mockWatchSessionById,
        getBirdsUseCase: mockGetBirds,
        getLanguageUseCase: mockGetLanguage,
        updateSessionPropertiesUseCase: mockUpdateProperties,
        deleteSessionUseCase: mockDeleteSession,
        finishAndLockSessionUseCase: mockFinishAndLock,
        addSessionParticipantUseCase: mockAddParticipant,
        removeSessionParticipantUseCase: mockRemoveParticipant,
        syncPendingSessionsUseCase: mockSyncPending,
      );

  group('Estat inicial', () {
    test('hauria de ser SessionReviewEditing amb la sessió inicial', () {
      final bloc = buildBloc();
      expect(bloc.state, isA<SessionReviewEditing>());
      expect((bloc.state as SessionReviewEditing).session, tSession);
    });
  });

  group('ReviewSessionStreamUpdated', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'actualitzar la sessió a l'estat",
      build: buildBloc,
      act: (bloc) {
        final updated = ObservationSession(
          id: 'sess-1',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          endTime: now,
          createdAt: now,
          updatedAt: now.add(const Duration(minutes: 1)),
        );
        bloc.add(ReviewSessionStreamUpdated(updated));
      },
      expect: () => [
        isA<SessionReviewEditing>().having(
          (s) => s.session.updatedAt,
          'updatedAt',
          now.add(const Duration(minutes: 1)),
        ),
      ],
    );
  });

  group('ReviewUpdateProperties', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de cridar updateSessionPropertiesUseCase amb params correctes',
      build: () {
        when(
          () => mockUpdateProperties(
            sessionId: any(named: 'sessionId'),
            temperature: any(named: 'temperature'),
            wind: any(named: 'wind'),
          ),
        ).thenAnswer((_) async => Ok(tSession));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const ReviewUpdateProperties(
          temperature: TemperatureRange.tenToTwenty,
          wind: WindLevel.breeze,
        ),
      ),
      expect: () => <SessionReviewState>[],
      verify: (_) => verify(
        () => mockUpdateProperties(
          sessionId: 'sess-1',
          temperature: TemperatureRange.tenToTwenty,
          wind: WindLevel.breeze,
        ),
      ).called(1),
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'emetre SessionReviewError si updateProperties falla",
      build: () {
        when(
          () => mockUpdateProperties(
            sessionId: any(named: 'sessionId'),
          ),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReviewUpdateProperties()),
      expect: () => [
        isA<SessionReviewError>(),
        isA<SessionReviewEditing>(),
      ],
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'ignorar si l'estat no és SessionReviewEditing",
      build: buildBloc,
      seed: () => SessionReviewFinalized(),
      act: (bloc) => bloc.add(const ReviewUpdateProperties()),
      expect: () => <SessionReviewState>[],
      verify: (_) => verifyNever(
        () => mockUpdateProperties(sessionId: any(named: 'sessionId')),
      ),
    );
  });

  group('ReviewAddParticipant', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de cridar addSessionParticipantUseCase',
      build: () {
        when(
          () => mockAddParticipant(any(), any()),
        ).thenAnswer((_) async => Ok(tSession));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReviewAddParticipant('#OR-AB-2024')),
      expect: () => [
        isA<SessionReviewEditing>().having(
          (s) => s.isSaving,
          'isSaving',
          isTrue,
        ),
      ],
      verify: (_) => verify(
        () => mockAddParticipant(any(), '#OR-AB-2024'),
      ).called(1),
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria d\'emetre SessionReviewError i restaurar isSaving si falla',
      build: () {
        when(
          () => mockAddParticipant(any(), any()),
        ).thenAnswer(
          (_) async => const Err(InvalidParticipantCodeFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReviewAddParticipant('INVÀLID')),
      expect: () => [
        isA<SessionReviewEditing>().having((s) => s.isSaving, 'isSaving', true),
        isA<SessionReviewError>(),
        isA<SessionReviewEditing>().having(
          (s) => s.isSaving,
          'isSaving',
          false,
        ),
      ],
    );
  });

  group('ReviewRemoveParticipant', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de cridar removeSessionParticipantUseCase',
      build: () {
        when(
          () => mockRemoveParticipant(any(), any()),
        ).thenAnswer((_) async => Ok(tSession));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReviewRemoveParticipant('#OR-AB-2024')),
      expect: () => [
        isA<SessionReviewEditing>().having(
          (s) => s.isSaving,
          'isSaving',
          isTrue,
        ),
      ],
      verify: (_) => verify(
        () => mockRemoveParticipant(any(), '#OR-AB-2024'),
      ).called(1),
    );
  });

  group('ReviewFinalizeSession', () {
    final tValidCensusSession = ObservationSession(
      id: 'sess-1',
      annotatorId: 'user-1',
      sessionType: SessionType.incidental,
      endTime: now,
      createdAt: now,
      updatedAt: now,
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de cridar finishAndLock i emetre SessionReviewFinalized',
      build: () {
        when(
          () => mockFinishAndLock(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        when(
          () => mockSyncPending(),
        ).thenAnswer(
          (_) async => const Err(SyncNetworkFailure()),
        );
        return buildBloc(session: tValidCensusSession);
      },
      act: (bloc) => bloc.add(const ReviewFinalizeSession()),
      expect: () => [isA<SessionReviewFinalized>()],
      verify: (_) =>
          verify(() => mockFinishAndLock(any())).called(1),
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'emetre SessionReviewError si finishAndLock falla",
      build: () {
        when(
          () => mockFinishAndLock(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));
        return buildBloc(session: tValidCensusSession);
      },
      act: (bloc) => bloc.add(const ReviewFinalizeSession()),
      expect: () => [isA<SessionReviewError>()],
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'ignorar si l'estat no és SessionReviewEditing",
      build: buildBloc,
      seed: () => SessionReviewFinalized(),
      act: (bloc) => bloc.add(const ReviewFinalizeSession()),
      expect: () => <SessionReviewState>[],
      verify: (_) => verifyNever(() => mockFinishAndLock(any())),
    );
  });

  group('ReviewDeleteSession', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de cridar deleteSession i emetre SessionReviewDeleted',
      build: () {
        when(
          () => mockDeleteSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(ReviewDeleteSession()),
      expect: () => [isA<SessionReviewDeleted>()],
      verify: (_) =>
          verify(() => mockDeleteSession('sess-1')).called(1),
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'emetre SessionReviewError si deleteSession falla",
      build: () {
        when(
          () => mockDeleteSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(ReviewDeleteSession()),
      expect: () => [isA<SessionReviewError>()],
    );

    blocTest<SessionReviewBloc, SessionReviewState>(
      "hauria d'ignorar si l'estat no és SessionReviewEditing",
      build: buildBloc,
      seed: () => SessionReviewFinalized(),
      act: (bloc) => bloc.add(ReviewDeleteSession()),
      expect: () => <SessionReviewState>[],
      verify: (_) => verifyNever(() => mockDeleteSession(any())),
    );
  });

  group('ReviewValidateData', () {
    blocTest<SessionReviewBloc, SessionReviewState>(
      'hauria de mantenir validationError null si la sessió incidental és vàlida',
      build: buildBloc,
      act: (bloc) => bloc.add(const ReviewValidateData()),
      expect: () => [
        isA<SessionReviewEditing>().having(
          (s) => s.validationError,
          'validationError',
          isNull,
        ),
      ],
    );
  });
}
