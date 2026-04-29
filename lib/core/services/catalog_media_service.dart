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
}
