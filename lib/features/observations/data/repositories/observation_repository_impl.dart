import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
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
  Future<Result<Unit>> createSession(ObservationSession session) async {
    try {
      await localDataSource.createSession(
        ObservationSessionModel.fromEntity(session),
      );
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> updateSession(ObservationSession session) async {
    try {
      await localDataSource.updateSession(
        ObservationSessionModel.fromEntity(session),
      );
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> deleteSession(String id) async {
    try {
      await localDataSource.deleteSession(id);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<ObservationSession?>> getSessionById(String id) async {
    try {
      final model = await localDataSource.getSessionById(id);
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Stream<List<ObservationSession>> watchAllSessions() {
    return localDataSource.watchAllSessions().map(
      (models) => models.map((m) => m.toDomain()).toList(),
    );
  }

  @override
  Future<Result<ObservationSession?>> getActiveSession() async {
    try {
      final model = await localDataSource.getActiveSession();
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Stream<ObservationSession?> watchActiveSession() {
    return localDataSource.watchActiveSession().map(
      (model) => model?.toDomain(),
    );
  }

  @override
  Future<Result<Unit>> addObservation(ObservationRecord observation) async {
    try {
      await localDataSource.addObservation(
        ObservationRecordModel.fromEntity(observation),
      );
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> updateObservation(ObservationRecord observation) async {
    try {
      await localDataSource.updateObservation(
        ObservationRecordModel.fromEntity(observation),
      );
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> deleteObservation(String id) async {
    try {
      await localDataSource.deleteObservation(id);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
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
