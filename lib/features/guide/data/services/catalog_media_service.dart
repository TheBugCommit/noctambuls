import 'dart:io';

import 'package:dio/dio.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:path_provider/path_provider.dart';

class CatalogMediaService {
  const CatalogMediaService({required this.dio, required this.logger});

  final Dio dio;
  final IAppLogger logger;

  Future<String?> ensureImage(String serverPath) =>
      _ensureFile(serverPath, 'images');

  Future<String?> ensureAudio(String serverPath) =>
      _ensureFile(serverPath, 'audio');

  Future<String?> _ensureFile(String serverPath, String subDir) async {
    try {
      final fileName = serverPath.split('/').last;
      final appDir = await getApplicationDocumentsDirectory();
      final dir = Directory('${appDir.path}/catalog/$subDir');
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

  /* Future<void> cleanOrphanedFiles() async {
    try {
      // 1. Demanem a la Base de dades totes les rutes locals ACTUALS que tenim guardades
      // (Això requerirà que passis el BirdsLocalDataSource al servei o ho facis des del repositori)
      final requiredImagePaths = await localDataSource.getAllLocalImagePaths();
      final requiredAudioPaths = await localDataSource.getAllLocalAudioPaths();

      final validPaths = {...requiredImagePaths, ...requiredAudioPaths}.whereType<String>().toSet();

      final appDir = await getApplicationDocumentsDirectory();
      final catalogDir = Directory('${appDir.path}/catalog');

      // 2. Iterem TOT el directori de forma recursiva
      if (catalogDir.existsSync()) {
        await for (final entity in catalogDir.list(recursive: true)) {
          if (entity is File) {
            // Si el fitxer que trobem NO està a la llista de la Base de Dades, l'esborrem.
            // És brossa o pertanyia a una versió antiga.
            if (!validPaths.contains(entity.path)) {
              await entity.delete();
            }
          }
        }
      }
    } catch (e) {
      logger.warning('Failed to clean orphaned files: $e');
    }
  }*/
}
