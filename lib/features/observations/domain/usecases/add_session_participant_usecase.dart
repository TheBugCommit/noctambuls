import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class AddSessionParticipantUseCase {
  AddSessionParticipantUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<ObservationSession>> call(
    ObservationSession session,
    String ornithologistCode,
  ) async {
    try {
      final updatedSession = session.addParticipant(ornithologistCode);

      final result = await repository.saveSession(updatedSession);

      return result.when(
        success: (_) => Ok(updatedSession),
        failure: Err.new,
      );
    } on InvalidParticipantCodeException {
      return const Err(InvalidParticipantCodeFailure());
    } on SessionUpdateException {
      return const Err(SessionLockedFailure());
    }
  }
}
