import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/audio_player_service.dart';

class PreloadAudioUseCase {
  const PreloadAudioUseCase(this.service);

  final AudioPlayerService service;

  Future<Result<Unit>> call(List<String> paths) => service.preload(paths);
}
