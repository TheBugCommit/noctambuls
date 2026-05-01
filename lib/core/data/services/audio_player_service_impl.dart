import 'dart:async';
import 'dart:io';

import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:noctambuls/core/domain/services/audio_player_service.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';

class SoLoudAudioServiceImpl implements AudioPlayerService {
  SoLoudAudioServiceImpl({required this.logger});

  final IAppLogger logger;

  bool _isInitialized = false;
  final Map<String, AudioSource> _loadedSources = {};
  SoundHandle? _currentHandle;

  // 1. Canviem ValueNotifier per un StreamController tipus "broadcast"
  // Un broadcast permet que múltiples BLoCs s'hi puguin subscriure alhora.
  final StreamController<String?> _currentlyPlayingController =
      StreamController<String?>.broadcast();

  // 2. Mantenim una variable privada per saber el path actual de forma síncrona dins d'aquesta classe
  String? _currentPlayingPath;
  StreamSubscription<void>? _finishedSubscription;

  // 3. Exposem l'Stream segons el contracte del domini
  @override
  Stream<String?> get currentlyPlayingStream =>
      _currentlyPlayingController.stream;

  // Mètode privat d'ajuda per no repetir l'addició a l'stream
  void _updateState(String? path) {
    _currentPlayingPath = path;
    _currentlyPlayingController.add(path);
  }

  // Si vols mantenir init() i preload() al domini, assegura't que AudioPlayerRepository els inclou
  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await SoLoud.instance.init();
      _isInitialized = true;
    } on Exception catch (e, st) {
      logger.failure(const AudioFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> preload(List<String> assetPaths) async {
    if (!_isInitialized) await init();

    final futures = assetPaths
        .where((path) => path.isNotEmpty && !_loadedSources.containsKey(path))
        .map((path) async {
          try {
            if (File(path).existsSync()) {
              final source = await SoLoud.instance.loadFile(path);
              _loadedSources[path] = source;
            } else {
              final source = await SoLoud.instance.loadUrl(path);
              _loadedSources[path] = source;
            }
          } catch (e, st) {
            logger.failure(const AudioFailure().withDebug(e, st));
          }
        });

    await Future.wait(futures);

    return const Ok(Unit.instance);
  }

  @override
  Future<Result<Unit>> togglePlay(String assetPath) async {
    if (_currentPlayingPath == assetPath) {
      await stop();
      return const Ok(Unit.instance);
    }

    if (!_isInitialized) await init();

    await stop();
    _updateState(assetPath);

    try {
      AudioSource source;

      if (_loadedSources.containsKey(assetPath)) {
        source = _loadedSources[assetPath]!;
      } else {
        if (File(assetPath).existsSync()) {
          source = await SoLoud.instance.loadFile(assetPath);
          _loadedSources[assetPath] = source;
        } else {
          final failure = const AudioFailure().withDebug(
            'Audio file not found locally: $assetPath',
          );
          logger.warning(failure.debugMessage);
          _updateState(null);
          return Err(failure);
        }
      }

      if (_currentPlayingPath != assetPath) {
        return const Ok(Unit.instance);
      }

      _currentHandle = SoLoud.instance.play(source);

      await _finishedSubscription?.cancel();
      _finishedSubscription = source.allInstancesFinished.listen((_) {
        if (_currentPlayingPath == assetPath) {
          _updateState(null);
        }
      });

      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      final failure = const AudioFailure().withDebug(e, st);
      logger.failure(failure);

      if (_currentPlayingPath == assetPath) {
        _updateState(null);
      }

      return Err(failure);
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

    _updateState(null);
  }

  @override
  Future<void> dispose() async {
    await stop();
    await SoLoud.instance.disposeAllSources();
    SoLoud.instance.deinit();

    _loadedSources.clear();
    _updateState(null);
    _isInitialized = false;

    await _currentlyPlayingController.close();
  }
}
