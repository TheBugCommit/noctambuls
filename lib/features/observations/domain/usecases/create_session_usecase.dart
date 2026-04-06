import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class CreateSessionUseCase {
  CreateSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationSession session) async {
    final activeSessionResult = await repository.getActiveSession();
    return activeSessionResult.when(
      success: (activeSession) async {
        if (activeSession != null) {
          return const Err(ActiveSessionAlreadyExistsFailure());
        }
        return repository.createSession(session);
      },
      failure: Err.new,
    );
  }
}
