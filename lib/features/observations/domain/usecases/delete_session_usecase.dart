import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class DeleteObservationUseCase {
  DeleteObservationUseCase(this.repository);

  final ObservationRepository repository;

  Future<void> call(String observationId) async {
    await repository.deleteObservation(observationId);
  }
}
