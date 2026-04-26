import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';

abstract class BirdsLocalDataSource {
  Future<List<BirdModel>> getBirds(String languageCode);
}

class BirdsLocalDataSourceDriftImpl implements BirdsLocalDataSource {
  const BirdsLocalDataSourceDriftImpl({required this.udb});

  final UserDatabaseManager udb;

  @override
  Future<List<BirdModel>> getBirds(String languageCode) async {
    final query = udb.database.select(udb.database.birdsTable).join([
      innerJoin(
        udb.database.birdNamesTable,
        udb.database.birdNamesTable.birdId.equalsExp(
            udb.database.birdsTable.id),
      ),
    ])
      ..where(udb.database.birdNamesTable.languageCode.equals(languageCode));

    final rows = await query.get();

    return rows
        .map(
          (row) =>
          BirdModel.fromDrift(
            row.readTable(udb.database.birdsTable),
            row.readTable(udb.database.birdNamesTable),
          ),
    )
        .toList();
  }
}
