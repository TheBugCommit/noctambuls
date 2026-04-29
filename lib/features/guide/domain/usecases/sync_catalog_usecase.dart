import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class SyncCatalogUseCase {
  SyncCatalogUseCase(this._repository);

  final BirdsRepository _repository;

  bool _syncedThisSession = false;

  Future<Result<Unit>> call() async {
    if (_syncedThisSession) return const Ok(Unit.instance);

    final localVersionResult = await _repository.getLocalVersion();
    final remoteVersionResult = await _repository.getRemoteVersion();

    String? localVersion;
    localVersionResult.when(
      success: (version) => localVersion = version,
      failure: (_) => localVersion = null,
    );

    String? remoteVersion;
    remoteVersionResult.when(
      success: (version) => remoteVersion = version,
      failure: (_) => remoteVersion = null,
    );

    if (remoteVersion == null && localVersion == null) {
      return Err(
        const CatalogSyncFailure().withDebug(
          'Error synchronizing remote version remote and local versions are null',
        ),
      );
    }

    if (remoteVersion == null || remoteVersion == localVersion) {
      _syncedThisSession = true;
      return const Ok(Unit.instance);
    }

    final syncResult = await _repository.downloadAndSaveCatalog();

    if (syncResult.isOk) {
      _syncedThisSession = true;
    }

    return syncResult;
  }
}
