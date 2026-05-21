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

  Future<String> getAbsolutePath(String relativePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    return p.join(appDir.path, relativePath);
  }

  Future<String?> _ensureFile(String serverPath, String subDir) async {
    try {
      final fileName = serverPath.split('/').last;
      final appDir = await getApplicationDocumentsDirectory();

      final relativePath = p.join(_parentFolder, subDir, fileName);
      final dir = Directory(p.join(appDir.path, _parentFolder, subDir));

      if (!dir.existsSync()) await dir.create(recursive: true);
      final localPath = p.join(appDir.path, relativePath);

      if (File(localPath).existsSync()) return relativePath;

      await dio.download('${EnvConfig.serverUrl}$serverPath', localPath);
      return relativePath;
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

      final validImagesSet = validImagePaths
          .map((path) => p.normalize(p.join(appDir.path, path)))
          .toSet();

      final validAudioSet = validAudioPaths
          .map((path) => p.normalize(p.join(appDir.path, path)))
          .toSet();

      final imageDir = Directory(
          p.join(appDir.path, _parentFolder, _imageFolder
          ));
      final audioDir = Directory(
          p.join(appDir.path, _parentFolder, _audioFolder)
      );

      await Future.wait([
        _deleteFiles(filesDir: imageDir, validPaths: validImagesSet),
        _deleteFiles(filesDir: audioDir, validPaths: validAudioSet),
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
