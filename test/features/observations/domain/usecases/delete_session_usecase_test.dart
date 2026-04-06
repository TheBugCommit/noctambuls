import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';

class MockObservationRepository extends Mock implements ObservationRepository {}

void main() {
  late DeleteSessionUseCase usecase;
  late MockObservationRepository mockRepository;

  setUp(() {
    mockRepository = MockObservationRepository();
    usecase = DeleteSessionUseCase(mockRepository);
  });

  group('DeleteSessionUseCase', () {
    test(
      "hauria de delegar l'esborrat al repositori amb la id correcta",
      () async {
        when(
          () => mockRepository.deleteSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        await usecase('sess-1');

        verify(() => mockRepository.deleteSession('sess-1')).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
