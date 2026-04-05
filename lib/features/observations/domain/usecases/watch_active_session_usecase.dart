import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class WatchActiveSessionUseCase {
  WatchActiveSessionUseCase(this.repository);

  final ObservationRepository repository;

  Stream<ObservationSession?> call() => repository.watchActiveSession();
}
