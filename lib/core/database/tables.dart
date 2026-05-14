import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/converters.dart';

mixin AuditableMixin on Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

@DataClassName('SessionEntityData')
class SessionsTable extends Table with AuditableMixin {
  TextColumn get annotatorId => text()();

  IntColumn get sessionType => integer().map(const SessionTypeConverter())();

  DateTimeColumn get startTime => dateTime().nullable()();

  DateTimeColumn get endTime => dateTime().nullable()();

  IntColumn get temperature => integer()
      .map(const TemperatureRangeConverter())
      .withDefault(const Constant(0))();

  IntColumn get wind => integer()
      .map(const WindLevelConverter())
      .withDefault(const Constant(0))();

  IntColumn get sky => integer()
      .map(const SkyConditionConverter())
      .withDefault(const Constant(0))();

  IntColumn get rain => integer()
      .map(const RainLevelConverter())
      .withDefault(const Constant(0))();

  IntColumn get visibility => integer()
      .map(const VisibilityLevelConverter())
      .withDefault(const Constant(0))();

  IntColumn get moon => integer()
      .map(const MoonPresenceConverter())
      .withDefault(const Constant(0))();

  IntColumn get listeningPoint => integer().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  RealColumn get accuracy => real().nullable()();

  RealColumn get altitude => real().nullable()();

  RealColumn get altitudeAccuracy => real().nullable()();

  DateTimeColumn get positionTimestamp => dateTime().nullable()();

  IntColumn get locationError =>
      integer().map(const LocationErrorTypeConverter()).nullable()();

  IntColumn get locationSource =>
      integer().map(const LocationSourceConverter()).nullable()();

  BoolColumn get isLocked => boolean()();

  IntColumn get syncStatus => integer().map(const SyncStatusConverter())();

  IntColumn get syncError =>
      integer().map(const SyncErrorTypeConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ObservationEntityData')
class ObservationsTable extends Table with AuditableMixin {
  TextColumn get sessionId => text().references(SessionsTable, #id)();

  TextColumn get speciesId => text()();

  IntColumn get contactType => integer().map(const ContactTypeConverter())();

  IntColumn get quantity => integer()();

  DateTimeColumn get startTime => dateTime()();

  DateTimeColumn get endTime => dateTime()();

  TextColumn get notes => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  RealColumn get accuracy => real().nullable()();

  RealColumn get altitude => real().nullable()();

  RealColumn get altitudeAccuracy => real().nullable()();

  DateTimeColumn get positionTimestamp => dateTime().nullable()();

  IntColumn get locationError =>
      integer().map(const LocationErrorTypeConverter()).nullable()();

  IntColumn get locationSource =>
      integer().map(const LocationSourceConverter()).nullable()();

  RealColumn get bearing => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionParticipantData')
class SessionParticipantsTable extends Table {
  TextColumn get sessionId => text().references(SessionsTable, #id)();

  TextColumn get ornithologistCode => text()();

  @override
  Set<Column> get primaryKey => {sessionId, ornithologistCode};
}

@DataClassName('BirdEntityData')
class BirdsTable extends Table {
  TextColumn get id => text()();

  TextColumn get scientificName => text()();

  TextColumn get localImagePath => text().nullable()();

  TextColumn get localAudioPath => text().nullable()();

  TextColumn get imageUrl => text()();

  TextColumn get audioUrl => text()();

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

@DataClassName('UserProfileData')
class UserProfileTable extends Table {
  @override
  String get tableName => 'user_profile';

  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get phone => text()();

  TextColumn get ornithologistCode => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncMetadataData')
class SyncMetadataTable extends Table {
  @override
  String get tableName => 'sync_metadata';

  TextColumn get key => text()();

  TextColumn get since => text().nullable()();

  IntColumn get currentPage => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('CatalogMetadataData')
class CatalogMetadataTable extends Table {
  @override
  String get tableName => 'catalog_metadata';

  TextColumn get key => text()();

  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
