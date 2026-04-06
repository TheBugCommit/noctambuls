import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class DeleteSessionUseCase {
  DeleteSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<void> call(String sessionId) async {
    await repository.deleteSession(sessionId);
  }
}
