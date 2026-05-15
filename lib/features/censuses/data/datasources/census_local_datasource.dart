import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/censuses/data/models/census_model.dart';

abstract class CensusLocalDataSource {
  Stream<List<CensusModel>> watchAll();

  Stream<CensusModel?> watchJoinedCensus();

  Future<CensusModel?> getById(String id);

  Future<CensusModel?> getJoinedCensus();

  Future<void> save(CensusModel model);

  Future<void> bulkUpsert(List<CensusModel> models);

  Future<void> saveSyncMetadata(String key, {String? since});

  Future<String?> getSyncSince(String key);
}

class CensusLocalDataSourceImpl implements CensusLocalDataSource {
  CensusLocalDataSourceImpl({required this.dbManager});

  final UserDatabaseManager dbManager;

  UserDatabase get db => dbManager.database;

  @override
  Stream<List<CensusModel>> watchAll() {
    return db
        .select(db.censusesTable)
        .watch()
        .map(
          (rows) => rows.map(CensusModel.fromData).toList(),
        );
  }

  @override
  Stream<CensusModel?> watchJoinedCensus() {
    return (db.select(db.censusesTable)
          ..where((t) => t.isJoined.equals(true) & t.alreadyDone.equals(false))
          ..limit(1))
        .watchSingleOrNull()
        .map((row) => row != null ? CensusModel.fromData(row) : null);
  }

  @override
  Future<CensusModel?> getById(String id) async {
    final row = await (db.select(
      db.censusesTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? CensusModel.fromData(row) : null;
  }

  @override
  Future<CensusModel?> getJoinedCensus() async {
    final row =
        await (db.select(db.censusesTable)
              ..where((t) => t.isJoined.equals(true))
              ..limit(1))
            .getSingleOrNull();
    return row != null ? CensusModel.fromData(row) : null;
  }

  @override
  Future<void> save(CensusModel model) async {
    await db.into(db.censusesTable).insertOnConflictUpdate(_toCompanion(model));
  }

  @override
  Future<void> bulkUpsert(List<CensusModel> models) async {
    if (models.isEmpty) return;

    final ids = models.map((m) => m.id).toList();

    // Preserve isJoined and alreadyDone for existing local records.
    final existing = await (db.select(
      db.censusesTable,
    )..where((t) => t.id.isIn(ids))).get();
    final existingMap = {for (final r in existing) r.id: r};

    final companions = models.map((model) {
      final local = existingMap[model.id];
      final merged = local != null
          ? model.copyWith(
              isJoined: local.isJoined,
              alreadyDone: local.alreadyDone,
            )
          : model;
      return _toCompanion(merged);
    }).toList();

    await db.batch((batch) {
      batch.insertAll(
        db.censusesTable,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> saveSyncMetadata(String key, {String? since}) async {
    await db
        .into(db.syncMetadataTable)
        .insertOnConflictUpdate(
          SyncMetadataTableCompanion.insert(
            key: key,
            since: since != null ? Value(since) : const Value.absent(),
          ),
        );
  }

  @override
  Future<String?> getSyncSince(String key) async {
    final row = await (db.select(
      db.syncMetadataTable,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.since;
  }

  CensusesTableCompanion _toCompanion(CensusModel model) {
    return CensusesTableCompanion.insert(
      id: model.id,
      title: model.title,
      startTime: model.startTime,
      locationName: model.locationName != null
          ? Value(model.locationName)
          : const Value.absent(),
      description: model.description != null
          ? Value(model.description)
          : const Value.absent(),
      latitude: model.geoPosition != null
          ? Value(model.geoPosition!.latitude)
          : const Value.absent(),
      longitude: model.geoPosition != null
          ? Value(model.geoPosition!.longitude)
          : const Value.absent(),
      isJoined: Value(model.isJoined),
      alreadyDone: Value(model.alreadyDone),
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
