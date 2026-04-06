import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class UpdateSessionUseCase {
  UpdateSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationSession session) =>
      repository.updateSession(session);
}
