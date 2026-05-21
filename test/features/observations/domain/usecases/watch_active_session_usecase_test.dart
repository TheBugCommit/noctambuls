import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';

class MockObservationRepository extends Mock implements SessionRepository {}

void main() {
  late WatchActiveSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = WatchActiveSessionUseCase(mockRepository);
  });

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.station,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('WatchActiveSessionUseCase', () {
    test("hauria de retornar l'stream de sessions actives del repositori", () {
      when(
        () => mockRepository.watchActiveSession(),
      ).thenAnswer((_) => Stream.value(tSession));

      final stream = usecase();

      expect(stream, emitsInOrder([tSession]));
    });

    test('hauria de retornar null quan no hi ha sessió activa', () {
      when(
        () => mockRepository.watchActiveSession(),
      ).thenAnswer((_) => Stream.value(null));

      final stream = usecase();

      expect(stream, emitsInOrder([null]));
    });
  });
}
