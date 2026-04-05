import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

abstract class ObservationRepository {
  Future<void> createSession(ObservationSession session);

  Future<void> updateSession(ObservationSession session);

  Future<void> deleteSession(String id);

  Future<ObservationSession?> getSessionById(String id);

  Stream<List<ObservationSession>> watchAllSessions();

  Future<ObservationSession?> getActiveSession();

  Stream<ObservationSession?> watchActiveSession();

  Future<void> addObservation(ObservationRecord observation);

  Future<void> updateObservation(ObservationRecord observation);

  Future<void> deleteObservation(String id);

  Stream<List<ObservationRecord>> watchObservationsForSession(String sessionId);
}
