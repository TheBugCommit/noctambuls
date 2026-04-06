import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

void main() {
  late WatchObservationsForSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = WatchObservationsForSessionUseCase(mockRepository);
  });

  final now = DateTime(2024);
  final tRecords = [
    ObservationRecord(
      id: 'obs-1',
      sessionId: 'sess-1',
      speciesId: 'parus_major',
      contactType: 'visual',
      startTime: now,
      endTime: now,
      createdAt: now,
      updatedAt: now,
    ),
    ObservationRecord(
      id: 'obs-2',
      sessionId: 'sess-1',
      speciesId: 'turdus_merula',
      contactType: 'auditory',
      startTime: now,
      endTime: now,
      createdAt: now,
      updatedAt: now,
    ),
  ];

  group('WatchObservationsForSessionUseCase', () {
    test(
      "hauria de retornar l'stream d'observacions filtrades per sessionId",
      () {
        when(
          () => mockRepository.watchObservationsForSession('sess-1'),
        ).thenAnswer((_) => Stream.value(tRecords));

        final stream = usecase('sess-1');

        expect(stream, emitsInOrder([tRecords]));
      },
    );

    test('hauria de passar la sessionId correcta al repositori', () {
      when(
        () => mockRepository.watchObservationsForSession(any()),
      ).thenAnswer((_) => Stream.value([]));

      usecase('sess-42');

      verify(() => mockRepository.watchObservationsForSession('sess-42')).called(1);
    });

    test('hauria de retornar llista buida si la sessió no té observacions', () {
      when(
        () => mockRepository.watchObservationsForSession(any()),
      ).thenAnswer((_) => Stream.value([]));

      final stream = usecase('sess-1');

      expect(stream, emitsInOrder([isEmpty]));
    });
  });
}
