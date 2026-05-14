import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class WatchParticipatedSessionsUseCase {
  WatchParticipatedSessionsUseCase(this._repository);

  final SessionRepository _repository;

  Stream<List<ObservationSession>> call(String annotatorId) =>
      _repository.watchParticipatedSessions(annotatorId);
}
