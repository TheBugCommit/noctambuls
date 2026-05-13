import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class FinishAndLockSessionUseCase {
  FinishAndLockSessionUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<Unit>> call(ObservationSession session) async {
    final updated = session.finishAndLock();
    return repository.saveSession(updated);
  }
}
