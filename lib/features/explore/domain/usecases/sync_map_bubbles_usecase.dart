import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/explore/domain/repositories/explore_repository.dart';

class SyncMapBubblesUseCase {
  const SyncMapBubblesUseCase(this._repository);

  final ExploreRepository _repository;

  Future<Result<Unit>> call({bool force = false}) =>
      _repository.syncIfStale(force: force);
}
