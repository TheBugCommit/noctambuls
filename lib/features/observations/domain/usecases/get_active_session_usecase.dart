import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class GetActiveSessionUseCase {
  GetActiveSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<ObservationSession?> call() => repository.getActiveSession();
}
