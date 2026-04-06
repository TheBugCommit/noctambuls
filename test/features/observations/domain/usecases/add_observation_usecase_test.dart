import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

class FakeObservationRecord extends Fake implements ObservationRecord {}

void main() {
  late AddObservationUseCase usecase;
  late MockObservationRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationRecord());
  });

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = AddObservationUseCase(mockRepository);
  });

  final now = DateTime.now();
  final tObservation = ObservationRecord(
    id: 'obs-1',
    sessionId: 'sess-1',
    speciesId: 'tyto_alba',
    contactType: 'visual',
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
  );

  test('hauria de cridar el mètode addObservation del repositori', () async {
    when(
      () => mockRepository.addObservation(any()),
    ).thenAnswer((_) async => const Ok(Unit.instance));

    await usecase(tObservation);

    verify(() => mockRepository.addObservation(tObservation)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
