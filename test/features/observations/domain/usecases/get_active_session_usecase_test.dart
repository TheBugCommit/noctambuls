import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/get_active_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

void main() {
  late GetActiveSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = GetActiveSessionUseCase(mockRepository);
  });

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('GetActiveSessionUseCase', () {
    test('hauria de retornar Ok(session) si existeix sessió activa', () async {
      when(
        () => mockRepository.getActiveSession(),
      ).thenAnswer((_) async => Ok(tSession));

      final result = await usecase();

      expect(result, isA<Ok<ObservationSession?>>());
      expect((result as Ok<ObservationSession?>).value, tSession);
    });

    test('hauria de retornar Ok(null) si no hi ha sessió activa', () async {
      when(
        () => mockRepository.getActiveSession(),
      ).thenAnswer((_) async => const Ok(null));

      final result = await usecase();

      expect(result, isA<Ok<ObservationSession?>>());
      expect((result as Ok<ObservationSession?>).value, isNull);
    });
  });
}
