import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_all_sessions_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

void main() {
  late WatchAllSessionsUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = WatchAllSessionsUseCase(mockRepository);
  });

  final tSessions = [
    ObservationSession(
      id: 'sess-1',
      annotatorId: 'user-1',
      sessionType: SessionType.census,
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
    ObservationSession(
      id: 'sess-2',
      annotatorId: 'user-1',
      sessionType: SessionType.incidental,
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
  ];

  group('WatchAllSessionsUseCase', () {
    test("hauria de retornar l'stream de totes les sessions del repositori", () {
      when(
        () => mockRepository.watchAllSessions(),
      ).thenAnswer((_) => Stream.value(tSessions));

      final stream = usecase();

      expect(stream, emitsInOrder([tSessions]));
    });

    test('hauria de retornar una llista buida si no hi ha sessions', () {
      when(
        () => mockRepository.watchAllSessions(),
      ).thenAnswer((_) => Stream.value([]));

      final stream = usecase();

      expect(stream, emitsInOrder([isEmpty]));
    });
  });
}
