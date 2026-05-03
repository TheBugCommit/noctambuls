import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

void main() {
  late DeleteObservationUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = DeleteObservationUseCase(mockRepository);
  });

  group('DeleteObservationUseCase', () {
    test(
      "hauria de delegar l'esborrat al repositori amb la id correcta",
      () async {
        when(
          () => mockRepository.deleteObservation(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase('obs-1');

        verify(() => mockRepository.deleteObservation('obs-1')).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
