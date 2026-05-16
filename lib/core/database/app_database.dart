import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:noctambuls/core/database/tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    BirdsTable,
    BirdNamesTable,
    CatalogMetadataTable,
    MapBubblesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) await m.createTable(catalogMetadataTable);
        if (from < 3) await m.createTable(mapBubblesTable);
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(dbFolder.path, 'noctambuls_db.sqlite'),
    );

    return NativeDatabase.createInBackground(file);
  });
}
