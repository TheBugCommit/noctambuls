import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/usecases/fetch_participated_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/fetch_session_history_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/retry_session_sync_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_own_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_participated_sessions_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_state.dart';

class MockWatchOwnSessionsUseCase extends Mock
    implements WatchOwnSessionsUseCase {}

class MockWatchParticipatedSessionsUseCase extends Mock
    implements WatchParticipatedSessionsUseCase {}

class MockFetchSessionHistoryUseCase extends Mock
    implements FetchSessionHistoryUseCase {}

class MockFetchParticipatedSessionsUseCase extends Mock
    implements FetchParticipatedSessionsUseCase {}

class MockSyncPendingSessionsUseCase extends Mock
    implements SyncPendingSessionsUseCase {}

class MockRetrySessionSyncUseCase extends Mock
    implements RetrySessionSyncUseCase {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockWatchOwnSessionsUseCase mockWatchOwn;
  late MockWatchParticipatedSessionsUseCase mockWatchParticipated;
  late MockFetchSessionHistoryUseCase mockFetchHistory;
  late MockFetchParticipatedSessionsUseCase mockFetchParticipated;
  late MockSyncPendingSessionsUseCase mockSyncPending;
  late MockRetrySessionSyncUseCase mockRetrySync;
  late MockLogger mockLogger;

  final now = DateTime(2024);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: now,
    updatedAt: now,
  );

  const tMeta = PaginationMeta(
    currentPage: 1,
    totalPages: 2,
    totalItems: 30,
    hasMore: true,
  );

  const tMetaNoMore = PaginationMeta(
    currentPage: 2,
    totalPages: 2,
    totalItems: 30,
    hasMore: false,
  );

  setUp(() {
    mockWatchOwn = MockWatchOwnSessionsUseCase();
    mockWatchParticipated = MockWatchParticipatedSessionsUseCase();
    mockFetchHistory = MockFetchSessionHistoryUseCase();
    mockFetchParticipated = MockFetchParticipatedSessionsUseCase();
    mockSyncPending = MockSyncPendingSessionsUseCase();
    mockRetrySync = MockRetrySessionSyncUseCase();
    mockLogger = MockLogger();

    when(() => mockWatchOwn(any())).thenAnswer((_) => const Stream.empty());
    when(
      () => mockWatchParticipated(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockLogger.warning(any())).thenReturn(null);
  });

  SessionListBloc buildBloc() => SessionListBloc(
    watchOwnSessionsUseCase: mockWatchOwn,
    watchParticipatedSessionsUseCase: mockWatchParticipated,
    fetchSessionHistoryUseCase: mockFetchHistory,
    fetchParticipatedSessionsUseCase: mockFetchParticipated,
    syncPendingSessionsUseCase: mockSyncPending,
    retrySessionSyncUseCase: mockRetrySync,
    logger: mockLogger,
  );

  // ─── Estat inicial ────────────────────────────────────────────────────────

  test("l'estat inicial hauria de ser SessionListInitial", () {
    expect(buildBloc().state, const SessionListInitial());
  });

  // ─── SessionListStarted ───────────────────────────────────────────────────

  group('SessionListStarted', () {
    blocTest<SessionListBloc, SessionListState>(
      "hauria d'emetre SessionListData() en arrencar",
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SessionListStarted(annotatorId: 'user-1')),
      expect: () => [const SessionListData()],
      verify: (_) {
        verify(() => mockWatchOwn('user-1')).called(1);
        verify(() => mockWatchParticipated('user-1')).called(1);
      },
    );

    blocTest<SessionListBloc, SessionListState>(
      "OwnSessionsUpdated hauria d'actualitzar la llista de sessions pròpies",
      build: () {
        final ownStream = StreamController<List<ObservationSession>>();
        when(() => mockWatchOwn('user-1')).thenAnswer(
          (_) => ownStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(const SessionListStarted(annotatorId: 'user-1'));
        bloc.add(OwnSessionsUpdated([tSession]));
      },
      expect: () => [
        const SessionListData(),
        SessionListData(ownSessions: [tSession]),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      'ParticipatedSessionsUpdated hauria d\'actualitzar la llista participada',
      build: buildBloc,
      act: (bloc) {
        bloc.add(const SessionListStarted(annotatorId: 'user-1'));
        bloc.add(ParticipatedSessionsUpdated([tSession]));
      },
      expect: () => [
        const SessionListData(),
        SessionListData(participatedSessions: [tSession]),
      ],
    );
  });

  // ─── FetchHistoryRequested ────────────────────────────────────────────────

  group('FetchHistoryRequested', () {
    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'emetre isLoadingHistory=true i actualitzar hasMoreHistory',
      build: () {
        when(
          () => mockFetchHistory(refresh: any(named: 'refresh')),
        ).thenAnswer((_) async => const Ok(tMeta));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(const FetchHistoryRequested()),
      expect: () => [
        const SessionListData(isLoadingHistory: true),
        const SessionListData(hasMoreHistory: true),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'emetre historyError si el fetch falla',
      build: () {
        when(
          () => mockFetchHistory(refresh: any(named: 'refresh')),
        ).thenAnswer((_) async => const Err(FetchHistoryFailure()));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(const FetchHistoryRequested()),
      expect: () => [
        const SessionListData(isLoadingHistory: true),
        isA<SessionListData>().having(
          (s) => s.historyError,
          'historyError',
          isA<FetchHistoryFailure>(),
        ),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si ja s'està carregant",
      build: buildBloc,
      seed: () => const SessionListData(isLoadingHistory: true),
      act: (bloc) => bloc.add(const FetchHistoryRequested()),
      expect: () => <SessionListState>[],
      verify: (_) => verifyNever(
        () => mockFetchHistory(refresh: any(named: 'refresh')),
      ),
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si l'estat no és SessionListData",
      build: buildBloc,
      act: (bloc) => bloc.add(const FetchHistoryRequested()),
      expect: () => <SessionListState>[],
    );
  });

  // ─── FetchParticipatedRequested ───────────────────────────────────────────

  group('FetchParticipatedRequested', () {
    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'emetre isLoadingParticipated=true i actualitzar hasMore',
      build: () {
        when(
          () => mockFetchParticipated(refresh: any(named: 'refresh')),
        ).thenAnswer((_) async => const Ok(tMetaNoMore));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(const FetchParticipatedRequested()),
      expect: () => [
        const SessionListData(isLoadingParticipated: true),
        const SessionListData(hasMoreParticipated: false),
      ],
    );
  });

  // ─── HistoryScrollReachedEnd ──────────────────────────────────────────────

  group('HistoryScrollReachedEnd', () {
    blocTest<SessionListBloc, SessionListState>(
      'hauria de fer fetch si hasMoreHistory=true',
      build: () {
        when(
          () => mockFetchHistory(refresh: any(named: 'refresh')),
        ).thenAnswer((_) async => const Ok(tMetaNoMore));
        return buildBloc();
      },
      seed: () => const SessionListData(hasMoreHistory: true),
      act: (bloc) => bloc.add(HistoryScrollReachedEnd()),
      verify: (_) => verify(
        () => mockFetchHistory(refresh: false),
      ).called(1),
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si hasMoreHistory=false",
      build: buildBloc,
      seed: () => const SessionListData(hasMoreHistory: false),
      act: (bloc) => bloc.add(HistoryScrollReachedEnd()),
      expect: () => <SessionListState>[],
      verify: (_) => verifyNever(
        () => mockFetchHistory(refresh: any(named: 'refresh')),
      ),
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si ja s'està carregant",
      build: buildBloc,
      seed: () =>
          const SessionListData(hasMoreHistory: true, isLoadingHistory: true),
      act: (bloc) => bloc.add(HistoryScrollReachedEnd()),
      expect: () => <SessionListState>[],
    );
  });

  // ─── SyncAllPendingRequested ──────────────────────────────────────────────

  group('SyncAllPendingRequested', () {
    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'emetre isSyncing=true → false en sync correcte',
      build: () {
        when(
          () => mockSyncPending(),
        ).thenAnswer((_) async => const Ok(tMeta));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(SyncAllPendingRequested()),
      expect: () => [
        const SessionListData(isSyncing: true),
        const SessionListData(),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'establir syncError si la sincronització falla',
      build: () {
        when(
          () => mockSyncPending(),
        ).thenAnswer((_) async => const Err(SyncNetworkFailure()));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(SyncAllPendingRequested()),
      expect: () => [
        const SessionListData(isSyncing: true),
        isA<SessionListData>().having(
          (s) => s.syncError,
          'syncError',
          isA<SyncNetworkFailure>(),
        ),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si ja s'està sincronitzant",
      build: buildBloc,
      seed: () => const SessionListData(isSyncing: true),
      act: (bloc) => bloc.add(SyncAllPendingRequested()),
      expect: () => <SessionListState>[],
      verify: (_) => verifyNever(() => mockSyncPending()),
    );
  });

  // ─── RetrySyncSessionRequested ────────────────────────────────────────────

  group('RetrySyncSessionRequested', () {
    blocTest<SessionListBloc, SessionListState>(
      'hauria de cridar retrySessionSyncUseCase amb sessionId correcte',
      build: () {
        when(
          () => mockRetrySync('sess-1'),
        ).thenAnswer((_) async => const Ok(tMeta));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(const RetrySyncSessionRequested('sess-1')),
      expect: () => [
        const SessionListData(isSyncing: true),
        const SessionListData(),
      ],
      verify: (_) => verify(() => mockRetrySync('sess-1')).called(1),
    );

    blocTest<SessionListBloc, SessionListState>(
      'hauria d\'establir syncError si el retry falla',
      build: () {
        when(
          () => mockRetrySync(any()),
        ).thenAnswer((_) async => const Err(SyncServerFailure()));
        return buildBloc();
      },
      seed: () => const SessionListData(),
      act: (bloc) => bloc.add(const RetrySyncSessionRequested('sess-1')),
      expect: () => [
        const SessionListData(isSyncing: true),
        isA<SessionListData>().having(
          (s) => s.syncError,
          'syncError',
          isA<SyncServerFailure>(),
        ),
      ],
    );

    blocTest<SessionListBloc, SessionListState>(
      "hauria d'ignorar si ja s'està sincronitzant",
      build: buildBloc,
      seed: () => const SessionListData(isSyncing: true),
      act: (bloc) => bloc.add(const RetrySyncSessionRequested('sess-1')),
      expect: () => <SessionListState>[],
      verify: (_) => verifyNever(() => mockRetrySync(any())),
    );
  });
}
