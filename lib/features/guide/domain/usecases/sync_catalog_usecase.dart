import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class SyncCatalogUseCase {
  const SyncCatalogUseCase(this._repository);

  final BirdsRepository _repository;

  Future<Result<Unit>> call() => _repository.syncCatalog();
}
