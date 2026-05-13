import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class WatchAllSessionsUseCase {
  WatchAllSessionsUseCase(this.repository);

  final SessionRepository repository;

  Stream<List<ObservationSession>> call() => repository.watchAllSessions();
}
