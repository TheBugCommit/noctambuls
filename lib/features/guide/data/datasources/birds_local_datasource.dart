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
    String version,
  );
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
          (row) => BirdModel.fromDrift(
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
    String version,
  ) async {
    await db.transaction(() async {
      await upsertBirds(birds);
      await upsertBirdNames(names);
      await saveCatalogVersion(version);
    });
  }

  Future<void> upsertBirds(List<BirdEntityData> birds) async {
    for (final bird in birds) {
      await db
          .into(db.birdsTable)
          .insertOnConflictUpdate(
            BirdsTableCompanion(
              id: Value(bird.id),
              scientificName: Value(bird.scientificName),
              imagePath: Value(bird.imagePath),
              audioPath: Value(bird.audioPath),
              infoUrl: Value(bird.infoUrl),
            ),
          );
    }
  }

  Future<void> upsertBirdNames(List<BirdNameEntityData> names) async {
    for (final name in names) {
      await db
          .into(db.birdNamesTable)
          .insertOnConflictUpdate(
            BirdNamesTableCompanion(
              id: Value(name.id),
              birdId: Value(name.birdId),
              languageCode: Value(name.languageCode),
              commonName: Value(name.commonName),
              description: Value(name.description),
            ),
          );
    }
  }

  @override
  Future<String?> getCatalogVersion() async {
    final row = await (db.select(
      db.catalogMetadataTable,
    )..where((t) => t.key.equals('version'))).getSingleOrNull();
    return row?.value;
  }

  @override
  Future<void> saveCatalogVersion(String version) async {
    await db
        .into(db.catalogMetadataTable)
        .insertOnConflictUpdate(
          CatalogMetadataTableCompanion(
            key: const Value('version'),
            value: Value(version),
          ),
        );
  }
}
