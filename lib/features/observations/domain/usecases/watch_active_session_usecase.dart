import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class WatchActiveSessionUseCase {
  WatchActiveSessionUseCase(this.repository);

  final SessionRepository repository;

  Stream<ObservationSession?> call() => repository.watchActiveSession();
}
