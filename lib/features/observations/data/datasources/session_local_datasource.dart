import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';

abstract class SessionLocalDataSource {
  Future<void> save(ObservationSessionModel session);

  Future<void> delete(String id);

  Future<ObservationSessionModel?> getById(String id);

  Future<ObservationSessionModel?> getByCensusId(String censusId);

  Stream<List<ObservationSessionModel>> watchAll();

  Future<ObservationSessionModel?> getActiveSession();

  Stream<ObservationSessionModel?> watchActiveSession();

  Stream<ObservationSessionModel?> watchSessionById(String id);

  Future<List<ObservationSessionModel>> getPendingSessions();

  Future<void> bulkUpsertSessions(List<ObservationSessionModel> sessions);

  // Updates syncStatus and optional error message in bulk.
  // Record key = sessionId, value = (newStatus, errorMessage).
  Future<void> bulkUpdateSyncStatuses(
    Map<String, (SyncStatus, SyncErrorType?)> updates,
  );

  Future<void> saveSyncMetadata(
    String key, {
    String? since,
    int? currentPage,
  });

  Future<({String? since, int currentPage})> getSyncMetadata(String key);

  Stream<List<ObservationSessionModel>> watchOwnSessions(String annotatorId);

  Stream<List<ObservationSessionModel>> watchParticipatedSessions(
    String annotatorId,
  );
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
  Future<ObservationSessionModel?> getByCensusId(String censusId) async {
    final query = db.select(db.sessionsTable)
      ..where((tbl) => tbl.censusId.equals(censusId));
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

  @override
  Future<List<ObservationSessionModel>> getPendingSessions() async {
    final query = db.select(db.sessionsTable)
      ..where(
        (t) =>
            t.syncStatus.equals(SyncStatus.pending.value) &
            t.isDeleted.equals(false),
      );
    final sessions = await query.get();
    return Future.wait(sessions.map(_hydrateSessionAggregate));
  }

  @override
  Future<void> bulkUpsertSessions(
    List<ObservationSessionModel> sessions,
  ) async {
    if (sessions.isEmpty) return;

    final sessionIds = sessions.map((s) => s.id).toList();

    // Do not overwrite locally-owned sessions (pending/draft).
    final localPending =
        await (db.select(db.sessionsTable)..where(
              (t) =>
                  t.id.isIn(sessionIds) &
                  (t.syncStatus.equals(SyncStatus.pending.value) |
                      t.syncStatus.equals(SyncStatus.draft.value)),
            ))
            .get();
    final skipIds = localPending.map((s) => s.id).toSet();

    final toUpsert = sessions.where((s) => !skipIds.contains(s.id)).toList();
    if (toUpsert.isEmpty) return;

    await db.transaction(() async {
      await db.batch((batch) {
        batch.insertAll(
          db.sessionsTable,
          toUpsert.map(_sessionCompanion),
          mode: InsertMode.insertOrReplace,
        );
      });

      for (final session in toUpsert) {
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
      }
    });
  }

  @override
  Future<void> bulkUpdateSyncStatuses(
    Map<String, (SyncStatus, SyncErrorType?)> updates,
  ) async {
    if (updates.isEmpty) return;
    final now = DateTime.now().toUtc();
    await db.batch((batch) {
      for (final entry in updates.entries) {
        final (status, error) = entry.value;
        batch.update(
          db.sessionsTable,
          SessionsTableCompanion(
            syncStatus: Value(status),
            syncError: Value(error),
            updatedAt: Value(now),
          ),
          where: (t) => t.id.equals(entry.key),
        );
      }
    });
  }

  @override
  Future<void> saveSyncMetadata(
    String key, {
    String? since,
    int? currentPage,
  }) async {
    await db
        .into(db.syncMetadataTable)
        .insertOnConflictUpdate(
          SyncMetadataTableCompanion.insert(
            key: key,
            since: since != null ? Value(since) : const Value.absent(),
            currentPage: currentPage != null
                ? Value(currentPage)
                : const Value.absent(),
          ),
        );
  }

  @override
  Future<({String? since, int currentPage})> getSyncMetadata(
    String key,
  ) async {
    final row = await (db.select(
      db.syncMetadataTable,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return (since: row?.since, currentPage: row?.currentPage ?? 0);
  }

  @override
  Stream<List<ObservationSessionModel>> watchOwnSessions(String annotatorId) {
    final query = db.select(db.sessionsTable)
      ..where(
        (t) => t.annotatorId.equals(annotatorId) & t.isDeleted.equals(false),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().asyncMap((sessions) async {
      if (sessions.isEmpty) return [];
      return _hydrateSessionList(sessions);
    });
  }

  @override
  Stream<List<ObservationSessionModel>> watchParticipatedSessions(
    String annotatorId,
  ) {
    final query = db.select(db.sessionsTable)
      ..where(
        (t) =>
            t.annotatorId.isNotValue(annotatorId) & t.isDeleted.equals(false),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().asyncMap((sessions) async {
      if (sessions.isEmpty) return [];
      return _hydrateSessionList(sessions);
    });
  }

  Future<List<ObservationSessionModel>> _hydrateSessionList(
    List<SessionEntityData> sessions,
  ) async {
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
                (t) => t.sessionId.isIn(sessionIds) & t.isDeleted.equals(false),
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
  }

  SessionsTableCompanion _sessionCompanion(ObservationSessionModel s) {
    return SessionsTableCompanion.insert(
      id: s.id,
      annotatorId: s.annotatorId,
      sessionType: s.sessionType,
      censusId: Value(s.censusId),
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
      syncError: Value(s.syncError),
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
