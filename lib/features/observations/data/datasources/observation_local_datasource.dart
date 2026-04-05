import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';

abstract class ObservationLocalDataSource {
  Future<void> createSession(ObservationSessionModel session);

  Future<void> updateSession(ObservationSessionModel session);

  Future<void> deleteSession(String id);

  Future<ObservationSessionModel?> getSessionById(String id);

  Stream<List<ObservationSessionModel>> watchAllSessions();

  Future<ObservationSessionModel?> getActiveSession();

  Stream<ObservationSessionModel?> watchActiveSession();

  Future<void> addObservation(ObservationRecordModel observation);

  Future<void> updateObservation(ObservationRecordModel observation);

  Future<void> deleteObservation(String id);

  Stream<List<ObservationRecordModel>> watchObservationsForSession(
    String sessionId,
  );
}

class ObservationLocalDataSourceImpl implements ObservationLocalDataSource {
  ObservationLocalDataSourceImpl({required this.db});

  final AppDatabase db;

  @override
  Future<void> createSession(ObservationSessionModel session) async {
    await db.into(db.sessionsTable).insert(_createSessionCompanion(session));
  }

  @override
  Future<void> updateSession(ObservationSessionModel session) async {
    await db.update(db.sessionsTable).replace(_createSessionCompanion(session));
  }

  @override
  Future<void> deleteSession(String id) async {
    await db.transaction(() async {
      await (db.update(db.sessionsTable)..where((tbl) => tbl.id.equals(id)))
          .write(const SessionsTableCompanion(isDeleted: Value(true)));

      await (db.update(db.observationsTable)
            ..where((tbl) => tbl.sessionId.equals(id)))
          .write(const ObservationsTableCompanion(isDeleted: Value(true)));
    });
  }

  @override
  Future<ObservationSessionModel?> getSessionById(String id) async {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    return result != null ? ObservationSessionModel.toModel(result) : null;
  }

  @override
  Stream<List<ObservationSessionModel>> watchAllSessions() {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.isDeleted.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().map(
      (rows) => rows.map(ObservationSessionModel.toModel).toList(),
    );
  }

  @override
  Future<ObservationSessionModel?> getActiveSession() async {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.isLocked.equals(false) & tbl.isDeleted.equals(false))
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result != null ? ObservationSessionModel.toModel(result) : null;
  }

  @override
  Stream<ObservationSessionModel?> watchActiveSession() {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.isLocked.equals(false) & tbl.isDeleted.equals(false))
      ..limit(1);

    return query.watchSingleOrNull().map(
      (row) => row != null ? ObservationSessionModel.toModel(row) : null,
    );
  }

  @override
  Future<void> addObservation(ObservationRecordModel observation) async {
    await db
        .into(db.observationsTable)
        .insert(_createObservationCompanion(observation));
  }

  @override
  Future<void> updateObservation(ObservationRecordModel observation) async {
    await db
        .update(db.observationsTable)
        .replace(_createObservationCompanion(observation));
  }

  @override
  Future<void> deleteObservation(String id) async {
    await (db.update(db.observationsTable)..where((tbl) => tbl.id.equals(id)))
        .write(const ObservationsTableCompanion(isDeleted: Value(true)));
  }

  @override
  Stream<List<ObservationRecordModel>> watchObservationsForSession(
    String sessionId,
  ) {
    final query = db.select(db.observationsTable)
      ..where(
        (tbl) => tbl.sessionId.equals(sessionId) & tbl.isDeleted.equals(false),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.startTime)]);

    return query.watch().map(
      (rows) => rows.map(ObservationRecordModel.toModel).toList(),
    );
  }

  SessionsTableCompanion _createSessionCompanion(
    ObservationSessionModel session,
  ) {
    return SessionsTableCompanion.insert(
      id: session.id,
      annotatorId: session.annotatorId,
      sessionType: session.sessionType,
      startTime: Value(session.startTime),
      endTime: Value(session.endTime),
      weatherNotes: Value(session.weatherNotes),
      latitude: Value(session.latitude),
      longitude: Value(session.longitude),
      isLocked: session.isLocked,
      syncStatus: session.syncStatus,
      createdAt: session.createdAt,
      updatedAt: session.updatedAt,
      isDeleted: session.isDeleted,
    );
  }

  ObservationsTableCompanion _createObservationCompanion(
    ObservationRecordModel obs,
  ) {
    return ObservationsTableCompanion.insert(
      id: obs.id,
      sessionId: obs.sessionId,
      speciesId: obs.speciesId,
      contactType: obs.contactType,
      quantity: obs.quantity,
      startTime: obs.startTime,
      endTime: obs.endTime,
      notes: Value(obs.notes),
      latitude: Value(obs.latitude),
      longitude: Value(obs.longitude),
      validationStatus: obs.validationStatus,
      syncStatus: obs.syncStatus,
      createdAt: obs.createdAt,
      updatedAt: obs.updatedAt,
      isDeleted: obs.isDeleted,
    );
  }
}
