import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class WatchObservationsForSessionUseCase {
  WatchObservationsForSessionUseCase(this.repository);

  final ObservationRepository repository;

  Stream<List<ObservationRecord>> call(String sessionId) =>
      repository.watchObservationsForSession(sessionId);
}
