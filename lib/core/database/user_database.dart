import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/converters.dart';
import 'package:noctambuls/core/database/tables.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

part 'user_database.g.dart';

@DriftDatabase(tables: [SessionsTable, ObservationsTable, UserProfileTable])
class UserDatabase extends _$UserDatabase {
  UserDatabase(super.e);

  UserDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(userProfileTable);
      if (from < 4) {
        await m.deleteTable('sessions_table');
        await m.createTable(sessionsTable);
      }
    },
  );
}
