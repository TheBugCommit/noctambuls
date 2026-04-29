import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/converters.dart';

mixin OfflineFirstMixin on Table {
  TextColumn get id => text()();

  IntColumn get syncStatus => integer().map(const SyncStatusConverter())();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get isDeleted => boolean()();
}

@DataClassName('SessionEntityData')
class SessionsTable extends Table with OfflineFirstMixin {
  TextColumn get annotatorId => text()();

  IntColumn get sessionType => integer().map(const SessionTypeConverter())();

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

  IntColumn get validationStatus =>
      integer().map(const ValidationStatusConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BirdEntityData')
class BirdsTable extends Table {
  TextColumn get id => text()();

  TextColumn get scientificName => text()();

  TextColumn get imagePath => text()();

  TextColumn get audioPath => text()();

  TextColumn get infoUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BirdNameEntityData')
class BirdNamesTable extends Table {
  TextColumn get id => text()();

  TextColumn get birdId => text().references(BirdsTable, #id)();

  TextColumn get languageCode => text()();

  TextColumn get commonName => text()();

  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CatalogMetadataData')
class CatalogMetadataTable extends Table {
  @override
  String get tableName => 'catalog_metadata';

  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
