import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';

abstract class SessionLocalDataSource {
  Future<void> save(ObservationSessionModel session);

  Future<void> delete(String id);

  Future<ObservationSessionModel?> getById(String id);

  Stream<List<ObservationSessionModel>> watchAll();

  Future<ObservationSessionModel?> getActiveSession();

  Stream<ObservationSessionModel?> watchActiveSession();

  Stream<ObservationSessionModel?> watchSessionById(String id);
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  SessionLocalDataSourceImpl({required this.dbManager});

  final UserDatabaseManager dbManager;

  UserDatabase get db => dbManager.database;

  @override
  Future<void> save(ObservationSessionModel session) async {
    await db.transaction(() async {
      await db
          .into(db.sessionsTable)
          .insertOnConflictUpdate(
            _sessionCompanion(session),
          );

      await (db.delete(
        db.observationsTable,
      )..where((t) => t.sessionId.equals(session.id))).go();

      if (session.observations.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(
            db.observationsTable,
            session.observations.map(_observationCompanion),
            mode: InsertMode.insertOrReplace,
          );
        });
      }

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
  Future<void> delete(String id) async {
    await db.transaction(() async {
      await (db.delete(
        db.sessionParticipantsTable,
      )..where((t) => t.sessionId.equals(id))).go();

      await (db.delete(
        db.observationsTable,
      )..where((t) => t.sessionId.equals(id))).go();

      await (db.delete(db.sessionsTable)..where((t) => t.id.equals(id))).go();
    });
  }

  @override
  Future<ObservationSessionModel?> getById(String id) async {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.id.equals(id));
    final sessionData = await query.getSingleOrNull();

    if (sessionData == null) return null;

    return _hydrateSessionAggregate(sessionData);
  }

  @override
  Stream<List<ObservationSessionModel>> watchAll() {
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

      final observationsData =
          await (db.select(db.observationsTable)
                ..where(
                  (t) =>
                      t.sessionId.isIn(sessionIds) & t.isDeleted.equals(false),
                )
                ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
              .get();

      final observationsMap = <String, List<ObservationRecordModel>>{};
      for (final obs in observationsData) {
        observationsMap
            .putIfAbsent(obs.sessionId, () => [])
            .add(ObservationRecordModel.fromData(obs));
      }

      return sessions
          .map(
            (s) => ObservationSessionModel.fromData(
              s,
              participants: participantsMap[s.id] ?? [],
              observations: observationsMap[s.id] ?? [],
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

    return _hydrateSessionAggregate(sessionData);
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
      return _hydrateSessionAggregate(sessionData);
    });
  }

  @override
  Stream<ObservationSessionModel?> watchSessionById(String id) {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.id.equals(id));

    return query.watchSingleOrNull().asyncMap((sessionData) async {
      if (sessionData == null) return null;
      return _hydrateSessionAggregate(sessionData);
    });
  }

  Future<ObservationSessionModel> _hydrateSessionAggregate(
    SessionEntityData sessionData,
  ) async {
    final participantsData = await (db.select(
      db.sessionParticipantsTable,
    )..where((t) => t.sessionId.equals(sessionData.id))).get();

    final observationsData =
        await (db.select(db.observationsTable)
              ..where(
                (t) =>
                    t.sessionId.equals(sessionData.id) &
                    t.isDeleted.equals(false),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
            .get();

    return ObservationSessionModel.fromData(
      sessionData,
      participants: participantsData.map((p) => p.ornithologistCode).toList(),
      observations: observationsData
          .map(ObservationRecordModel.fromData)
          .toList(),
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
      latitude: Value(s.location?.latitude),
      longitude: Value(s.location?.longitude),
      accuracy: Value(s.location?.accuracy),
      altitude: Value(s.location?.altitude),
      altitudeAccuracy: Value(s.location?.altitudeAccuracy),
      positionTimestamp: Value(s.location?.timestamp),
      locationSource: Value(s.location?.locationSource),
      locationError: Value(s.locationError),
      isLocked: s.isLocked,
      syncStatus: s.syncStatus,
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
      isDeleted: Value(s.isDeleted),
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
      latitude: Value(obs.location?.latitude),
      longitude: Value(obs.location?.longitude),
      accuracy: Value(obs.location?.accuracy),
      altitude: Value(obs.location?.altitude),
      altitudeAccuracy: Value(obs.location?.altitudeAccuracy),
      positionTimestamp: Value(obs.location?.timestamp),
      locationSource: Value(obs.location?.locationSource),
      locationError: Value(obs.locationError),
      bearing: obs.bearing,
      createdAt: obs.createdAt,
      updatedAt: obs.updatedAt,
      isDeleted: Value(obs.isDeleted),
    );
  }
}
