import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class DeleteObservationUseCase {
  DeleteObservationUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<Unit>> call(String sessionId, String observationId) async {
    final sessionResult = await repository.getSessionById(sessionId);

    return sessionResult.when(
      failure: Err.new,
      success: (session) async {
        if (session == null) {
          return const Err(SessionNotFoundFailure());
        }

        try {
          final updatedSession = session.removeObservation(observationId);

          return await repository.saveSession(updatedSession);
        } on SessionUpdateException catch (_) {
          return const Err(SessionLockedFailure());
        }
      },
    );
  }
}
