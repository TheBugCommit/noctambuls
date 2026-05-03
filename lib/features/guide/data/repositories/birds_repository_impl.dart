import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_remote_datasource.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';
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
      return Ok(models.map((e) => e.toDomain()).toList());
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
      final localCatalogVersion = await localDataSource.getCatalogVersion();
      final remoteCatalogVersion = await remoteDataSource.getCatalogVersion();

      var hasMediaErrors = false;
      final birdEntities = await _downloadMediaInBatches(
        remoteBirds,
        () => hasMediaErrors = true,
      );
      final nameEntities = remoteBirds
          .expand((bird) => bird.translations.map((t) => t.toEntityData()))
          .toList();

      await localDataSource.saveFullCatalogTransaction(
        birdEntities,
        nameEntities,
        hasMediaErrors ? localCatalogVersion : remoteCatalogVersion.version,
      );

      try {
        final (validImagePaths, validAudioPaths) = await (
          localDataSource.getAllLocalImagePaths(),
          localDataSource.getAllLocalAudioPaths(),
        ).wait;

        await mediaService.cleanOrphanedFiles(
          validAudioPaths: validAudioPaths,
          validImagePaths: validImagePaths,
        );
      } catch (cleanupError) {
        logger.warning(
          'Cleanup operation failed, but sync was successful: $cleanupError',
        );
      }

      return const Ok(Unit.instance);
    } catch (e, st) {
      final failure = const CatalogSyncFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  Future<List<BirdEntityData>> _downloadMediaInBatches(
    List<BirdRemoteModel> birds,
    void Function() onMediaError,
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

          if (localImage == null || localAudio == null) {
            throw Exception('Error downloading resources');
          }

          return bird.toEntityData(
            localImagePath: localImage,
            localAudioPath: localAudio,
          );
        } catch (e) {
          logger.warning(
            'Error dowloading resources for bird ${bird.id}: $e',
          );
          onMediaError();
          return bird.toEntityData(
            localImagePath: null,
            localAudioPath: null,
          );
        }
      });

      results.addAll(await Future.wait(batchFutures));
    }

    return results;
  }
}
