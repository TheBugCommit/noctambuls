import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({required this.localDataSource});

  final SessionLocalDataSource localDataSource;

  @override
  Future<Result<Unit>> saveSession(ObservationSession session) async {
    try {
      await localDataSource.save(
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
      await localDataSource.delete(id);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<ObservationSession?>> getSessionById(String id) async {
    try {
      final model = await localDataSource.getById(id);
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Stream<List<ObservationSession>> watchAllSessions() {
    return localDataSource.watchAll().map(
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
  Stream<ObservationSession?> watchSessionById(String id) {
    return localDataSource
        .watchSessionById(id)
        .map(
          (model) => model?.toDomain(),
        );
  }
}
