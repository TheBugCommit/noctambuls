import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class UpdateObservationUseCase {
  UpdateObservationUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationRecord observation) =>
      repository.updateObservation(observation);
}
