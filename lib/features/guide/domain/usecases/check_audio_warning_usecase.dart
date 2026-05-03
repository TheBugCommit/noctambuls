import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';

class CheckAudioWarningUseCase {
  const CheckAudioWarningUseCase(this.repo);

  final AudioPreferencesRepository repo;

  Future<Result<bool>> call() => repo.hasAcceptedWarning();
}
