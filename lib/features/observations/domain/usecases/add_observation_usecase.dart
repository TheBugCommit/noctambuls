import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class AddObservationUseCase {
  AddObservationUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationRecord observation) =>
      repository.addObservation(observation);
}
