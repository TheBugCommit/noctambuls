import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';

class MockWatchObservationsForSessionUseCase extends Mock
    implements WatchObservationsForSessionUseCase {}

class MockAddObservationUseCase extends Mock implements AddObservationUseCase {}

class MockDeleteObservationUseCase extends Mock
    implements DeleteObservationUseCase {}

class FakeObservationRecord extends Fake implements ObservationRecord {}

void main() {
  late MockWatchObservationsForSessionUseCase mockWatchObservations;
  late MockAddObservationUseCase mockAddObservation;
  late MockDeleteObservationUseCase mockDeleteObservation;

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
    contactType: 'visual',
    startTime: DateTime(2024),
    endTime: DateTime(2024),
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  setUpAll(() {
    registerFallbackValue(FakeObservationRecord());
    // Suppress unused variable warning for tSession in tests
    expect(tSession.id, tSessionId);
  });

  setUp(() {
    mockWatchObservations = MockWatchObservationsForSessionUseCase();
    mockAddObservation = MockAddObservationUseCase();
    mockDeleteObservation = MockDeleteObservationUseCase();
  });

  SessionObservationBloc buildBloc() => SessionObservationBloc(
    sessionId: tSessionId,
    watchObservationsUseCase: mockWatchObservations,
    addObservationUseCase: mockAddObservation,
    deleteObservationUseCase: mockDeleteObservation,
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
        ObservationsLoaded([tRecord]),
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
      expect: () => [const ObservationsLoaded([])],
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
