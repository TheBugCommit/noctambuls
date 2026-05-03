import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';

class AcceptAudioWarningUseCase {
  const AcceptAudioWarningUseCase(this.repo);

  final AudioPreferencesRepository repo;

  Future<Result<Unit>> call() => repo.setWarningAccepted();
}
