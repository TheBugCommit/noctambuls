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
    await localDataSource.createSession(
      ObservationSessionModel.fromEntity(session),
    );
  }

  @override
  Future<void> updateSession(ObservationSession session) async {
    await localDataSource.updateSession(
      ObservationSessionModel.fromEntity(session),
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await localDataSource.deleteSession(id);
  }

  @override
  Future<ObservationSession?> getSessionById(String id) async {
    final model = await localDataSource.getSessionById(id);
    return model?.toDomain();
  }

  @override
  Stream<List<ObservationSession>> watchAllSessions() {
    return localDataSource.watchAllSessions().map(
      (models) => models.map((m) => m.toDomain()).toList(),
    );
  }

  @override
  Future<ObservationSession?> getActiveSession() async {
    final model = await localDataSource.getActiveSession();
    return model?.toDomain();
  }

  @override
  Stream<ObservationSession?> watchActiveSession() {
    return localDataSource.watchActiveSession().map(
      (model) => model?.toDomain(),
    );
  }

  @override
  Future<void> addObservation(ObservationRecord observation) async {
    await localDataSource.addObservation(
      ObservationRecordModel.fromEntity(observation),
    );
  }

  @override
  Future<void> updateObservation(ObservationRecord observation) async {
    await localDataSource.updateObservation(
      ObservationRecordModel.fromEntity(observation),
    );
  }

  @override
  Future<void> deleteObservation(String id) async {
    await localDataSource.deleteObservation(id);
  }

  @override
  Stream<List<ObservationRecord>> watchObservationsForSession(
    String sessionId,
  ) {
    return localDataSource
        .watchObservationsForSession(sessionId)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }
}
