import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/converters.dart';
import 'package:noctambuls/core/database/tables.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

part 'user_database.g.dart';

@DriftDatabase(tables: [SessionsTable, ObservationsTable, UserProfileTable])
class UserDatabase extends _$UserDatabase {
  UserDatabase(QueryExecutor e) : super(e);

  UserDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(userProfileTable);
    },
  );
}
