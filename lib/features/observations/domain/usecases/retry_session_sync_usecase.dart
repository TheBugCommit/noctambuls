import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class RetrySessionSyncUseCase {
  RetrySessionSyncUseCase(this._repository);

  final SessionRepository _repository;

  Future<Result<PaginationMeta>> call(String sessionId) async {
    final getResult = await _repository.getSessionById(sessionId);

    return getResult.when(
      failure: Err.new,
      success: (session) async {
        if (session == null) {
          return const Err(SessionNotFoundFailure());
        }

        final updated = session.markBackToPending();
        final saveResult = await _repository.saveSession(updated);

        return saveResult.when(
          failure: Err.new,
          success: (_) => _repository.syncPendingSessions(),
        );
      },
    );
  }
}
