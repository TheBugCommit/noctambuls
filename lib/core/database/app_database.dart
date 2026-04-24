import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:noctambuls/core/database/converters.dart';
import 'package:noctambuls/core/database/seeders/bird_seeder.dart';
import 'package:noctambuls/core/database/tables.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [SessionsTable, ObservationsTable, BirdsTable, BirdNamesTable],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await BirdSeeder.seed(this);
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.drop(birdsTable);
          await m.create(birdsTable);
          await m.create(birdNamesTable);
          await BirdSeeder.seed(this);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'noctambuls_db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
