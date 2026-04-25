import 'package:flutter/foundation.dart';

abstract class AudioService {
  Future<void> init();

  Future<void> preload(List<String> assetPaths);

  Future<bool> togglePlay(String assetPath);

  Future<void> stop();

  ValueListenable<String?> get currentlyPlaying;

  Future<void> dispose();
}
