import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/exceptions/active_session_already_exists_exception.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class CreateSessionUseCase {
  CreateSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<void> call(ObservationSession session) async {
    final activeSession = await repository.getActiveSession();

    if (activeSession != null) {
      throw const ActiveSessionAlreadyExistsException();
    }

    await repository.createSession(session);
  }
}
