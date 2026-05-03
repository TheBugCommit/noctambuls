import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

abstract class BirdsRepository {
  Future<Result<List<Bird>>> getBirds(String languageCode);

  Future<Result<String?>> getLocalVersion();

  Future<Result<String>> getRemoteVersion();

  Future<Result<Unit>> downloadAndSaveCatalog();
}
