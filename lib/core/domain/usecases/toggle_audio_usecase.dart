import 'package:noctambuls/core/domain/services/audio_player_service.dart';
import 'package:noctambuls/core/error/result.dart';

class ToggleAudioUseCase {
  const ToggleAudioUseCase(this.service);

  final AudioPlayerService service;

  Future<Result<Unit>> call(String path) => service.togglePlay(path);
}
