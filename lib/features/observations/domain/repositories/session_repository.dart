import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';

abstract class SessionRepository {
  Future<Result<Unit>> saveSession(ObservationSession session);

  Future<Result<Unit>> deleteSession(String id);

  Future<Result<ObservationSession?>> getSessionById(String id);

  Stream<List<ObservationSession>> watchAllSessions();

  Future<Result<ObservationSession?>> getActiveSession();

  Stream<ObservationSession?> watchActiveSession();

  Stream<ObservationSession?> watchSessionById(String id);

  Stream<List<ObservationSession>> watchOwnSessions(String annotatorId);

  Stream<List<ObservationSession>> watchParticipatedSessions(
    String annotatorId,
  );

  Future<Result<PaginationMeta>> syncPendingSessions();

  Future<Result<PaginationMeta>> fetchAndStoreHistory({
    int limit = 20,
    bool refresh = false,
  });

  Future<Result<PaginationMeta>> fetchAndStoreParticipatedSessions({
    int limit = 20,
    bool refresh = false,
  });
}
