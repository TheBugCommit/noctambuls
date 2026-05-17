import 'package:dio/dio.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_local_datasource.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_remote_datasource.dart';
import 'package:noctambuls/features/censuses/data/models/api/censuses_response_model.dart';
import 'package:noctambuls/features/censuses/data/models/census_model.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

const _censusesSinceKey = 'censuses_since';

class CensusRepositoryImpl implements CensusRepository {
  const CensusRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final CensusLocalDataSource localDataSource;
  final CensusRemoteDataSource remoteDataSource;

  @override
  Stream<List<Census>> watchAll() {
    return localDataSource.watchAll().map(
      (models) => models.map((m) => m.toDomain()).toList(),
    );
  }

  @override
  Stream<Census?> watchJoinedCensus() {
    return localDataSource.watchJoinedCensus().map(
      (model) => model?.toDomain(),
    );
  }

  @override
  Future<Result<Census?>> getById(String id) async {
    try {
      final model = await localDataSource.getById(id);
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const CensusDatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Census?>> getJoinedCensus() async {
    try {
      final model = await localDataSource.getJoinedCensus();
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const CensusDatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> save(Census census) async {
    try {
      await localDataSource.save(CensusModel.fromEntity(census));
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const CensusDatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> fetchAndSync() async {
    try {
      final since = await localDataSource.getSyncSince(_censusesSinceKey);
      final response = await remoteDataSource.fetchCensuses(since: since);
      final models = response.censuses.map((dto) => dto.toModel()).toList();
      final toDelete = models.where((m) => m.isDeleted).map((m) => m.id).toList();
      final toUpsert = models.where((m) => !m.isDeleted).toList();
      await localDataSource.delete(toDelete);
      await localDataSource.bulkUpsert(toUpsert);
      await localDataSource.saveSyncMetadata(
        _censusesSinceKey,
        since: response.serverTime,
      );
      return const Ok(Unit.instance);
    } on DioException catch (e, st) {
      return Err(const CensusFetchFailure().withDebug(e, st));
    } on Exception catch (e, st) {
      return Err(const CensusDatabaseFailure().withDebug(e, st));
    }
  }
}
