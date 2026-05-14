import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class SyncPendingSessionsUseCase {
  SyncPendingSessionsUseCase(this._repository);

  final SessionRepository _repository;

  Future<Result<PaginationMeta>> call() => _repository.syncPendingSessions();
}
