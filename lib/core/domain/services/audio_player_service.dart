import 'package:noctambuls/core/error/result.dart';

abstract class AudioPlayerService {
  Future<Result<Unit>> togglePlay(String path);

  Stream<String?> get currentlyPlayingStream;

  Future<void> stop();

  Future<Result<Unit>> preload(List<String> assetPaths);

  Future<void> dispose();
}
