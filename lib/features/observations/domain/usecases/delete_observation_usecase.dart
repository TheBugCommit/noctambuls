import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class DeleteObservationUseCase {
  DeleteObservationUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(String observationId) =>
      repository.deleteObservation(observationId);
}
