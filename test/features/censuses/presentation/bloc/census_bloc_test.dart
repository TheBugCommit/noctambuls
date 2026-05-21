import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/usecases/abandon_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/fetch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/join_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/watch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/whatch_joined_census_usecase.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_event.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_state.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';

class MockWatchCensusesUseCase extends Mock implements WatchCensusesUseCase {}

class MockWatchJoinedCensusUseCase extends Mock
    implements WatchJoinedCensusUseCase {}

class MockJoinCensusUseCase extends Mock implements JoinCensusUseCase {}

class MockAbandonCensusUseCase extends Mock implements AbandonCensusUseCase {}

class MockFetchCensusesUseCase extends Mock implements FetchCensusesUseCase {}

class MockCreateSessionUseCase extends Mock implements CreateSessionUseCase {}

class FakeCensus extends Fake implements Census {}

void main() {
  late MockWatchCensusesUseCase mockWatchCensuses;
  late MockWatchJoinedCensusUseCase mockWatchJoinedCensus;
  late MockJoinCensusUseCase mockJoinCensus;
  late MockAbandonCensusUseCase mockAbandon;
  late MockFetchCensusesUseCase mockFetchCensuses;
  late MockCreateSessionUseCase mockCreateSession;

  late StreamController<List<Census>> censusController;
  late StreamController<Census?> lobbyController;

  final tNow = DateTime(2024, 6, 15, 20).toUtc();

  final tCensus = Census(
    id: 'c1',
    title: 'Cens Test',
    startTime: tNow,
    createdAt: tNow,
    updatedAt: tNow,
  );
  final tJoinedCensus = Census(
    id: 'c1',
    title: 'Cens Test',
    startTime: tNow,
    createdAt: tNow,
    updatedAt: tNow,
    isJoined: true,
  );

  setUpAll(() {
    registerFallbackValue(FakeCensus());
    registerFallbackValue(SessionType.census);
  });

  setUp(() {
    mockWatchCensuses = MockWatchCensusesUseCase();
    mockWatchJoinedCensus = MockWatchJoinedCensusUseCase();
    mockJoinCensus = MockJoinCensusUseCase();
    mockAbandon = MockAbandonCensusUseCase();
    mockFetchCensuses = MockFetchCensusesUseCase();
    mockCreateSession = MockCreateSessionUseCase();
    censusController = StreamController<List<Census>>.broadcast();
    lobbyController = StreamController<Census?>.broadcast();

    when(() => mockWatchCensuses()).thenAnswer((_) => censusController.stream);
    when(() => mockWatchJoinedCensus())
        .thenAnswer((_) => lobbyController.stream);
    when(() => mockFetchCensuses())
        .thenAnswer((_) async => const Ok(Unit.instance));
  });

  tearDown(() {
    censusController.close();
    lobbyController.close();
  });

  CensusBloc buildBloc() => CensusBloc(
        watchCensusesUseCase: mockWatchCensuses,
        watchJoinedCensusUseCase: mockWatchJoinedCensus,
        joinCensusUseCase: mockJoinCensus,
        abandonCensusUseCase: mockAbandon,
        fetchCensusesUseCase: mockFetchCensuses,
        createSessionUseCase: mockCreateSession,
      );

  group('CensusStarted', () {
    blocTest<CensusBloc, CensusState>(
      'subscriu als streams i crida fetchCensusesUseCase',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
      },
      verify: (_) {
        verify(() => mockWatchCensuses()).called(1);
        verify(() => mockWatchJoinedCensus()).called(1);
        verify(() => mockFetchCensuses()).called(1);
      },
    );

    blocTest<CensusBloc, CensusState>(
      'quan el stream de censos emet → CensusLoaded',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        censusController.add([tCensus]);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        CensusLoaded(censuses: [tCensus]),
      ],
    );

    blocTest<CensusBloc, CensusState>(
      'stream emet cens isJoined=true → lobbyCensus poblat',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        censusController.add([tJoinedCensus]);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        CensusLoaded(censuses: [tJoinedCensus], lobbyCensus: tJoinedCensus),
      ],
    );

    blocTest<CensusBloc, CensusState>(
      'stream de lobby emet cens → CensusLoaded actualitzat',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        lobbyController.add(tJoinedCensus);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => contains(
        CensusLoaded(censuses: [tCensus], lobbyCensus: tJoinedCensus),
      ),
    );
  });

  group('CensusRefreshRequested', () {
    blocTest<CensusBloc, CensusState>(
      'crida fetchCensusesUseCase i no emet nous estats',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) => bloc.add(CensusRefreshRequested()),
      expect: () => [],
      verify: (_) {
        verify(() => mockFetchCensuses()).called(1);
      },
    );
  });

  group('JoinCensusByUrl', () {
    blocTest<CensusBloc, CensusState>(
      'error en join → CensusJoinError',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const JoinCensusByUrl('https://app.example.com/census?token=bad'));
      },
      setUp: () {
        when(() => mockJoinCensus(any()))
            .thenAnswer((_) async => const Err(InvalidCensusTokenFailure()));
      },
      expect: () => contains(
        isA<CensusJoinError>().having(
          (s) => s.failure,
          'failure',
          isA<InvalidCensusTokenFailure>(),
        ),
      ),
    );

    blocTest<CensusBloc, CensusState>(
      'join amb èxit → cap estat emès (el stream s\'ocupa)',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const JoinCensusByUrl('https://app.example.com/census?token=valid'));
      },
      setUp: () {
        when(() => mockJoinCensus(any()))
            .thenAnswer((_) async => Ok(tCensus));
      },
      expect: () => [],
    );
  });

  group('StartCensusSession', () {
    blocTest<CensusBloc, CensusState>(
      'error → CensusJoinError',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          StartCensusSession(census: tCensus, annotatorId: 'u1'),
        );
      },
      setUp: () {
        when(
          () => mockCreateSession(
            any(),
            any(),
            censusId: any(named: 'censusId'),
          ),
        ).thenAnswer((_) async => const Err(CensusDatabaseFailure()));
      },
      expect: () => contains(isA<CensusJoinError>()),
    );

    blocTest<CensusBloc, CensusState>(
      'èxit → cap estat emès',
      build: buildBloc,
      seed: () => CensusLoaded(censuses: [tCensus]),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(StartCensusSession(census: tCensus, annotatorId: 'u1'));
      },
      setUp: () {
        when(
          () => mockCreateSession(
            any(),
            any(),
            censusId: any(named: 'censusId'),
          ),
        ).thenAnswer((_) async => const Ok(Unit.instance));
      },
      expect: () => [],
    );
  });

  group('AbandonCensus', () {
    blocTest<CensusBloc, CensusState>(
      'crida abandonCensusUseCase amb el censusId',
      build: buildBloc,
      act: (bloc) => bloc.add(const AbandonCensus('c1')),
      setUp: () {
        when(() => mockAbandon('c1'))
            .thenAnswer((_) async => const Ok(Unit.instance));
      },
      verify: (_) {
        verify(() => mockAbandon('c1')).called(1);
      },
    );
  });

  group('DismissCensusError', () {
    blocTest<CensusBloc, CensusState>(
      'en CensusJoinError → transiciona a CensusLoaded preservant censuses',
      build: buildBloc,
      seed: () => CensusJoinError(
        failure: const InvalidCensusTokenFailure(),
        censuses: [tCensus],
        lobbyCensus: null,
      ),
      act: (bloc) => bloc.add(DismissCensusError()),
      expect: () => [
        CensusLoaded(censuses: [tCensus]),
      ],
    );

    blocTest<CensusBloc, CensusState>(
      'en CensusJoinError amb lobby → preserva lobbyCensus',
      build: buildBloc,
      seed: () => CensusJoinError(
        failure: const InvalidCensusTokenFailure(),
        censuses: [tCensus],
        lobbyCensus: tJoinedCensus,
      ),
      act: (bloc) => bloc.add(DismissCensusError()),
      expect: () => [
        CensusLoaded(censuses: [tCensus], lobbyCensus: tJoinedCensus),
      ],
    );
  });

  group('stream actualitza durant CensusJoinError', () {
    blocTest<CensusBloc, CensusState>(
      'stream de censos emet durant error → CensusJoinError actualitzat',
      build: buildBloc,
      seed: () => CensusJoinError(
        failure: const InvalidCensusTokenFailure(),
        censuses: [],
      ),
      act: (bloc) async {
        bloc.add(CensusStarted());
        await Future<void>.delayed(Duration.zero);
        censusController.add([tCensus]);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => contains(
        isA<CensusJoinError>().having(
          (s) => s.censuses,
          'censuses',
          contains(tCensus),
        ),
      ),
    );
  });
}
