import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class UpdateSessionUseCase {
  UpdateSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<void> call(ObservationSession session) async {
    await repository.updateSession(session);
  }
}
