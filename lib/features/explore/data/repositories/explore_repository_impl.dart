import 'package:dio/dio.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/explore/data/datasources/explore_local_datasource.dart';
import 'package:noctambuls/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:noctambuls/features/explore/data/models/api/map_bubbles_response_model.dart';
import 'package:noctambuls/features/explore/data/models/map_bubble_model.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';
import 'package:noctambuls/features/explore/domain/failures/explore_failures.dart';
import 'package:noctambuls/features/explore/domain/repositories/explore_repository.dart';

const _sinceKey = 'explore_bubbles_since';
const _lastSyncKey = 'explore_bubbles_last_sync';
const _cacheDuration = Duration(seconds: 4);

class ExploreRepositoryImpl implements ExploreRepository {
  const ExploreRepositoryImpl({
    required this.local,
    required this.remote,
  });

  final ExploreLocalDataSource local;
  final ExploreRemoteDataSource remote;

  @override
  Stream<List<MapBubble>> watchAll() {
    return local.watchAll().map(
      (models) => models.map((m) => m.toDomain()).toList(),
    );
  }

  @override
  Future<Result<Unit>> syncIfStale({bool force = false}) async {
    try {
      if (!force && await _isCacheValid()) return const Ok(Unit.instance);

      final since = await local.getSyncSince(_sinceKey);
      final response = await remote.fetch(since: since);
      final models = response.items.map((dto) => dto.toModel()).toList();
      await local.bulkUpsert(models);
      await local.saveSyncMetadata(_sinceKey, since: response.serverTime);
      await local.saveSyncMetadata(
        _lastSyncKey,
        since: DateTime.now().toUtc().toIso8601String(),
      );
      return const Ok(Unit.instance);
    } on DioException catch (e, st) {
      return Err(const ExploreFetchFailure().withDebug(e, st));
    } on Exception catch (e, st) {
      return Err(const ExploreDatabaseFailure().withDebug(e, st));
    }
  }

  Future<bool> _isCacheValid() async {
    final lastSyncStr = await local.getSyncSince(_lastSyncKey);
    if (lastSyncStr == null) return false;
    final lastSync = DateTime.parse(lastSyncStr).toUtc();
    return DateTime.now().toUtc().difference(lastSync) < _cacheDuration;
  }
}
