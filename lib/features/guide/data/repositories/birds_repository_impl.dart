import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/catalog_media_service.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_remote_datasource.dart';
import 'package:noctambuls/features/guide/data/models/bird_remote_model.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class BirdsRepositoryImpl implements BirdsRepository {
  BirdsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.mediaService,
  });

  final BirdsLocalDataSource localDataSource;
  final BirdsRemoteDataSource remoteDataSource;
  final CatalogMediaService mediaService;

  bool _syncedThisSession = false;

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
  Future<Result<Unit>> syncCatalog() async {
    if (_syncedThisSession) return const Ok(Unit.instance);

    final (remoteVersion, localVersion) = await (
      _fetchRemoteVersion(),
      localDataSource.getCatalogVersion(),
    ).wait;

    try {
      if (remoteVersion == null && localVersion == null) {
        final failure = const CatalogSyncFailure().withDebug(
          Exception(
            'Error de sincronització: versió remota i local són nul·les. No hi ha dades.',
          ),
          StackTrace.current,
        );
        AppLogger.failure(failure);
        return Err(failure);
      }

      if (remoteVersion == null || remoteVersion == localVersion) {
        _syncedThisSession = true;
        return const Ok(Unit.instance);
      }

      // 1. Obtenim les dades ESSENCIALS de text.
      final remoteBirds = await remoteDataSource.getBirdsCatalog();

      // 2. Descarreguem els fitxers de forma concurrent però segura (per lots).
      final birdEntities = await _downloadMediaInBatches(remoteBirds);

      // 3. Mapegem les traduccions ràpidament
      final nameEntities = remoteBirds
          .expand((bird) => bird.translations.map((t) => t.toEntityData()))
          .toList();

      // 4. Guardem TOT el catàleg. Si hem arribat aquí, tenim com a mínim
      // les dades essencials, fins i tot si algun àudio ha fallat.
      await localDataSource.saveFullCatalogTransaction(
        birdEntities,
        nameEntities,
        remoteVersion,
      );

      _syncedThisSession = true;
      return const Ok(Unit.instance);
    } catch (e, st) {
      final failure = const CatalogSyncFailure().withDebug(e, st);
      AppLogger.failure(failure);
      return Err(failure);
    }
  }

  /// Descarrega imatges i àudios agrupant-los per evitar saturar la xarxa
  /// i captura els errors individualment per no trencar la sincronització.
  Future<List<BirdEntityData>> _downloadMediaInBatches(
    List<BirdRemoteModel> birds,
  ) async {
    final results = <BirdEntityData>[];
    const batchSize = 5;

    for (var i = 0; i < birds.length; i += batchSize) {
      final end = (i + batchSize < birds.length) ? i + batchSize : birds.length;
      final batch = birds.sublist(i, end);

      // Creem les promeses (Futures) per aquest lot concret
      final batchFutures = batch.map((bird) async {
        try {
          // Descarreguem foto i àudio de l'ocell ALHORA
          final (localImage, localAudio) = await (
            mediaService.ensureImage(bird.imagePath),
            mediaService.ensureAudio(bird.audioPath),
          ).wait;

          return bird.toEntityData(
            localImagePath: localImage ?? bird.imagePath,
            localAudioPath: localAudio ?? bird.audioPath,
          );
        } catch (e) {
          // RESILIÈNCIA: Si peta el fitxer, guardem l'ocell amb la URL original.
          // D'aquesta manera no perdem l'espècie de la base de dades.
          AppLogger.warning('Error descarregant arxius per ${bird.id}: $e');
          return bird.toEntityData(
            localImagePath: bird.imagePath,
            localAudioPath: bird.audioPath,
          );
        }
      });

      // Esperem a que els 5 ocells acabin per passar als següents 5
      results.addAll(await Future.wait(batchFutures));
    }

    return results;
  }

  Future<String?> _fetchRemoteVersion() async {
    try {
      final v = await remoteDataSource.getCatalogVersion();
      return v.version;
    } catch (e) {
      AppLogger.warning('Catalog version check failed (offline?): $e');
      return null;
    }
  }
}
