import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class ChangeSessionDateUseCase {
  ChangeSessionDateUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<ObservationSession>> call({
    required String sessionId,
    required DateTime newDate,
  }) async {
    ObservationSession? session;
    final sessionResult = await repository.getSessionById(sessionId);
    if (sessionResult is Err<ObservationSession?>) {
      return Err(sessionResult.failure);
    } else if (sessionResult is Ok<ObservationSession?>) {
      session = sessionResult.value;
    }

    if (session == null) return const Err(SessionNotFoundFailure());

    try {
      final updatedSession = session.changeDate(newDate);
      final result = await repository.saveSession(updatedSession);

      if (result is Err<Unit>) {
        return Err(result.failure);
      }

      return Ok(updatedSession);
    } on SessionUpdateException catch (_) {
      return const Err(SessionLockedFailure());
    }
  }
}
