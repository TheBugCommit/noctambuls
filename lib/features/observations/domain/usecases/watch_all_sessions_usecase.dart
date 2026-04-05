import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class WatchAllSessionsUseCase {
  WatchAllSessionsUseCase(this.repository);

  final ObservationRepository repository;

  Stream<List<ObservationSession>> call() => repository.watchAllSessions();
}
