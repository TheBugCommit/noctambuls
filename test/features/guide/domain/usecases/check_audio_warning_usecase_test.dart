import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_audio_warning_usecase.dart';

class MockAudioPreferencesRepository extends Mock
    implements AudioPreferencesRepository {}

void main() {
  late MockAudioPreferencesRepository mockRepo;
  late CheckAudioWarningUseCase usecase;

  setUp(() {
    mockRepo = MockAudioPreferencesRepository();
    usecase = CheckAudioWarningUseCase(mockRepo);
  });

  test('call() → retorna Ok(true) si ja acceptat', () async {
    when(() => mockRepo.hasAcceptedWarning()).thenAnswer((_) async => const Ok(true));

    final result = await usecase();

    expect(result, isA<Ok<bool>>());
    expect((result as Ok<bool>).value, isTrue);
  });

  test('call() → retorna Ok(false) si no acceptat', () async {
    when(() => mockRepo.hasAcceptedWarning()).thenAnswer((_) async => const Ok(false));

    final result = await usecase();

    expect((result as Ok<bool>).value, isFalse);
  });

  test('call() → propaga Err si error al repositori', () async {
    when(() => mockRepo.hasAcceptedWarning())
        .thenAnswer((_) async => Err(const UnknownFailure()));

    final result = await usecase();

    expect(result, isA<Err<bool>>());
  });
}
