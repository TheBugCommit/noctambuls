import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class WatchSessionByIdUseCase {
  WatchSessionByIdUseCase(this.repository);

  final SessionRepository repository;

  Stream<ObservationSession?> call(String id) =>
      repository.watchSessionById(id);
}
