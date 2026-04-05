import 'package:noctambuls/features/observations/data/datasources/observation_local_datasource.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class ObservationRepositoryImpl implements ObservationRepository {
  ObservationRepositoryImpl({required this.localDataSource});

  final ObservationLocalDataSource localDataSource;

  @override
  Future<void> createSession(ObservationSession session) async {
    final sessionModel = ObservationSessionModel.fromEntity(session);
    await localDataSource.createSession(sessionModel);
  }

  @override
  Future<void> updateSession(ObservationSession session) async {
    final sessionModel = ObservationSessionModel.fromEntity(session);
    await localDataSource.updateSession(sessionModel);
  }

  @override
  Future<void> deleteSession(String id) async {
    await localDataSource.deleteObservation(id);
  }

  @override
  Future<ObservationSession?> getSessionById(String id) async {
    return localDataSource.getSessionById(id);
  }

  @override
  Stream<List<ObservationSession>> watchAllSessions() {
    return localDataSource.watchAllSessions();
  }

  @override
  Future<ObservationSession?> getActiveSession() =>
      localDataSource.getActiveSession();

  @override
  Stream<ObservationSession?> watchActiveSession() =>
      localDataSource.watchActiveSession();

  @override
  Future<void> addObservation(ObservationRecord observation) async {
    final observationModel = ObservationRecordModel.fromEntity(observation);
    await localDataSource.addObservation(observationModel);
  }

  @override
  Future<void> updateObservation(ObservationRecord observation) async {
    final observationModel = ObservationRecordModel.fromEntity(observation);
    await localDataSource.updateObservation(observationModel);
  }

  @override
  Future<void> deleteObservation(String id) async {
    await localDataSource.deleteObservation(id);
  }

  @override
  Stream<List<ObservationRecord>> watchObservationsForSession(
    String sessionId,
  ) {
    return localDataSource.watchObservationsForSession(sessionId);
  }
}
