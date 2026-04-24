import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

abstract class BirdsRepository {
  Future<Result<List<Bird>>> getBirds(String languageCode);
}
