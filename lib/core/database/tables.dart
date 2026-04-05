import 'package:drift/drift.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

mixin OfflineFirstMixin on Table {
  TextColumn get id => text()();

  IntColumn get syncStatus => intEnum<SyncStatus>()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get isDeleted => boolean()();
}

@DataClassName('SessionEntityData')
class SessionsTable extends Table with OfflineFirstMixin {
  TextColumn get annotatorId => text()();

  IntColumn get sessionType => intEnum<SessionType>()();

  DateTimeColumn get startTime => dateTime().nullable()();

  DateTimeColumn get endTime => dateTime().nullable()();

  TextColumn get weatherNotes => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  BoolColumn get isLocked => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ObservationEntityData')
class ObservationsTable extends Table with OfflineFirstMixin {
  TextColumn get sessionId => text().references(SessionsTable, #id)();

  TextColumn get speciesId => text()();

  TextColumn get contactType => text()();

  IntColumn get quantity => integer()();

  DateTimeColumn get startTime => dateTime()();

  DateTimeColumn get endTime => dateTime()();

  TextColumn get notes => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  IntColumn get validationStatus => intEnum<ValidationStatus>()();

  @override
  Set<Column> get primaryKey => {id};
}
