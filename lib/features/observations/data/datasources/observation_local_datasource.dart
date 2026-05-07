import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
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
  ObservationLocalDataSourceImpl({required this.dbManager});

  final UserDatabaseManager dbManager;

  UserDatabase get db => dbManager.database;

  @override
  Future<void> createSession(ObservationSessionModel session) async {
    await db.transaction(() async {
      await db.into(db.sessionsTable).insert(_sessionCompanion(session));
      final uniqueParticipants = session.participants.toSet();
      if (uniqueParticipants.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(
            db.sessionParticipantsTable,
            uniqueParticipants.map(
              (code) => SessionParticipantsTableCompanion.insert(
                sessionId: session.id,
                ornithologistCode: code,
              ),
            ),
            mode: InsertMode.insertOrIgnore,
          );
        });
      }
    });
  }

  @override
  Future<void> updateSession(ObservationSessionModel session) async {
    await db.transaction(() async {
      await db
          .update(db.sessionsTable)
          .replace(
            _sessionCompanion(session),
          );

      await (db.delete(
        db.sessionParticipantsTable,
      )..where((t) => t.sessionId.equals(session.id))).go();

      final uniqueParticipants = session.participants.toSet();
      if (uniqueParticipants.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(
            db.sessionParticipantsTable,
            uniqueParticipants.map(
              (code) => SessionParticipantsTableCompanion.insert(
                sessionId: session.id,
                ornithologistCode: code,
              ),
            ),
            mode: InsertMode.insertOrIgnore,
          );
        });
      }
    });
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
    final sessionData = await query.getSingleOrNull();

    if (sessionData == null) return null;

    final participantsData = await (db.select(
      db.sessionParticipantsTable,
    )..where((t) => t.sessionId.equals(id))).get();

    return ObservationSessionModel.fromData(
      sessionData,
      participants: participantsData.map((p) => p.ornithologistCode).toList(),
    );
  }

  @override
  Stream<List<ObservationSessionModel>> watchAllSessions() {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.isDeleted.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().asyncMap((sessions) async {
      if (sessions.isEmpty) return [];

      final sessionIds = sessions.map((s) => s.id).toList();

      final participantsData = await (db.select(
        db.sessionParticipantsTable,
      )..where((t) => t.sessionId.isIn(sessionIds))).get();

      final participantsMap = <String, List<String>>{};
      for (final p in participantsData) {
        participantsMap
            .putIfAbsent(p.sessionId, () => [])
            .add(p.ornithologistCode);
      }

      return sessions
          .map(
            (s) => ObservationSessionModel.fromData(
              s,
              participants: participantsMap[s.id] ?? [],
            ),
          )
          .toList();
    });
  }

  @override
  Future<ObservationSessionModel?> getActiveSession() async {
    final query = db.select(db.sessionsTable)
      ..where(
        (tbl) =>
            tbl.endTime.isNull() &
            tbl.isLocked.equals(false) &
            tbl.isDeleted.equals(false),
      )
      ..limit(1);

    final sessionData = await query.getSingleOrNull();
    if (sessionData == null) return null;

    final participantsData = await (db.select(
      db.sessionParticipantsTable,
    )..where((t) => t.sessionId.equals(sessionData.id))).get();

    return ObservationSessionModel.fromData(
      sessionData,
      participants: participantsData.map((p) => p.ornithologistCode).toList(),
    );
  }

  @override
  Stream<ObservationSessionModel?> watchActiveSession() {
    final query = db.select(db.sessionsTable)
      ..where(
        (tbl) =>
            tbl.endTime.isNull() &
            tbl.isLocked.equals(false) &
            tbl.isDeleted.equals(false),
      )
      ..limit(1);

    return query.watchSingleOrNull().asyncMap((sessionData) async {
      if (sessionData == null) return null;

      final participantsData = await (db.select(
        db.sessionParticipantsTable,
      )..where((t) => t.sessionId.equals(sessionData.id))).get();

      return ObservationSessionModel.fromData(
        sessionData,
        participants: participantsData.map((p) => p.ornithologistCode).toList(),
      );
    });
  }

  @override
  Future<void> addObservation(ObservationRecordModel observation) async {
    await db
        .into(db.observationsTable)
        .insert(_observationCompanion(observation));
  }

  @override
  Future<void> updateObservation(ObservationRecordModel observation) async {
    await db
        .update(db.observationsTable)
        .replace(_observationCompanion(observation));
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
      (rows) => rows.map(ObservationRecordModel.fromData).toList(),
    );
  }

  SessionsTableCompanion _sessionCompanion(ObservationSessionModel s) {
    return SessionsTableCompanion.insert(
      id: s.id,
      annotatorId: s.annotatorId,
      sessionType: s.sessionType,
      startTime: Value(s.startTime),
      endTime: Value(s.endTime),
      temperature: Value(s.temperature),
      wind: Value(s.wind),
      sky: Value(s.sky),
      rain: Value(s.rain),
      visibility: Value(s.visibility),
      moon: Value(s.moon),
      listeningPoint: Value(s.listeningPoint),
      latitude: Value(s.latitude),
      longitude: Value(s.longitude),
      isLocked: s.isLocked,
      syncStatus: s.syncStatus,
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
      isDeleted: s.isDeleted,
    );
  }

  ObservationsTableCompanion _observationCompanion(ObservationRecordModel obs) {
    return ObservationsTableCompanion.insert(
      id: obs.id,
      sessionId: obs.sessionId,
      speciesId: obs.speciesId,
      contactType: obs.contactType,
      quantity: obs.quantity,
      startTime: obs.startTime,
      endTime: obs.endTime,
      notes: Value(obs.notes),
      latitude: obs.latitude,
      longitude: obs.longitude,
      bearing: obs.bearing,
      validationStatus: obs.validationStatus,
      syncStatus: obs.syncStatus,
      createdAt: obs.createdAt,
      updatedAt: obs.updatedAt,
      isDeleted: obs.isDeleted,
    );
  }
}
