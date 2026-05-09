import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_all_observations_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

class MockWatchObservationsForSessionUseCase extends Mock
    implements WatchObservationsForSessionUseCase {}

class MockAddObservationUseCase extends Mock implements AddObservationUseCase {}

class MockDeleteObservationUseCase extends Mock
    implements DeleteObservationUseCase {}

class MockUpdateObservationUseCase extends Mock
    implements UpdateObservationUseCase {}

class MockUpdateAllObservationsDateUseCase extends Mock
    implements UpdateAllObservationsDateUseCase {}

class MockGetBirdsUseCase extends Mock implements GetBirdsUseCase {}

class MockGetLanguageUseCase extends Mock implements GetLanguageUseCase {}

class FakeObservationRecord extends Fake implements ObservationRecord {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockWatchObservationsForSessionUseCase mockWatchObservations;
  late MockAddObservationUseCase mockAddObservation;
  late MockUpdateObservationUseCase mockUpdateObservation;
  late MockDeleteObservationUseCase mockDeleteObservation;
  late MockUpdateAllObservationsDateUseCase mockUpdateAllObservationsDate;
  late MockGetBirdsUseCase mockGetBirds;
  late MockGetLanguageUseCase mockGetLanguage;
  late MockLogger mockLogger;

  const tSessionId = 'sess-1';

  final tSession = ObservationSession(
    id: tSessionId,
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  final tRecord = ObservationRecord(
    id: 'obs-1',
    sessionId: tSessionId,
    speciesId: 'parus_major',
    contactType: ContactType.visual,
    bearing: 0.0,
    startTime: DateTime(2024),
    endTime: DateTime(2024),
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  setUpAll(() {
    registerFallbackValue(FakeObservationRecord());
    expect(tSession.id, tSessionId);
  });

  setUp(() {
    mockWatchObservations = MockWatchObservationsForSessionUseCase();
    mockAddObservation = MockAddObservationUseCase();
    mockUpdateObservation = MockUpdateObservationUseCase();
    mockDeleteObservation = MockDeleteObservationUseCase();
    mockUpdateAllObservationsDate = MockUpdateAllObservationsDateUseCase();
    mockGetBirds = MockGetBirdsUseCase();
    mockGetLanguage = MockGetLanguageUseCase();
    mockLogger = MockLogger();

    when(() => mockGetLanguage()).thenReturn(AppLanguage.catalan);
    when(() => mockGetBirds(any())).thenAnswer((_) async => const Ok([]));
  });

  SessionObservationBloc buildBloc() => SessionObservationBloc(
    sessionId: tSessionId,
    watchObservationsUseCase: mockWatchObservations,
    addObservationUseCase: mockAddObservation,
    updateObservationUseCase: mockUpdateObservation,
    updateAllObservationsDateUseCase: mockUpdateAllObservationsDate,
    deleteObservationUseCase: mockDeleteObservation,
    getBirdsUseCase: mockGetBirds,
    getLanguageUseCase: mockGetLanguage,
    logger: mockLogger,
  );

  // ─── Estat inicial ────────────────────────────────────────────────────────────

  test("l'estat inicial hauria de ser ObservationsInitial", () {
    expect(buildBloc().state, const ObservationsInitial());
  });

  // ─── WatchObservations ────────────────────────────────────────────────────────

  group('WatchObservations', () {
    late StreamController<List<ObservationRecord>> obsStream;

    setUp(() => obsStream = StreamController<List<ObservationRecord>>());
    tearDown(() => obsStream.close());

    blocTest<SessionObservationBloc, SessionObservationState>(
      "hauria d'emetre ObservationsLoaded quan l'stream emet observacions",
      build: () {
        when(() => mockWatchObservations(tSessionId)).thenAnswer(
          (_) => obsStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchObservations());
        obsStream.add([tRecord]);
      },
      expect: () => [
        ObservationsLoaded(observations: [tRecord], birdsMap: const {}),
      ],
      verify: (_) => verify(() => mockWatchObservations(tSessionId)).called(1),
    );

    blocTest<SessionObservationBloc, SessionObservationState>(
      "hauria d'emetre ObservationsLoaded buit quan l'stream emet llista buida",
      build: () {
        when(() => mockWatchObservations(tSessionId)).thenAnswer(
          (_) => obsStream.stream,
        );
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(WatchObservations());
        obsStream.add([]);
      },
      expect: () => [
        const ObservationsLoaded(observations: [], birdsMap: {}),
      ],
    );
  });

  // ─── AddRecord ────────────────────────────────────────────────────────────────

  group('AddRecord', () {
    blocTest<SessionObservationBloc, SessionObservationState>(
      'hauria de cridar addObservation amb el registre proporcionat',
      build: () {
        when(
          () => mockAddObservation(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddRecord(tRecord)),
      expect: () => <SessionObservationState>[],
      verify: (_) => verify(() => mockAddObservation(tRecord)).called(1),
    );

    blocTest<SessionObservationBloc, SessionObservationState>(
      "hauria d'emetre ObservationsError si addObservation falla",
      build: () {
        when(() => mockAddObservation(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddRecord(tRecord)),
      expect: () => [
        const ObservationsError(failure: DatabaseFailure()),
      ],
    );
  });

  // ─── DeleteRecord ─────────────────────────────────────────────────────────────

  group('DeleteRecord', () {
    blocTest<SessionObservationBloc, SessionObservationState>(
      "hauria de cridar deleteObservation amb l'ID proporcionat",
      build: () {
        when(
          () => mockDeleteObservation(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const DeleteRecord('obs-1')),
      expect: () => <SessionObservationState>[],
      verify: (_) => verify(() => mockDeleteObservation('obs-1')).called(1),
    );

    blocTest<SessionObservationBloc, SessionObservationState>(
      "hauria d'emetre ObservationsError si deleteObservation falla",
      build: () {
        when(() => mockDeleteObservation(any())).thenAnswer(
          (_) async => const Err(DatabaseFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const DeleteRecord('obs-1')),
      expect: () => [
        const ObservationsError(failure: DatabaseFailure()),
      ],
    );
  });
}
