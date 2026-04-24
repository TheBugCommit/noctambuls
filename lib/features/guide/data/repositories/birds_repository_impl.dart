import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class BirdsRepositoryImpl implements BirdsRepository {
  BirdsRepositoryImpl({required this.localDataSource});

  final BirdsLocalDataSource localDataSource;

  @override
  Future<Result<List<Bird>>> getBirds(String languageCode) async {
    try {
      final models = await localDataSource.getBirds(languageCode);
      return Ok(models);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }
}
