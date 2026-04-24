import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';

abstract class BirdsLocalDataSource {
  Future<List<BirdModel>> getBirds(String languageCode);
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
}
