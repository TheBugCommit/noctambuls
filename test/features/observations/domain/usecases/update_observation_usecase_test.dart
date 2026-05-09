import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_observation_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

class FakeObservationRecord extends Fake implements ObservationRecord {}

void main() {
  late UpdateObservationUseCase usecase;
  late MockObservationRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationRecord());
  });

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = UpdateObservationUseCase(mockRepository);
  });

  final now = DateTime(2024);
  final tObservation = ObservationRecord(
    id: 'obs-1',
    sessionId: 'sess-1',
    speciesId: 'parus_major',
    contactType: ContactType.visual,
    bearing: 0.0,
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  group('UpdateObservationUseCase', () {
    test("hauria de delegar l'actualització al repositori", () async {
      when(
        () => mockRepository.updateObservation(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      await usecase(tObservation);

      verify(() => mockRepository.updateObservation(tObservation)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
