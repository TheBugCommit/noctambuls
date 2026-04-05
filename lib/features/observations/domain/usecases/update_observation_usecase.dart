import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class UpdateObservationUseCase {
  UpdateObservationUseCase(this.repository);

  final ObservationRepository repository;

  Future<void> call(ObservationRecord observation) async {
    await repository.updateObservation(observation);
  }
}
