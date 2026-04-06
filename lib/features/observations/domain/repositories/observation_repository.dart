import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

abstract class ObservationRepository {
  Future<Result<Unit>> createSession(ObservationSession session);

  Future<Result<Unit>> updateSession(ObservationSession session);

  Future<Result<Unit>> deleteSession(String id);

  Future<Result<ObservationSession?>> getSessionById(String id);

  Stream<List<ObservationSession>> watchAllSessions();

  Future<Result<ObservationSession?>> getActiveSession();

  Stream<ObservationSession?> watchActiveSession();

  Future<Result<Unit>> addObservation(ObservationRecord observation);

  Future<Result<Unit>> updateObservation(ObservationRecord observation);

  Future<Result<Unit>> deleteObservation(String id);

  Stream<List<ObservationRecord>> watchObservationsForSession(String sessionId);
}
