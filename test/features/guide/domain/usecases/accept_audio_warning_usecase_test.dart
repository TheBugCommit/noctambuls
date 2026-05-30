import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/accept_aud_warning_usecase.dart';

class MockAudioPreferencesRepository extends Mock
    implements AudioPreferencesRepository {}

void main() {
  late MockAudioPreferencesRepository mockRepo;
  late AcceptAudioWarningUseCase usecase;

  setUp(() {
    mockRepo = MockAudioPreferencesRepository();
    usecase = AcceptAudioWarningUseCase(mockRepo);
  });

  test('call() → delega a repository.setWarningAccepted() i retorna Ok(Unit)', () async {
    when(() => mockRepo.setWarningAccepted())
        .thenAnswer((_) async => const Ok(Unit.instance));

    final result = await usecase();

    expect(result, isA<Ok<Unit>>());
    verify(() => mockRepo.setWarningAccepted()).called(1);
  });

  test('call() → propaga Err si error al repositori', () async {
    when(() => mockRepo.setWarningAccepted())
        .thenAnswer((_) async => Err(const UnknownFailure()));

    final result = await usecase();

    expect(result, isA<Err<Unit>>());
  });
}
