import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late UpdateSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = UpdateSessionUseCase(mockRepository);
  });

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('UpdateSessionUseCase', () {
    test("hauria de delegar l'actualització al repositori", () async {
      when(
        () => mockRepository.updateSession(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      await usecase(tSession);

      verify(() => mockRepository.updateSession(tSession)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
