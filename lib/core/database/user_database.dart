import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/converters.dart';
import 'package:noctambuls/core/database/tables.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
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

@DriftDatabase(
  tables: [
    SessionsTable,
    ObservationsTable,
    UserProfileTable,
    SessionParticipantsTable,
  ],
)
class UserDatabase extends _$UserDatabase {
  UserDatabase(super.e);

  UserDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(userProfileTable);
      if (from < 4) {
        await m.deleteTable('sessions_table');
        await m.createTable(sessionsTable);
      }
      if (from < 5) {
        await m.createTable(sessionParticipantsTable);
      }
      if (from < 8) {
        await m.deleteTable('sessions_table');
        await m.createTable(sessionsTable);
        await m.deleteTable('observations_table');
        await m.createTable(observationsTable);
      }
    },
  );
}
