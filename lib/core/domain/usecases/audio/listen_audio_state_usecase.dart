import 'package:noctambuls/core/domain/services/audio_player_service.dart';

class ListenAudioStateUseCase {
  const ListenAudioStateUseCase(this.service);

  final AudioPlayerService service;

  Stream<String?> call() => service.currentlyPlayingStream;
}
