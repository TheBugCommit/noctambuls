import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class SyncCatalogUseCase {
  SyncCatalogUseCase(this._repository);

  final BirdsRepository _repository;

  Future<Result<Unit>> call() async {
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
      return const Ok(Unit.instance);
    }

    final syncResult = await _repository.downloadAndSaveCatalog();
    return syncResult;
  }
}
