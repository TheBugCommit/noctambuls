import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class DeleteSessionUseCase {
  DeleteSessionUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<Unit>> call(String sessionId) =>
      repository.deleteSession(sessionId);
}
