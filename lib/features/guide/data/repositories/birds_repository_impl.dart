import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_remote_datasource.dart';
import 'package:noctambuls/features/guide/data/models/bird_remote_model.dart';
import 'package:noctambuls/features/guide/data/services/catalog_media_service.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class BirdsRepositoryImpl implements BirdsRepository {
  BirdsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.mediaService,
    required this.logger,
  });

  final BirdsLocalDataSource localDataSource;
  final BirdsRemoteDataSource remoteDataSource;
  final CatalogMediaService mediaService;
  final IAppLogger logger;

  @override
  Future<Result<List<Bird>>> getBirds(String languageCode) async {
    try {
      final models = await localDataSource.getBirds(languageCode);
      return Ok(models);
    } catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<String?>> getLocalVersion() async {
    try {
      final version = await localDataSource.getCatalogVersion();
      return Ok(version);
    } catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<String>> getRemoteVersion() async {
    try {
      final v = await remoteDataSource.getCatalogVersion();
      return Ok(v.version);
    } catch (e, st) {
      final Failure failure = const NetworkFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  @override
  Future<Result<Unit>> downloadAndSaveCatalog() async {
    try {
      final remoteBirds = await remoteDataSource.getBirdsCatalog();
      final remoteCatalogVersion = await remoteDataSource.getCatalogVersion();

      final birdEntities = await _downloadMediaInBatches(remoteBirds);
      final nameEntities = remoteBirds
          .expand((bird) => bird.translations.map((t) => t.toEntityData()))
          .toList();

      await localDataSource.saveFullCatalogTransaction(
        birdEntities,
        nameEntities,
        remoteCatalogVersion.version,
      );

      return const Ok(Unit.instance);
    } catch (e, st) {
      final failure = const CatalogSyncFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  Future<List<BirdEntityData>> _downloadMediaInBatches(
    List<BirdRemoteModel> birds,
  ) async {
    final results = <BirdEntityData>[];
    const batchSize = 5;

    for (var i = 0; i < birds.length; i += batchSize) {
      final end = (i + batchSize < birds.length) ? i + batchSize : birds.length;
      final batch = birds.sublist(i, end);

      final batchFutures = batch.map((bird) async {
        try {
          final (localImage, localAudio) = await (
            mediaService.ensureImage(bird.imagePath),
            mediaService.ensureAudio(bird.audioPath),
          ).wait;

          return bird.toEntityData(
            localImagePath: localImage ?? bird.imagePath,
            localAudioPath: localAudio ?? bird.audioPath,
          );
        } catch (e) {
          logger.warning('Error dowloading resources for bird ${bird.id}: $e');
          return bird.toEntityData(
            localImagePath: bird.imagePath,
            localAudioPath: bird.audioPath,
          );
        }
      });

      results.addAll(await Future.wait(batchFutures));
    }

    return results;
  }
}
