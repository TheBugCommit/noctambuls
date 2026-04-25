import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/audio_service.dart';

class SoLoudAudioService implements AudioService {
  bool _isInitialized = false;
  final Map<String, AudioSource> _loadedSources = {};
  SoundHandle? _currentHandle;

  final ValueNotifier<String?> _currentlyPlaying = ValueNotifier(null);
  StreamSubscription<void>? _finishedSubscription;

  @override
  ValueListenable<String?> get currentlyPlaying => _currentlyPlaying;

  @override
  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await SoLoud.instance.init();
      _isInitialized = true;
    } on Exception catch (e, st) {
      AppLogger.failure(const AudioFailure().withDebug(e, st));
    }
  }

  @override
  Future<void> preload(List<String> assetPaths) async {
    if (!_isInitialized) await init();

    final futures = assetPaths
        .where((path) => path.isNotEmpty && !_loadedSources.containsKey(path))
        .map((path) async {
          try {
            final source = await SoLoud.instance.loadAsset(path);
            _loadedSources[path] = source;
          } on Exception catch (e, st) {
            AppLogger.failure(const AudioFailure().withDebug(e, st));
          }
        });

    await Future.wait(futures);
  }

  @override
  Future<void> togglePlay(String assetPath) async {
    if (_currentlyPlaying.value == assetPath) {
      await stop();
      return;
    }

    if (!_isInitialized) await init();

    await stop();

    _currentlyPlaying.value = assetPath;

    try {
      AudioSource source;

      if (_loadedSources.containsKey(assetPath)) {
        source = _loadedSources[assetPath]!;
      } else {
        source = await SoLoud.instance.loadAsset(assetPath);
        _loadedSources[assetPath] = source;
      }

      if (_currentlyPlaying.value != assetPath) return;

      _currentHandle = SoLoud.instance.play(source);

      await _finishedSubscription?.cancel();
      _finishedSubscription = source.allInstancesFinished.listen((_) {
        if (_currentlyPlaying.value == assetPath) {
          _currentlyPlaying.value = null;
        }
      });
    } on Exception catch (e, st) {
      AppLogger.failure(const AudioFailure().withDebug(e, st));

      if (_currentlyPlaying.value == assetPath) {
        _currentlyPlaying.value = null;
      }
    }
  }

  @override
  Future<void> stop() async {
    await _finishedSubscription?.cancel();
    _finishedSubscription = null;

    if (_currentHandle != null) {
      await SoLoud.instance.stop(_currentHandle!);
      _currentHandle = null;
    }

    _currentlyPlaying.value = null;
  }

  @override
  Future<void> dispose() async {
    await stop();
    await SoLoud.instance.disposeAllSources();
    SoLoud.instance.deinit();

    _loadedSources.clear();
    _currentlyPlaying.dispose();
    _isInitialized = false;
  }
}
