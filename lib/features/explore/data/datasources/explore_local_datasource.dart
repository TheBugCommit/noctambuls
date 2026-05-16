import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/explore/data/models/map_bubble_model.dart';

abstract class ExploreLocalDataSource {
  Stream<List<MapBubbleModel>> watchAll();

  Future<void> bulkUpsert(List<MapBubbleModel> models);

  Future<void> saveSyncMetadata(String key, {String? since});

  Future<String?> getSyncSince(String key);
}

class ExploreLocalDataSourceImpl implements ExploreLocalDataSource {
  ExploreLocalDataSourceImpl({required this.appDb});

  final AppDatabase appDb;

  @override
  Stream<List<MapBubbleModel>> watchAll() {
    return appDb
        .select(appDb.mapBubblesTable)
        .watch()
        .map((rows) => rows.map<MapBubbleModel>(MapBubbleModel.fromData).toList());
  }

  @override
  Future<void> bulkUpsert(List<MapBubbleModel> models) async {
    if (models.isEmpty) return;
    await appDb.batch((batch) {
      batch.insertAll(
        appDb.mapBubblesTable,
        models.map(_toCompanion).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> saveSyncMetadata(String key, {String? since}) async {
    await appDb
        .into(appDb.catalogMetadataTable)
        .insertOnConflictUpdate(
          CatalogMetadataTableCompanion.insert(
            key: key,
            value: since != null ? Value(since) : const Value.absent(),
          ),
        );
  }

  @override
  Future<String?> getSyncSince(String key) async {
    final row = await (appDb.select(
      appDb.catalogMetadataTable,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  MapBubblesTableCompanion _toCompanion(MapBubbleModel model) {
    return MapBubblesTableCompanion.insert(
      id: model.id,
      speciesId: model.speciesId,
      lat: model.lat,
      lon: model.lon,
      year: model.year,
      count: model.count,
      updatedAt: model.updatedAt,
    );
  }
}
