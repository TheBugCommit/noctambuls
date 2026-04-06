import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class DeleteSessionUseCase {
  DeleteSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(String sessionId) =>
      repository.deleteSession(sessionId);
}
