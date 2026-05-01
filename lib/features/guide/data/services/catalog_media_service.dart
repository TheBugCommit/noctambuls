import 'dart:io';

import 'package:dio/dio.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CatalogMediaService {
  const CatalogMediaService({required this.dio, required this.logger});

  static const _parentFolder = 'catalog';
  static const _imageFolder = 'images';
  static const _audioFolder = 'audio';

  final Dio dio;
  final IAppLogger logger;

  Future<String?> ensureImage(String serverPath) =>
      _ensureFile(serverPath, _imageFolder);

  Future<String?> ensureAudio(String serverPath) =>
      _ensureFile(serverPath, _audioFolder);

  Future<String?> _ensureFile(String serverPath, String subDir) async {
    try {
      final fileName = serverPath.split('/').last;
      final appDir = await getApplicationDocumentsDirectory();
      final dir = Directory('${appDir.path}/$_parentFolder/$subDir');
      if (!dir.existsSync()) await dir.create(recursive: true);

      final localPath = '${dir.path}/$fileName';
      if (File(localPath).existsSync()) return localPath;

      await dio.download('${EnvConfig.serverUrl}$serverPath', localPath);
      return localPath;
    } catch (e) {
      logger.warning('Failed to download media $serverPath: $e');
      return null;
    }
  }

  Future<void> cleanOrphanedFiles({
    required List<String> validImagePaths,
    required List<String> validAudioPaths,
  }) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();

      final imageDir = Directory(
        p.join(appDir.path, _parentFolder, _imageFolder),
      );
      final audioDir = Directory(
        p.join(appDir.path, _parentFolder, _audioFolder),
      );

      final validImagesSet = validImagePaths.map(p.normalize).toSet();
      final validAudioSet = validAudioPaths.map(p.normalize).toSet();

      await Future.wait([
        _deleteFiles(
          filesDir: imageDir,
          validPaths: validImagesSet,
        ),
        _deleteFiles(
          filesDir: audioDir,
          validPaths: validAudioSet,
        ),
      ]);
    } catch (e) {
      logger.warning('Failed to clean orphaned media files: $e');
    }
  }

  Future<void> _deleteFiles({
    required Directory filesDir,
    required Set<String> validPaths,
  }) async {
    if (!await filesDir.exists()) return;

    await for (final entity in filesDir.list()) {
      if (entity is! File) continue;
      final normalizedEntityPath = p.normalize(entity.path);

      if (!validPaths.contains(normalizedEntityPath)) {
        try {
          await entity.delete();
          logger.info('Deleted orphaned: ${entity.path}');
        } catch (e) {
          logger.warning('Failed to delete file ${entity.path}: $e');
        }
      }
    }
  }
}
