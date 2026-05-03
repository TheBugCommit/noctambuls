import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';

abstract class BirdsLocalDataSource {
  Future<List<BirdModel>> getBirds(String languageCode);

  Future<String?> getCatalogVersion();

  Future<void> saveCatalogVersion(String version);

  Future<void> saveFullCatalogTransaction(
    List<BirdEntityData> birds,
    List<BirdNameEntityData> names,
    String? version,
  );

  Future<List<String>> getAllLocalImagePaths();

  Future<List<String>> getAllLocalAudioPaths();
}

class BirdsLocalDataSourceDriftImpl implements BirdsLocalDataSource {
  const BirdsLocalDataSourceDriftImpl({required this.db});

  final AppDatabase db;

  @override
  Future<List<BirdModel>> getBirds(String languageCode) async {
    final query = db.select(db.birdsTable).join([
      innerJoin(
        db.birdNamesTable,
        db.birdNamesTable.birdId.equalsExp(db.birdsTable.id),
      ),
    ])..where(db.birdNamesTable.languageCode.equals(languageCode));

    final rows = await query.get();

    return rows
        .map(
          (row) => BirdModel.fromEntity(
            row.readTable(db.birdsTable),
            row.readTable(db.birdNamesTable),
          ),
        )
        .toList();
  }

  @override
  Future<void> saveFullCatalogTransaction(
    List<BirdEntityData> birds,
    List<BirdNameEntityData> names,
    String? version,
  ) async {
    await db.transaction(() async {
      await db.delete(db.birdNamesTable).go();
      await db.delete(db.birdsTable).go();

      await _insertBirdsBatch(birds);
      await _insertBirdNamesBatch(names);

      if (version != null) {
        await saveCatalogVersion(version);
      }
    });
  }

  Future<void> _insertBirdsBatch(List<BirdEntityData> birds) async {
    await db.batch((batch) {
      for (final bird in birds) {
        batch.insert(
          db.birdsTable,
          BirdsTableCompanion(
            id: Value(bird.id),
            scientificName: Value(bird.scientificName),
            imageUrl: Value(bird.imageUrl),
            audioUrl: Value(bird.audioUrl),
            infoUrl: Value(bird.infoUrl),
            localImagePath: bird.localImagePath == null
                ? const Value.absent()
                : Value(bird.localImagePath),
            localAudioPath: bird.localAudioPath == null
                ? const Value.absent()
                : Value(bird.localAudioPath),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> _insertBirdNamesBatch(List<BirdNameEntityData> names) async {
    await db.batch((batch) {
      for (final name in names) {
        batch.insert(
          db.birdNamesTable,
          BirdNamesTableCompanion(
            id: Value(name.id),
            birdId: Value(name.birdId),
            languageCode: Value(name.languageCode),
            commonName: Value(name.commonName),
            description: Value(name.description),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<String?> getCatalogVersion() async {
    final row = await (db.select(
      db.catalogMetadataTable,
    )..where((t) => t.key.equals('version'))).getSingleOrNull();
    return row?.value;
  }

  @override
  Future<void> saveCatalogVersion(String? version) async {
    await db
        .into(db.catalogMetadataTable)
        .insertOnConflictUpdate(
          CatalogMetadataTableCompanion(
            key: const Value('version'),
            value: Value(version),
          ),
        );
  }

  @override
  Future<List<String>> getAllLocalImagePaths() async {
    final query = db.selectOnly(db.birdsTable)
      ..addColumns([db.birdsTable.localImagePath])
      ..where(db.birdsTable.localImagePath.isNotNull());

    final results = await query
        .map((row) => row.read(db.birdsTable.localImagePath))
        .get();
    return results.whereType<String>().toList();
  }

  @override
  Future<List<String>> getAllLocalAudioPaths() async {
    final query = db.selectOnly(db.birdsTable)
      ..addColumns([db.birdsTable.localAudioPath])
      ..where(db.birdsTable.localAudioPath.isNotNull());

    final results = await query
        .map((row) => row.read(db.birdsTable.localAudioPath))
        .get();
    return results.whereType<String>().toList();
  }
}
