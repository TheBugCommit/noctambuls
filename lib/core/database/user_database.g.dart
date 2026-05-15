// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// ignore_for_file: type=lint
class $SessionsTableTable extends SessionsTable
    with TableInfo<$SessionsTableTable, SessionEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _annotatorIdMeta = const VerificationMeta(
    'annotatorId',
  );
  @override
  late final GeneratedColumn<String> annotatorId = GeneratedColumn<String>(
    'annotator_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> sessionType =
      GeneratedColumn<int>(
        'session_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SessionType>($SessionsTableTable.$convertersessionType);
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TemperatureRange, int>
  temperature = GeneratedColumn<int>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  ).withConverter<TemperatureRange>($SessionsTableTable.$convertertemperature);
  @override
  late final GeneratedColumnWithTypeConverter<WindLevel, int> wind =
      GeneratedColumn<int>(
        'wind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<WindLevel>($SessionsTableTable.$converterwind);
  @override
  late final GeneratedColumnWithTypeConverter<SkyCondition, int> sky =
      GeneratedColumn<int>(
        'sky',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SkyCondition>($SessionsTableTable.$convertersky);
  @override
  late final GeneratedColumnWithTypeConverter<RainLevel, int> rain =
      GeneratedColumn<int>(
        'rain',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<RainLevel>($SessionsTableTable.$converterrain);
  @override
  late final GeneratedColumnWithTypeConverter<VisibilityLevel, int> visibility =
      GeneratedColumn<int>(
        'visibility',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<VisibilityLevel>(
        $SessionsTableTable.$convertervisibility,
      );
  @override
  late final GeneratedColumnWithTypeConverter<MoonPresence, int> moon =
      GeneratedColumn<int>(
        'moon',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<MoonPresence>($SessionsTableTable.$convertermoon);
  static const VerificationMeta _listeningPointMeta = const VerificationMeta(
    'listeningPoint',
  );
  @override
  late final GeneratedColumn<int> listeningPoint = GeneratedColumn<int>(
    'listening_point',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeAccuracyMeta = const VerificationMeta(
    'altitudeAccuracy',
  );
  @override
  late final GeneratedColumn<double> altitudeAccuracy = GeneratedColumn<double>(
    'altitude_accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionTimestampMeta = const VerificationMeta(
    'positionTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> positionTimestamp =
      GeneratedColumn<DateTime>(
        'position_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<LocationErrorType?, int>
  locationError =
      GeneratedColumn<int>(
        'location_error',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<LocationErrorType?>(
        $SessionsTableTable.$converterlocationErrorn,
      );
  @override
  late final GeneratedColumnWithTypeConverter<LocationSource?, int>
  locationSource =
      GeneratedColumn<int>(
        'location_source',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<LocationSource?>(
        $SessionsTableTable.$converterlocationSourcen,
      );
  static const VerificationMeta _isLockedMeta = const VerificationMeta(
    'isLocked',
  );
  @override
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
    'is_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_locked" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>($SessionsTableTable.$convertersyncStatus);
  @override
  late final GeneratedColumnWithTypeConverter<SyncErrorType?, int> syncError =
      GeneratedColumn<int>(
        'sync_error',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<SyncErrorType?>($SessionsTableTable.$convertersyncErrorn);
  static const VerificationMeta _censusIdMeta = const VerificationMeta(
    'censusId',
  );
  @override
  late final GeneratedColumn<String> censusId = GeneratedColumn<String>(
    'census_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    isDeleted,
    annotatorId,
    sessionType,
    startTime,
    endTime,
    temperature,
    wind,
    sky,
    rain,
    visibility,
    moon,
    listeningPoint,
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    positionTimestamp,
    locationError,
    locationSource,
    isLocked,
    syncStatus,
    syncError,
    censusId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionEntityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('annotator_id')) {
      context.handle(
        _annotatorIdMeta,
        annotatorId.isAcceptableOrUnknown(
          data['annotator_id']!,
          _annotatorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_annotatorIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('listening_point')) {
      context.handle(
        _listeningPointMeta,
        listeningPoint.isAcceptableOrUnknown(
          data['listening_point']!,
          _listeningPointMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    }
    if (data.containsKey('altitude_accuracy')) {
      context.handle(
        _altitudeAccuracyMeta,
        altitudeAccuracy.isAcceptableOrUnknown(
          data['altitude_accuracy']!,
          _altitudeAccuracyMeta,
        ),
      );
    }
    if (data.containsKey('position_timestamp')) {
      context.handle(
        _positionTimestampMeta,
        positionTimestamp.isAcceptableOrUnknown(
          data['position_timestamp']!,
          _positionTimestampMeta,
        ),
      );
    }
    if (data.containsKey('is_locked')) {
      context.handle(
        _isLockedMeta,
        isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta),
      );
    } else if (isInserting) {
      context.missing(_isLockedMeta);
    }
    if (data.containsKey('census_id')) {
      context.handle(
        _censusIdMeta,
        censusId.isAcceptableOrUnknown(data['census_id']!, _censusIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionEntityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      annotatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}annotator_id'],
      )!,
      sessionType: $SessionsTableTable.$convertersessionType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}session_type'],
        )!,
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      temperature: $SessionsTableTable.$convertertemperature.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}temperature'],
        )!,
      ),
      wind: $SessionsTableTable.$converterwind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}wind'],
        )!,
      ),
      sky: $SessionsTableTable.$convertersky.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sky'],
        )!,
      ),
      rain: $SessionsTableTable.$converterrain.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}rain'],
        )!,
      ),
      visibility: $SessionsTableTable.$convertervisibility.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}visibility'],
        )!,
      ),
      moon: $SessionsTableTable.$convertermoon.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}moon'],
        )!,
      ),
      listeningPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}listening_point'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      ),
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude'],
      ),
      altitudeAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_accuracy'],
      ),
      positionTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}position_timestamp'],
      ),
      locationError: $SessionsTableTable.$converterlocationErrorn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location_error'],
        ),
      ),
      locationSource: $SessionsTableTable.$converterlocationSourcen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location_source'],
        ),
      ),
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
      syncStatus: $SessionsTableTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
      syncError: $SessionsTableTable.$convertersyncErrorn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_error'],
        ),
      ),
      censusId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}census_id'],
      ),
    );
  }

  @override
  $SessionsTableTable createAlias(String alias) {
    return $SessionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, int, int> $convertersessionType =
      const SessionTypeConverter();
  static JsonTypeConverter2<TemperatureRange, int, int> $convertertemperature =
      const TemperatureRangeConverter();
  static JsonTypeConverter2<WindLevel, int, int> $converterwind =
      const WindLevelConverter();
  static JsonTypeConverter2<SkyCondition, int, int> $convertersky =
      const SkyConditionConverter();
  static JsonTypeConverter2<RainLevel, int, int> $converterrain =
      const RainLevelConverter();
  static JsonTypeConverter2<VisibilityLevel, int, int> $convertervisibility =
      const VisibilityLevelConverter();
  static JsonTypeConverter2<MoonPresence, int, int> $convertermoon =
      const MoonPresenceConverter();
  static JsonTypeConverter2<LocationErrorType, int, int>
  $converterlocationError = const LocationErrorTypeConverter();
  static JsonTypeConverter2<LocationErrorType?, int?, int?>
  $converterlocationErrorn = JsonTypeConverter2.asNullable(
    $converterlocationError,
  );
  static JsonTypeConverter2<LocationSource, int, int> $converterlocationSource =
      const LocationSourceConverter();
  static JsonTypeConverter2<LocationSource?, int?, int?>
  $converterlocationSourcen = JsonTypeConverter2.asNullable(
    $converterlocationSource,
  );
  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const SyncStatusConverter();
  static JsonTypeConverter2<SyncErrorType, int, int> $convertersyncError =
      const SyncErrorTypeConverter();
  static JsonTypeConverter2<SyncErrorType?, int?, int?> $convertersyncErrorn =
      JsonTypeConverter2.asNullable($convertersyncError);
}

class SessionEntityData extends DataClass
    implements Insertable<SessionEntityData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String annotatorId;
  final SessionType sessionType;
  final DateTime? startTime;
  final DateTime? endTime;
  final TemperatureRange temperature;
  final WindLevel wind;
  final SkyCondition sky;
  final RainLevel rain;
  final VisibilityLevel visibility;
  final MoonPresence moon;
  final int? listeningPoint;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? altitude;
  final double? altitudeAccuracy;
  final DateTime? positionTimestamp;
  final LocationErrorType? locationError;
  final LocationSource? locationSource;
  final bool isLocked;
  final SyncStatus syncStatus;
  final SyncErrorType? syncError;
  final String? censusId;
  const SessionEntityData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.annotatorId,
    required this.sessionType,
    this.startTime,
    this.endTime,
    required this.temperature,
    required this.wind,
    required this.sky,
    required this.rain,
    required this.visibility,
    required this.moon,
    this.listeningPoint,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.altitudeAccuracy,
    this.positionTimestamp,
    this.locationError,
    this.locationSource,
    required this.isLocked,
    required this.syncStatus,
    this.syncError,
    this.censusId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['annotator_id'] = Variable<String>(annotatorId);
    {
      map['session_type'] = Variable<int>(
        $SessionsTableTable.$convertersessionType.toSql(sessionType),
      );
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    {
      map['temperature'] = Variable<int>(
        $SessionsTableTable.$convertertemperature.toSql(temperature),
      );
    }
    {
      map['wind'] = Variable<int>(
        $SessionsTableTable.$converterwind.toSql(wind),
      );
    }
    {
      map['sky'] = Variable<int>($SessionsTableTable.$convertersky.toSql(sky));
    }
    {
      map['rain'] = Variable<int>(
        $SessionsTableTable.$converterrain.toSql(rain),
      );
    }
    {
      map['visibility'] = Variable<int>(
        $SessionsTableTable.$convertervisibility.toSql(visibility),
      );
    }
    {
      map['moon'] = Variable<int>(
        $SessionsTableTable.$convertermoon.toSql(moon),
      );
    }
    if (!nullToAbsent || listeningPoint != null) {
      map['listening_point'] = Variable<int>(listeningPoint);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || altitudeAccuracy != null) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy);
    }
    if (!nullToAbsent || positionTimestamp != null) {
      map['position_timestamp'] = Variable<DateTime>(positionTimestamp);
    }
    if (!nullToAbsent || locationError != null) {
      map['location_error'] = Variable<int>(
        $SessionsTableTable.$converterlocationErrorn.toSql(locationError),
      );
    }
    if (!nullToAbsent || locationSource != null) {
      map['location_source'] = Variable<int>(
        $SessionsTableTable.$converterlocationSourcen.toSql(locationSource),
      );
    }
    map['is_locked'] = Variable<bool>(isLocked);
    {
      map['sync_status'] = Variable<int>(
        $SessionsTableTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<int>(
        $SessionsTableTable.$convertersyncErrorn.toSql(syncError),
      );
    }
    if (!nullToAbsent || censusId != null) {
      map['census_id'] = Variable<String>(censusId);
    }
    return map;
  }

  SessionsTableCompanion toCompanion(bool nullToAbsent) {
    return SessionsTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      annotatorId: Value(annotatorId),
      sessionType: Value(sessionType),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      temperature: Value(temperature),
      wind: Value(wind),
      sky: Value(sky),
      rain: Value(rain),
      visibility: Value(visibility),
      moon: Value(moon),
      listeningPoint: listeningPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(listeningPoint),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      altitudeAccuracy: altitudeAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeAccuracy),
      positionTimestamp: positionTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(positionTimestamp),
      locationError: locationError == null && nullToAbsent
          ? const Value.absent()
          : Value(locationError),
      locationSource: locationSource == null && nullToAbsent
          ? const Value.absent()
          : Value(locationSource),
      isLocked: Value(isLocked),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      censusId: censusId == null && nullToAbsent
          ? const Value.absent()
          : Value(censusId),
    );
  }

  factory SessionEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionEntityData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      annotatorId: serializer.fromJson<String>(json['annotatorId']),
      sessionType: $SessionsTableTable.$convertersessionType.fromJson(
        serializer.fromJson<int>(json['sessionType']),
      ),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      temperature: $SessionsTableTable.$convertertemperature.fromJson(
        serializer.fromJson<int>(json['temperature']),
      ),
      wind: $SessionsTableTable.$converterwind.fromJson(
        serializer.fromJson<int>(json['wind']),
      ),
      sky: $SessionsTableTable.$convertersky.fromJson(
        serializer.fromJson<int>(json['sky']),
      ),
      rain: $SessionsTableTable.$converterrain.fromJson(
        serializer.fromJson<int>(json['rain']),
      ),
      visibility: $SessionsTableTable.$convertervisibility.fromJson(
        serializer.fromJson<int>(json['visibility']),
      ),
      moon: $SessionsTableTable.$convertermoon.fromJson(
        serializer.fromJson<int>(json['moon']),
      ),
      listeningPoint: serializer.fromJson<int?>(json['listeningPoint']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      altitudeAccuracy: serializer.fromJson<double?>(json['altitudeAccuracy']),
      positionTimestamp: serializer.fromJson<DateTime?>(
        json['positionTimestamp'],
      ),
      locationError: $SessionsTableTable.$converterlocationErrorn.fromJson(
        serializer.fromJson<int?>(json['locationError']),
      ),
      locationSource: $SessionsTableTable.$converterlocationSourcen.fromJson(
        serializer.fromJson<int?>(json['locationSource']),
      ),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
      syncStatus: $SessionsTableTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      syncError: $SessionsTableTable.$convertersyncErrorn.fromJson(
        serializer.fromJson<int?>(json['syncError']),
      ),
      censusId: serializer.fromJson<String?>(json['censusId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'annotatorId': serializer.toJson<String>(annotatorId),
      'sessionType': serializer.toJson<int>(
        $SessionsTableTable.$convertersessionType.toJson(sessionType),
      ),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'temperature': serializer.toJson<int>(
        $SessionsTableTable.$convertertemperature.toJson(temperature),
      ),
      'wind': serializer.toJson<int>(
        $SessionsTableTable.$converterwind.toJson(wind),
      ),
      'sky': serializer.toJson<int>(
        $SessionsTableTable.$convertersky.toJson(sky),
      ),
      'rain': serializer.toJson<int>(
        $SessionsTableTable.$converterrain.toJson(rain),
      ),
      'visibility': serializer.toJson<int>(
        $SessionsTableTable.$convertervisibility.toJson(visibility),
      ),
      'moon': serializer.toJson<int>(
        $SessionsTableTable.$convertermoon.toJson(moon),
      ),
      'listeningPoint': serializer.toJson<int?>(listeningPoint),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accuracy': serializer.toJson<double?>(accuracy),
      'altitude': serializer.toJson<double?>(altitude),
      'altitudeAccuracy': serializer.toJson<double?>(altitudeAccuracy),
      'positionTimestamp': serializer.toJson<DateTime?>(positionTimestamp),
      'locationError': serializer.toJson<int?>(
        $SessionsTableTable.$converterlocationErrorn.toJson(locationError),
      ),
      'locationSource': serializer.toJson<int?>(
        $SessionsTableTable.$converterlocationSourcen.toJson(locationSource),
      ),
      'isLocked': serializer.toJson<bool>(isLocked),
      'syncStatus': serializer.toJson<int>(
        $SessionsTableTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'syncError': serializer.toJson<int?>(
        $SessionsTableTable.$convertersyncErrorn.toJson(syncError),
      ),
      'censusId': serializer.toJson<String?>(censusId),
    };
  }

  SessionEntityData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    String? annotatorId,
    SessionType? sessionType,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    TemperatureRange? temperature,
    WindLevel? wind,
    SkyCondition? sky,
    RainLevel? rain,
    VisibilityLevel? visibility,
    MoonPresence? moon,
    Value<int?> listeningPoint = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> accuracy = const Value.absent(),
    Value<double?> altitude = const Value.absent(),
    Value<double?> altitudeAccuracy = const Value.absent(),
    Value<DateTime?> positionTimestamp = const Value.absent(),
    Value<LocationErrorType?> locationError = const Value.absent(),
    Value<LocationSource?> locationSource = const Value.absent(),
    bool? isLocked,
    SyncStatus? syncStatus,
    Value<SyncErrorType?> syncError = const Value.absent(),
    Value<String?> censusId = const Value.absent(),
  }) => SessionEntityData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    annotatorId: annotatorId ?? this.annotatorId,
    sessionType: sessionType ?? this.sessionType,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    temperature: temperature ?? this.temperature,
    wind: wind ?? this.wind,
    sky: sky ?? this.sky,
    rain: rain ?? this.rain,
    visibility: visibility ?? this.visibility,
    moon: moon ?? this.moon,
    listeningPoint: listeningPoint.present
        ? listeningPoint.value
        : this.listeningPoint,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    altitude: altitude.present ? altitude.value : this.altitude,
    altitudeAccuracy: altitudeAccuracy.present
        ? altitudeAccuracy.value
        : this.altitudeAccuracy,
    positionTimestamp: positionTimestamp.present
        ? positionTimestamp.value
        : this.positionTimestamp,
    locationError: locationError.present
        ? locationError.value
        : this.locationError,
    locationSource: locationSource.present
        ? locationSource.value
        : this.locationSource,
    isLocked: isLocked ?? this.isLocked,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    censusId: censusId.present ? censusId.value : this.censusId,
  );
  SessionEntityData copyWithCompanion(SessionsTableCompanion data) {
    return SessionEntityData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      annotatorId: data.annotatorId.present
          ? data.annotatorId.value
          : this.annotatorId,
      sessionType: data.sessionType.present
          ? data.sessionType.value
          : this.sessionType,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      wind: data.wind.present ? data.wind.value : this.wind,
      sky: data.sky.present ? data.sky.value : this.sky,
      rain: data.rain.present ? data.rain.value : this.rain,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      moon: data.moon.present ? data.moon.value : this.moon,
      listeningPoint: data.listeningPoint.present
          ? data.listeningPoint.value
          : this.listeningPoint,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      altitudeAccuracy: data.altitudeAccuracy.present
          ? data.altitudeAccuracy.value
          : this.altitudeAccuracy,
      positionTimestamp: data.positionTimestamp.present
          ? data.positionTimestamp.value
          : this.positionTimestamp,
      locationError: data.locationError.present
          ? data.locationError.value
          : this.locationError,
      locationSource: data.locationSource.present
          ? data.locationSource.value
          : this.locationSource,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      censusId: data.censusId.present ? data.censusId.value : this.censusId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntityData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('annotatorId: $annotatorId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('temperature: $temperature, ')
          ..write('wind: $wind, ')
          ..write('sky: $sky, ')
          ..write('rain: $rain, ')
          ..write('visibility: $visibility, ')
          ..write('moon: $moon, ')
          ..write('listeningPoint: $listeningPoint, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('positionTimestamp: $positionTimestamp, ')
          ..write('locationError: $locationError, ')
          ..write('locationSource: $locationSource, ')
          ..write('isLocked: $isLocked, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('censusId: $censusId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    isDeleted,
    annotatorId,
    sessionType,
    startTime,
    endTime,
    temperature,
    wind,
    sky,
    rain,
    visibility,
    moon,
    listeningPoint,
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    positionTimestamp,
    locationError,
    locationSource,
    isLocked,
    syncStatus,
    syncError,
    censusId,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntityData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.annotatorId == this.annotatorId &&
          other.sessionType == this.sessionType &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.temperature == this.temperature &&
          other.wind == this.wind &&
          other.sky == this.sky &&
          other.rain == this.rain &&
          other.visibility == this.visibility &&
          other.moon == this.moon &&
          other.listeningPoint == this.listeningPoint &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.altitude == this.altitude &&
          other.altitudeAccuracy == this.altitudeAccuracy &&
          other.positionTimestamp == this.positionTimestamp &&
          other.locationError == this.locationError &&
          other.locationSource == this.locationSource &&
          other.isLocked == this.isLocked &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.censusId == this.censusId);
}

class SessionsTableCompanion extends UpdateCompanion<SessionEntityData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> annotatorId;
  final Value<SessionType> sessionType;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<TemperatureRange> temperature;
  final Value<WindLevel> wind;
  final Value<SkyCondition> sky;
  final Value<RainLevel> rain;
  final Value<VisibilityLevel> visibility;
  final Value<MoonPresence> moon;
  final Value<int?> listeningPoint;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> accuracy;
  final Value<double?> altitude;
  final Value<double?> altitudeAccuracy;
  final Value<DateTime?> positionTimestamp;
  final Value<LocationErrorType?> locationError;
  final Value<LocationSource?> locationSource;
  final Value<bool> isLocked;
  final Value<SyncStatus> syncStatus;
  final Value<SyncErrorType?> syncError;
  final Value<String?> censusId;
  final Value<int> rowid;
  const SessionsTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.annotatorId = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.temperature = const Value.absent(),
    this.wind = const Value.absent(),
    this.sky = const Value.absent(),
    this.rain = const Value.absent(),
    this.visibility = const Value.absent(),
    this.moon = const Value.absent(),
    this.listeningPoint = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.positionTimestamp = const Value.absent(),
    this.locationError = const Value.absent(),
    this.locationSource = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.censusId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isDeleted = const Value.absent(),
    required String annotatorId,
    required SessionType sessionType,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.temperature = const Value.absent(),
    this.wind = const Value.absent(),
    this.sky = const Value.absent(),
    this.rain = const Value.absent(),
    this.visibility = const Value.absent(),
    this.moon = const Value.absent(),
    this.listeningPoint = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.positionTimestamp = const Value.absent(),
    this.locationError = const Value.absent(),
    this.locationSource = const Value.absent(),
    required bool isLocked,
    required SyncStatus syncStatus,
    this.syncError = const Value.absent(),
    this.censusId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       annotatorId = Value(annotatorId),
       sessionType = Value(sessionType),
       isLocked = Value(isLocked),
       syncStatus = Value(syncStatus);
  static Insertable<SessionEntityData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? annotatorId,
    Expression<int>? sessionType,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? temperature,
    Expression<int>? wind,
    Expression<int>? sky,
    Expression<int>? rain,
    Expression<int>? visibility,
    Expression<int>? moon,
    Expression<int>? listeningPoint,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<double>? altitude,
    Expression<double>? altitudeAccuracy,
    Expression<DateTime>? positionTimestamp,
    Expression<int>? locationError,
    Expression<int>? locationSource,
    Expression<bool>? isLocked,
    Expression<int>? syncStatus,
    Expression<int>? syncError,
    Expression<String>? censusId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (annotatorId != null) 'annotator_id': annotatorId,
      if (sessionType != null) 'session_type': sessionType,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (temperature != null) 'temperature': temperature,
      if (wind != null) 'wind': wind,
      if (sky != null) 'sky': sky,
      if (rain != null) 'rain': rain,
      if (visibility != null) 'visibility': visibility,
      if (moon != null) 'moon': moon,
      if (listeningPoint != null) 'listening_point': listeningPoint,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      if (altitudeAccuracy != null) 'altitude_accuracy': altitudeAccuracy,
      if (positionTimestamp != null) 'position_timestamp': positionTimestamp,
      if (locationError != null) 'location_error': locationError,
      if (locationSource != null) 'location_source': locationSource,
      if (isLocked != null) 'is_locked': isLocked,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (censusId != null) 'census_id': censusId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<String>? annotatorId,
    Value<SessionType>? sessionType,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<TemperatureRange>? temperature,
    Value<WindLevel>? wind,
    Value<SkyCondition>? sky,
    Value<RainLevel>? rain,
    Value<VisibilityLevel>? visibility,
    Value<MoonPresence>? moon,
    Value<int?>? listeningPoint,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? accuracy,
    Value<double?>? altitude,
    Value<double?>? altitudeAccuracy,
    Value<DateTime?>? positionTimestamp,
    Value<LocationErrorType?>? locationError,
    Value<LocationSource?>? locationSource,
    Value<bool>? isLocked,
    Value<SyncStatus>? syncStatus,
    Value<SyncErrorType?>? syncError,
    Value<String?>? censusId,
    Value<int>? rowid,
  }) {
    return SessionsTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      annotatorId: annotatorId ?? this.annotatorId,
      sessionType: sessionType ?? this.sessionType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      temperature: temperature ?? this.temperature,
      wind: wind ?? this.wind,
      sky: sky ?? this.sky,
      rain: rain ?? this.rain,
      visibility: visibility ?? this.visibility,
      moon: moon ?? this.moon,
      listeningPoint: listeningPoint ?? this.listeningPoint,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      altitudeAccuracy: altitudeAccuracy ?? this.altitudeAccuracy,
      positionTimestamp: positionTimestamp ?? this.positionTimestamp,
      locationError: locationError ?? this.locationError,
      locationSource: locationSource ?? this.locationSource,
      isLocked: isLocked ?? this.isLocked,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      censusId: censusId ?? this.censusId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (annotatorId.present) {
      map['annotator_id'] = Variable<String>(annotatorId.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(
        $SessionsTableTable.$convertersessionType.toSql(sessionType.value),
      );
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<int>(
        $SessionsTableTable.$convertertemperature.toSql(temperature.value),
      );
    }
    if (wind.present) {
      map['wind'] = Variable<int>(
        $SessionsTableTable.$converterwind.toSql(wind.value),
      );
    }
    if (sky.present) {
      map['sky'] = Variable<int>(
        $SessionsTableTable.$convertersky.toSql(sky.value),
      );
    }
    if (rain.present) {
      map['rain'] = Variable<int>(
        $SessionsTableTable.$converterrain.toSql(rain.value),
      );
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(
        $SessionsTableTable.$convertervisibility.toSql(visibility.value),
      );
    }
    if (moon.present) {
      map['moon'] = Variable<int>(
        $SessionsTableTable.$convertermoon.toSql(moon.value),
      );
    }
    if (listeningPoint.present) {
      map['listening_point'] = Variable<int>(listeningPoint.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (altitudeAccuracy.present) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy.value);
    }
    if (positionTimestamp.present) {
      map['position_timestamp'] = Variable<DateTime>(positionTimestamp.value);
    }
    if (locationError.present) {
      map['location_error'] = Variable<int>(
        $SessionsTableTable.$converterlocationErrorn.toSql(locationError.value),
      );
    }
    if (locationSource.present) {
      map['location_source'] = Variable<int>(
        $SessionsTableTable.$converterlocationSourcen.toSql(
          locationSource.value,
        ),
      );
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $SessionsTableTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (syncError.present) {
      map['sync_error'] = Variable<int>(
        $SessionsTableTable.$convertersyncErrorn.toSql(syncError.value),
      );
    }
    if (censusId.present) {
      map['census_id'] = Variable<String>(censusId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('annotatorId: $annotatorId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('temperature: $temperature, ')
          ..write('wind: $wind, ')
          ..write('sky: $sky, ')
          ..write('rain: $rain, ')
          ..write('visibility: $visibility, ')
          ..write('moon: $moon, ')
          ..write('listeningPoint: $listeningPoint, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('positionTimestamp: $positionTimestamp, ')
          ..write('locationError: $locationError, ')
          ..write('locationSource: $locationSource, ')
          ..write('isLocked: $isLocked, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('censusId: $censusId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ObservationsTableTable extends ObservationsTable
    with TableInfo<$ObservationsTableTable, ObservationEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions_table (id)',
    ),
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContactType, int> contactType =
      GeneratedColumn<int>(
        'contact_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ContactType>(
        $ObservationsTableTable.$convertercontactType,
      );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeAccuracyMeta = const VerificationMeta(
    'altitudeAccuracy',
  );
  @override
  late final GeneratedColumn<double> altitudeAccuracy = GeneratedColumn<double>(
    'altitude_accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionTimestampMeta = const VerificationMeta(
    'positionTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> positionTimestamp =
      GeneratedColumn<DateTime>(
        'position_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<LocationErrorType?, int>
  locationError =
      GeneratedColumn<int>(
        'location_error',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<LocationErrorType?>(
        $ObservationsTableTable.$converterlocationErrorn,
      );
  @override
  late final GeneratedColumnWithTypeConverter<LocationSource?, int>
  locationSource =
      GeneratedColumn<int>(
        'location_source',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<LocationSource?>(
        $ObservationsTableTable.$converterlocationSourcen,
      );
  static const VerificationMeta _bearingMeta = const VerificationMeta(
    'bearing',
  );
  @override
  late final GeneratedColumn<double> bearing = GeneratedColumn<double>(
    'bearing',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    isDeleted,
    sessionId,
    speciesId,
    contactType,
    quantity,
    startTime,
    endTime,
    notes,
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    positionTimestamp,
    locationError,
    locationSource,
    bearing,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObservationEntityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    }
    if (data.containsKey('altitude_accuracy')) {
      context.handle(
        _altitudeAccuracyMeta,
        altitudeAccuracy.isAcceptableOrUnknown(
          data['altitude_accuracy']!,
          _altitudeAccuracyMeta,
        ),
      );
    }
    if (data.containsKey('position_timestamp')) {
      context.handle(
        _positionTimestampMeta,
        positionTimestamp.isAcceptableOrUnknown(
          data['position_timestamp']!,
          _positionTimestampMeta,
        ),
      );
    }
    if (data.containsKey('bearing')) {
      context.handle(
        _bearingMeta,
        bearing.isAcceptableOrUnknown(data['bearing']!, _bearingMeta),
      );
    } else if (isInserting) {
      context.missing(_bearingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObservationEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObservationEntityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      contactType: $ObservationsTableTable.$convertercontactType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}contact_type'],
        )!,
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      ),
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude'],
      ),
      altitudeAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_accuracy'],
      ),
      positionTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}position_timestamp'],
      ),
      locationError: $ObservationsTableTable.$converterlocationErrorn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location_error'],
        ),
      ),
      locationSource: $ObservationsTableTable.$converterlocationSourcen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location_source'],
        ),
      ),
      bearing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bearing'],
      )!,
    );
  }

  @override
  $ObservationsTableTable createAlias(String alias) {
    return $ObservationsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContactType, int, int> $convertercontactType =
      const ContactTypeConverter();
  static JsonTypeConverter2<LocationErrorType, int, int>
  $converterlocationError = const LocationErrorTypeConverter();
  static JsonTypeConverter2<LocationErrorType?, int?, int?>
  $converterlocationErrorn = JsonTypeConverter2.asNullable(
    $converterlocationError,
  );
  static JsonTypeConverter2<LocationSource, int, int> $converterlocationSource =
      const LocationSourceConverter();
  static JsonTypeConverter2<LocationSource?, int?, int?>
  $converterlocationSourcen = JsonTypeConverter2.asNullable(
    $converterlocationSource,
  );
}

class ObservationEntityData extends DataClass
    implements Insertable<ObservationEntityData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? altitude;
  final double? altitudeAccuracy;
  final DateTime? positionTimestamp;
  final LocationErrorType? locationError;
  final LocationSource? locationSource;
  final double bearing;
  const ObservationEntityData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.quantity,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.altitudeAccuracy,
    this.positionTimestamp,
    this.locationError,
    this.locationSource,
    required this.bearing,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['session_id'] = Variable<String>(sessionId);
    map['species_id'] = Variable<String>(speciesId);
    {
      map['contact_type'] = Variable<int>(
        $ObservationsTableTable.$convertercontactType.toSql(contactType),
      );
    }
    map['quantity'] = Variable<int>(quantity);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || altitudeAccuracy != null) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy);
    }
    if (!nullToAbsent || positionTimestamp != null) {
      map['position_timestamp'] = Variable<DateTime>(positionTimestamp);
    }
    if (!nullToAbsent || locationError != null) {
      map['location_error'] = Variable<int>(
        $ObservationsTableTable.$converterlocationErrorn.toSql(locationError),
      );
    }
    if (!nullToAbsent || locationSource != null) {
      map['location_source'] = Variable<int>(
        $ObservationsTableTable.$converterlocationSourcen.toSql(locationSource),
      );
    }
    map['bearing'] = Variable<double>(bearing);
    return map;
  }

  ObservationsTableCompanion toCompanion(bool nullToAbsent) {
    return ObservationsTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      sessionId: Value(sessionId),
      speciesId: Value(speciesId),
      contactType: Value(contactType),
      quantity: Value(quantity),
      startTime: Value(startTime),
      endTime: Value(endTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      altitudeAccuracy: altitudeAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeAccuracy),
      positionTimestamp: positionTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(positionTimestamp),
      locationError: locationError == null && nullToAbsent
          ? const Value.absent()
          : Value(locationError),
      locationSource: locationSource == null && nullToAbsent
          ? const Value.absent()
          : Value(locationSource),
      bearing: Value(bearing),
    );
  }

  factory ObservationEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservationEntityData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      contactType: $ObservationsTableTable.$convertercontactType.fromJson(
        serializer.fromJson<int>(json['contactType']),
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      altitudeAccuracy: serializer.fromJson<double?>(json['altitudeAccuracy']),
      positionTimestamp: serializer.fromJson<DateTime?>(
        json['positionTimestamp'],
      ),
      locationError: $ObservationsTableTable.$converterlocationErrorn.fromJson(
        serializer.fromJson<int?>(json['locationError']),
      ),
      locationSource: $ObservationsTableTable.$converterlocationSourcen
          .fromJson(serializer.fromJson<int?>(json['locationSource'])),
      bearing: serializer.fromJson<double>(json['bearing']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'sessionId': serializer.toJson<String>(sessionId),
      'speciesId': serializer.toJson<String>(speciesId),
      'contactType': serializer.toJson<int>(
        $ObservationsTableTable.$convertercontactType.toJson(contactType),
      ),
      'quantity': serializer.toJson<int>(quantity),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'notes': serializer.toJson<String?>(notes),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accuracy': serializer.toJson<double?>(accuracy),
      'altitude': serializer.toJson<double?>(altitude),
      'altitudeAccuracy': serializer.toJson<double?>(altitudeAccuracy),
      'positionTimestamp': serializer.toJson<DateTime?>(positionTimestamp),
      'locationError': serializer.toJson<int?>(
        $ObservationsTableTable.$converterlocationErrorn.toJson(locationError),
      ),
      'locationSource': serializer.toJson<int?>(
        $ObservationsTableTable.$converterlocationSourcen.toJson(
          locationSource,
        ),
      ),
      'bearing': serializer.toJson<double>(bearing),
    };
  }

  ObservationEntityData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    String? sessionId,
    String? speciesId,
    ContactType? contactType,
    int? quantity,
    DateTime? startTime,
    DateTime? endTime,
    Value<String?> notes = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> accuracy = const Value.absent(),
    Value<double?> altitude = const Value.absent(),
    Value<double?> altitudeAccuracy = const Value.absent(),
    Value<DateTime?> positionTimestamp = const Value.absent(),
    Value<LocationErrorType?> locationError = const Value.absent(),
    Value<LocationSource?> locationSource = const Value.absent(),
    double? bearing,
  }) => ObservationEntityData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    sessionId: sessionId ?? this.sessionId,
    speciesId: speciesId ?? this.speciesId,
    contactType: contactType ?? this.contactType,
    quantity: quantity ?? this.quantity,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    notes: notes.present ? notes.value : this.notes,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    altitude: altitude.present ? altitude.value : this.altitude,
    altitudeAccuracy: altitudeAccuracy.present
        ? altitudeAccuracy.value
        : this.altitudeAccuracy,
    positionTimestamp: positionTimestamp.present
        ? positionTimestamp.value
        : this.positionTimestamp,
    locationError: locationError.present
        ? locationError.value
        : this.locationError,
    locationSource: locationSource.present
        ? locationSource.value
        : this.locationSource,
    bearing: bearing ?? this.bearing,
  );
  ObservationEntityData copyWithCompanion(ObservationsTableCompanion data) {
    return ObservationEntityData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      contactType: data.contactType.present
          ? data.contactType.value
          : this.contactType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      altitudeAccuracy: data.altitudeAccuracy.present
          ? data.altitudeAccuracy.value
          : this.altitudeAccuracy,
      positionTimestamp: data.positionTimestamp.present
          ? data.positionTimestamp.value
          : this.positionTimestamp,
      locationError: data.locationError.present
          ? data.locationError.value
          : this.locationError,
      locationSource: data.locationSource.present
          ? data.locationSource.value
          : this.locationSource,
      bearing: data.bearing.present ? data.bearing.value : this.bearing,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservationEntityData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('sessionId: $sessionId, ')
          ..write('speciesId: $speciesId, ')
          ..write('contactType: $contactType, ')
          ..write('quantity: $quantity, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('positionTimestamp: $positionTimestamp, ')
          ..write('locationError: $locationError, ')
          ..write('locationSource: $locationSource, ')
          ..write('bearing: $bearing')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    isDeleted,
    sessionId,
    speciesId,
    contactType,
    quantity,
    startTime,
    endTime,
    notes,
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    positionTimestamp,
    locationError,
    locationSource,
    bearing,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservationEntityData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.sessionId == this.sessionId &&
          other.speciesId == this.speciesId &&
          other.contactType == this.contactType &&
          other.quantity == this.quantity &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.notes == this.notes &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.altitude == this.altitude &&
          other.altitudeAccuracy == this.altitudeAccuracy &&
          other.positionTimestamp == this.positionTimestamp &&
          other.locationError == this.locationError &&
          other.locationSource == this.locationSource &&
          other.bearing == this.bearing);
}

class ObservationsTableCompanion
    extends UpdateCompanion<ObservationEntityData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> sessionId;
  final Value<String> speciesId;
  final Value<ContactType> contactType;
  final Value<int> quantity;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String?> notes;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> accuracy;
  final Value<double?> altitude;
  final Value<double?> altitudeAccuracy;
  final Value<DateTime?> positionTimestamp;
  final Value<LocationErrorType?> locationError;
  final Value<LocationSource?> locationSource;
  final Value<double> bearing;
  final Value<int> rowid;
  const ObservationsTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.contactType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.positionTimestamp = const Value.absent(),
    this.locationError = const Value.absent(),
    this.locationSource = const Value.absent(),
    this.bearing = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObservationsTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isDeleted = const Value.absent(),
    required String sessionId,
    required String speciesId,
    required ContactType contactType,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
    this.notes = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.altitudeAccuracy = const Value.absent(),
    this.positionTimestamp = const Value.absent(),
    this.locationError = const Value.absent(),
    this.locationSource = const Value.absent(),
    required double bearing,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       sessionId = Value(sessionId),
       speciesId = Value(speciesId),
       contactType = Value(contactType),
       quantity = Value(quantity),
       startTime = Value(startTime),
       endTime = Value(endTime),
       bearing = Value(bearing);
  static Insertable<ObservationEntityData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? sessionId,
    Expression<String>? speciesId,
    Expression<int>? contactType,
    Expression<int>? quantity,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? notes,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<double>? altitude,
    Expression<double>? altitudeAccuracy,
    Expression<DateTime>? positionTimestamp,
    Expression<int>? locationError,
    Expression<int>? locationSource,
    Expression<double>? bearing,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (sessionId != null) 'session_id': sessionId,
      if (speciesId != null) 'species_id': speciesId,
      if (contactType != null) 'contact_type': contactType,
      if (quantity != null) 'quantity': quantity,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (notes != null) 'notes': notes,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      if (altitudeAccuracy != null) 'altitude_accuracy': altitudeAccuracy,
      if (positionTimestamp != null) 'position_timestamp': positionTimestamp,
      if (locationError != null) 'location_error': locationError,
      if (locationSource != null) 'location_source': locationSource,
      if (bearing != null) 'bearing': bearing,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObservationsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<String>? sessionId,
    Value<String>? speciesId,
    Value<ContactType>? contactType,
    Value<int>? quantity,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<String?>? notes,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? accuracy,
    Value<double?>? altitude,
    Value<double?>? altitudeAccuracy,
    Value<DateTime?>? positionTimestamp,
    Value<LocationErrorType?>? locationError,
    Value<LocationSource?>? locationSource,
    Value<double>? bearing,
    Value<int>? rowid,
  }) {
    return ObservationsTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      sessionId: sessionId ?? this.sessionId,
      speciesId: speciesId ?? this.speciesId,
      contactType: contactType ?? this.contactType,
      quantity: quantity ?? this.quantity,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      altitudeAccuracy: altitudeAccuracy ?? this.altitudeAccuracy,
      positionTimestamp: positionTimestamp ?? this.positionTimestamp,
      locationError: locationError ?? this.locationError,
      locationSource: locationSource ?? this.locationSource,
      bearing: bearing ?? this.bearing,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (contactType.present) {
      map['contact_type'] = Variable<int>(
        $ObservationsTableTable.$convertercontactType.toSql(contactType.value),
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (altitudeAccuracy.present) {
      map['altitude_accuracy'] = Variable<double>(altitudeAccuracy.value);
    }
    if (positionTimestamp.present) {
      map['position_timestamp'] = Variable<DateTime>(positionTimestamp.value);
    }
    if (locationError.present) {
      map['location_error'] = Variable<int>(
        $ObservationsTableTable.$converterlocationErrorn.toSql(
          locationError.value,
        ),
      );
    }
    if (locationSource.present) {
      map['location_source'] = Variable<int>(
        $ObservationsTableTable.$converterlocationSourcen.toSql(
          locationSource.value,
        ),
      );
    }
    if (bearing.present) {
      map['bearing'] = Variable<double>(bearing.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationsTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('sessionId: $sessionId, ')
          ..write('speciesId: $speciesId, ')
          ..write('contactType: $contactType, ')
          ..write('quantity: $quantity, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('altitudeAccuracy: $altitudeAccuracy, ')
          ..write('positionTimestamp: $positionTimestamp, ')
          ..write('locationError: $locationError, ')
          ..write('locationSource: $locationSource, ')
          ..write('bearing: $bearing, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ornithologistCodeMeta = const VerificationMeta(
    'ornithologistCode',
  );
  @override
  late final GeneratedColumn<String> ornithologistCode =
      GeneratedColumn<String>(
        'ornithologist_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    ornithologistCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('ornithologist_code')) {
      context.handle(
        _ornithologistCodeMeta,
        ornithologistCode.isAcceptableOrUnknown(
          data['ornithologist_code']!,
          _ornithologistCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      ornithologistCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ornithologist_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final String id;
  final String name;
  final String phone;
  final String? ornithologistCode;
  final DateTime createdAt;
  const UserProfileData({
    required this.id,
    required this.name,
    required this.phone,
    this.ornithologistCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || ornithologistCode != null) {
      map['ornithologist_code'] = Variable<String>(ornithologistCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      ornithologistCode: ornithologistCode == null && nullToAbsent
          ? const Value.absent()
          : Value(ornithologistCode),
      createdAt: Value(createdAt),
    );
  }

  factory UserProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      ornithologistCode: serializer.fromJson<String?>(
        json['ornithologistCode'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'ornithologistCode': serializer.toJson<String?>(ornithologistCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserProfileData copyWith({
    String? id,
    String? name,
    String? phone,
    Value<String?> ornithologistCode = const Value.absent(),
    DateTime? createdAt,
  }) => UserProfileData(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    ornithologistCode: ornithologistCode.present
        ? ornithologistCode.value
        : this.ornithologistCode,
    createdAt: createdAt ?? this.createdAt,
  );
  UserProfileData copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      ornithologistCode: data.ornithologistCode.present
          ? data.ornithologistCode.value
          : this.ornithologistCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('ornithologistCode: $ornithologistCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, ornithologistCode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.ornithologistCode == this.ornithologistCode &&
          other.createdAt == this.createdAt);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> ornithologistCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.ornithologistCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    required String id,
    required String name,
    required String phone,
    this.ornithologistCode = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       phone = Value(phone),
       createdAt = Value(createdAt);
  static Insertable<UserProfileData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? ornithologistCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (ornithologistCode != null) 'ornithologist_code': ornithologistCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfileTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? ornithologistCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      ornithologistCode: ornithologistCode ?? this.ornithologistCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (ornithologistCode.present) {
      map['ornithologist_code'] = Variable<String>(ornithologistCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('ornithologistCode: $ornithologistCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionParticipantsTableTable extends SessionParticipantsTable
    with TableInfo<$SessionParticipantsTableTable, SessionParticipantData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionParticipantsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions_table (id)',
    ),
  );
  static const VerificationMeta _ornithologistCodeMeta = const VerificationMeta(
    'ornithologistCode',
  );
  @override
  late final GeneratedColumn<String> ornithologistCode =
      GeneratedColumn<String>(
        'ornithologist_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [sessionId, ornithologistCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_participants_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionParticipantData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('ornithologist_code')) {
      context.handle(
        _ornithologistCodeMeta,
        ornithologistCode.isAcceptableOrUnknown(
          data['ornithologist_code']!,
          _ornithologistCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ornithologistCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, ornithologistCode};
  @override
  SessionParticipantData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionParticipantData(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      ornithologistCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ornithologist_code'],
      )!,
    );
  }

  @override
  $SessionParticipantsTableTable createAlias(String alias) {
    return $SessionParticipantsTableTable(attachedDatabase, alias);
  }
}

class SessionParticipantData extends DataClass
    implements Insertable<SessionParticipantData> {
  final String sessionId;
  final String ornithologistCode;
  const SessionParticipantData({
    required this.sessionId,
    required this.ornithologistCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['ornithologist_code'] = Variable<String>(ornithologistCode);
    return map;
  }

  SessionParticipantsTableCompanion toCompanion(bool nullToAbsent) {
    return SessionParticipantsTableCompanion(
      sessionId: Value(sessionId),
      ornithologistCode: Value(ornithologistCode),
    );
  }

  factory SessionParticipantData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionParticipantData(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      ornithologistCode: serializer.fromJson<String>(json['ornithologistCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'ornithologistCode': serializer.toJson<String>(ornithologistCode),
    };
  }

  SessionParticipantData copyWith({
    String? sessionId,
    String? ornithologistCode,
  }) => SessionParticipantData(
    sessionId: sessionId ?? this.sessionId,
    ornithologistCode: ornithologistCode ?? this.ornithologistCode,
  );
  SessionParticipantData copyWithCompanion(
    SessionParticipantsTableCompanion data,
  ) {
    return SessionParticipantData(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      ornithologistCode: data.ornithologistCode.present
          ? data.ornithologistCode.value
          : this.ornithologistCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionParticipantData(')
          ..write('sessionId: $sessionId, ')
          ..write('ornithologistCode: $ornithologistCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, ornithologistCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionParticipantData &&
          other.sessionId == this.sessionId &&
          other.ornithologistCode == this.ornithologistCode);
}

class SessionParticipantsTableCompanion
    extends UpdateCompanion<SessionParticipantData> {
  final Value<String> sessionId;
  final Value<String> ornithologistCode;
  final Value<int> rowid;
  const SessionParticipantsTableCompanion({
    this.sessionId = const Value.absent(),
    this.ornithologistCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionParticipantsTableCompanion.insert({
    required String sessionId,
    required String ornithologistCode,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       ornithologistCode = Value(ornithologistCode);
  static Insertable<SessionParticipantData> custom({
    Expression<String>? sessionId,
    Expression<String>? ornithologistCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (ornithologistCode != null) 'ornithologist_code': ornithologistCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionParticipantsTableCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? ornithologistCode,
    Value<int>? rowid,
  }) {
    return SessionParticipantsTableCompanion(
      sessionId: sessionId ?? this.sessionId,
      ornithologistCode: ornithologistCode ?? this.ornithologistCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (ornithologistCode.present) {
      map['ornithologist_code'] = Variable<String>(ornithologistCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionParticipantsTableCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('ornithologistCode: $ornithologistCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTableTable extends SyncMetadataTable
    with TableInfo<$SyncMetadataTableTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sinceMeta = const VerificationMeta('since');
  @override
  late final GeneratedColumn<String> since = GeneratedColumn<String>(
    'since',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPageMeta = const VerificationMeta(
    'currentPage',
  );
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
    'current_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [key, since, currentPage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('since')) {
      context.handle(
        _sinceMeta,
        since.isAcceptableOrUnknown(data['since']!, _sinceMeta),
      );
    }
    if (data.containsKey('current_page')) {
      context.handle(
        _currentPageMeta,
        currentPage.isAcceptableOrUnknown(
          data['current_page']!,
          _currentPageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      since: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}since'],
      ),
      currentPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_page'],
      )!,
    );
  }

  @override
  $SyncMetadataTableTable createAlias(String alias) {
    return $SyncMetadataTableTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final String? since;
  final int currentPage;
  const SyncMetadataData({
    required this.key,
    this.since,
    required this.currentPage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || since != null) {
      map['since'] = Variable<String>(since);
    }
    map['current_page'] = Variable<int>(currentPage);
    return map;
  }

  SyncMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataTableCompanion(
      key: Value(key),
      since: since == null && nullToAbsent
          ? const Value.absent()
          : Value(since),
      currentPage: Value(currentPage),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      since: serializer.fromJson<String?>(json['since']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'since': serializer.toJson<String?>(since),
      'currentPage': serializer.toJson<int>(currentPage),
    };
  }

  SyncMetadataData copyWith({
    String? key,
    Value<String?> since = const Value.absent(),
    int? currentPage,
  }) => SyncMetadataData(
    key: key ?? this.key,
    since: since.present ? since.value : this.since,
    currentPage: currentPage ?? this.currentPage,
  );
  SyncMetadataData copyWithCompanion(SyncMetadataTableCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      since: data.since.present ? data.since.value : this.since,
      currentPage: data.currentPage.present
          ? data.currentPage.value
          : this.currentPage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('since: $since, ')
          ..write('currentPage: $currentPage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, since, currentPage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.since == this.since &&
          other.currentPage == this.currentPage);
}

class SyncMetadataTableCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<String?> since;
  final Value<int> currentPage;
  final Value<int> rowid;
  const SyncMetadataTableCompanion({
    this.key = const Value.absent(),
    this.since = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataTableCompanion.insert({
    required String key,
    this.since = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? since,
    Expression<int>? currentPage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (since != null) 'since': since,
      if (currentPage != null) 'current_page': currentPage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataTableCompanion copyWith({
    Value<String>? key,
    Value<String?>? since,
    Value<int>? currentPage,
    Value<int>? rowid,
  }) {
    return SyncMetadataTableCompanion(
      key: key ?? this.key,
      since: since ?? this.since,
      currentPage: currentPage ?? this.currentPage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (since.present) {
      map['since'] = Variable<String>(since.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('since: $since, ')
          ..write('currentPage: $currentPage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CensusesTableTable extends CensusesTable
    with TableInfo<$CensusesTableTable, CensusEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CensusesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isJoinedMeta = const VerificationMeta(
    'isJoined',
  );
  @override
  late final GeneratedColumn<bool> isJoined = GeneratedColumn<bool>(
    'is_joined',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_joined" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _alreadyDoneMeta = const VerificationMeta(
    'alreadyDone',
  );
  @override
  late final GeneratedColumn<bool> alreadyDone = GeneratedColumn<bool>(
    'already_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("already_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startTime,
    locationName,
    description,
    latitude,
    longitude,
    isJoined,
    alreadyDone,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'censuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CensusEntityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('is_joined')) {
      context.handle(
        _isJoinedMeta,
        isJoined.isAcceptableOrUnknown(data['is_joined']!, _isJoinedMeta),
      );
    }
    if (data.containsKey('already_done')) {
      context.handle(
        _alreadyDoneMeta,
        alreadyDone.isAcceptableOrUnknown(
          data['already_done']!,
          _alreadyDoneMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CensusEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CensusEntityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      isJoined: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_joined'],
      )!,
      alreadyDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}already_done'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CensusesTableTable createAlias(String alias) {
    return $CensusesTableTable(attachedDatabase, alias);
  }
}

class CensusEntityData extends DataClass
    implements Insertable<CensusEntityData> {
  final String id;
  final String title;
  final DateTime startTime;
  final String? locationName;
  final String? description;
  final double? latitude;
  final double? longitude;
  final bool isJoined;
  final bool alreadyDone;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CensusEntityData({
    required this.id,
    required this.title,
    required this.startTime,
    this.locationName,
    this.description,
    this.latitude,
    this.longitude,
    required this.isJoined,
    required this.alreadyDone,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || locationName != null) {
      map['location_name'] = Variable<String>(locationName);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['is_joined'] = Variable<bool>(isJoined);
    map['already_done'] = Variable<bool>(alreadyDone);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CensusesTableCompanion toCompanion(bool nullToAbsent) {
    return CensusesTableCompanion(
      id: Value(id),
      title: Value(title),
      startTime: Value(startTime),
      locationName: locationName == null && nullToAbsent
          ? const Value.absent()
          : Value(locationName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      isJoined: Value(isJoined),
      alreadyDone: Value(alreadyDone),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CensusEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CensusEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      description: serializer.fromJson<String?>(json['description']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      isJoined: serializer.fromJson<bool>(json['isJoined']),
      alreadyDone: serializer.fromJson<bool>(json['alreadyDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<DateTime>(startTime),
      'locationName': serializer.toJson<String?>(locationName),
      'description': serializer.toJson<String?>(description),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'isJoined': serializer.toJson<bool>(isJoined),
      'alreadyDone': serializer.toJson<bool>(alreadyDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CensusEntityData copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    Value<String?> locationName = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? isJoined,
    bool? alreadyDone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CensusEntityData(
    id: id ?? this.id,
    title: title ?? this.title,
    startTime: startTime ?? this.startTime,
    locationName: locationName.present ? locationName.value : this.locationName,
    description: description.present ? description.value : this.description,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    isJoined: isJoined ?? this.isJoined,
    alreadyDone: alreadyDone ?? this.alreadyDone,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CensusEntityData copyWithCompanion(CensusesTableCompanion data) {
    return CensusEntityData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      description: data.description.present
          ? data.description.value
          : this.description,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isJoined: data.isJoined.present ? data.isJoined.value : this.isJoined,
      alreadyDone: data.alreadyDone.present
          ? data.alreadyDone.value
          : this.alreadyDone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CensusEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('locationName: $locationName, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isJoined: $isJoined, ')
          ..write('alreadyDone: $alreadyDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    startTime,
    locationName,
    description,
    latitude,
    longitude,
    isJoined,
    alreadyDone,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CensusEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.locationName == this.locationName &&
          other.description == this.description &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isJoined == this.isJoined &&
          other.alreadyDone == this.alreadyDone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CensusesTableCompanion extends UpdateCompanion<CensusEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> startTime;
  final Value<String?> locationName;
  final Value<String?> description;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> isJoined;
  final Value<bool> alreadyDone;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CensusesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.locationName = const Value.absent(),
    this.description = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.alreadyDone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CensusesTableCompanion.insert({
    required String id,
    required String title,
    required DateTime startTime,
    this.locationName = const Value.absent(),
    this.description = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.alreadyDone = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       startTime = Value(startTime),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CensusEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? startTime,
    Expression<String>? locationName,
    Expression<String>? description,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isJoined,
    Expression<bool>? alreadyDone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (locationName != null) 'location_name': locationName,
      if (description != null) 'description': description,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isJoined != null) 'is_joined': isJoined,
      if (alreadyDone != null) 'already_done': alreadyDone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CensusesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime>? startTime,
    Value<String?>? locationName,
    Value<String?>? description,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? isJoined,
    Value<bool>? alreadyDone,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CensusesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      locationName: locationName ?? this.locationName,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isJoined: isJoined ?? this.isJoined,
      alreadyDone: alreadyDone ?? this.alreadyDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isJoined.present) {
      map['is_joined'] = Variable<bool>(isJoined.value);
    }
    if (alreadyDone.present) {
      map['already_done'] = Variable<bool>(alreadyDone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CensusesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('locationName: $locationName, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isJoined: $isJoined, ')
          ..write('alreadyDone: $alreadyDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDatabase extends GeneratedDatabase {
  _$UserDatabase(QueryExecutor e) : super(e);
  $UserDatabaseManager get managers => $UserDatabaseManager(this);
  late final $SessionsTableTable sessionsTable = $SessionsTableTable(this);
  late final $ObservationsTableTable observationsTable =
      $ObservationsTableTable(this);
  late final $UserProfileTableTable userProfileTable = $UserProfileTableTable(
    this,
  );
  late final $SessionParticipantsTableTable sessionParticipantsTable =
      $SessionParticipantsTableTable(this);
  late final $SyncMetadataTableTable syncMetadataTable =
      $SyncMetadataTableTable(this);
  late final $CensusesTableTable censusesTable = $CensusesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessionsTable,
    observationsTable,
    userProfileTable,
    sessionParticipantsTable,
    syncMetadataTable,
    censusesTable,
  ];
}

typedef $$SessionsTableTableCreateCompanionBuilder =
    SessionsTableCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isDeleted,
      required String annotatorId,
      required SessionType sessionType,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<TemperatureRange> temperature,
      Value<WindLevel> wind,
      Value<SkyCondition> sky,
      Value<RainLevel> rain,
      Value<VisibilityLevel> visibility,
      Value<MoonPresence> moon,
      Value<int?> listeningPoint,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<double?> altitude,
      Value<double?> altitudeAccuracy,
      Value<DateTime?> positionTimestamp,
      Value<LocationErrorType?> locationError,
      Value<LocationSource?> locationSource,
      required bool isLocked,
      required SyncStatus syncStatus,
      Value<SyncErrorType?> syncError,
      Value<String?> censusId,
      Value<int> rowid,
    });
typedef $$SessionsTableTableUpdateCompanionBuilder =
    SessionsTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String> annotatorId,
      Value<SessionType> sessionType,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<TemperatureRange> temperature,
      Value<WindLevel> wind,
      Value<SkyCondition> sky,
      Value<RainLevel> rain,
      Value<VisibilityLevel> visibility,
      Value<MoonPresence> moon,
      Value<int?> listeningPoint,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<double?> altitude,
      Value<double?> altitudeAccuracy,
      Value<DateTime?> positionTimestamp,
      Value<LocationErrorType?> locationError,
      Value<LocationSource?> locationSource,
      Value<bool> isLocked,
      Value<SyncStatus> syncStatus,
      Value<SyncErrorType?> syncError,
      Value<String?> censusId,
      Value<int> rowid,
    });

final class $$SessionsTableTableReferences
    extends
        BaseReferences<_$UserDatabase, $SessionsTableTable, SessionEntityData> {
  $$SessionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ObservationsTableTable,
    List<ObservationEntityData>
  >
  _observationsTableRefsTable(_$UserDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.observationsTable,
        aliasName: $_aliasNameGenerator(
          db.sessionsTable.id,
          db.observationsTable.sessionId,
        ),
      );

  $$ObservationsTableTableProcessedTableManager get observationsTableRefs {
    final manager = $$ObservationsTableTableTableManager(
      $_db,
      $_db.observationsTable,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _observationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SessionParticipantsTableTable,
    List<SessionParticipantData>
  >
  _sessionParticipantsTableRefsTable(_$UserDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sessionParticipantsTable,
        aliasName: $_aliasNameGenerator(
          db.sessionsTable.id,
          db.sessionParticipantsTable.sessionId,
        ),
      );

  $$SessionParticipantsTableTableProcessedTableManager
  get sessionParticipantsTableRefs {
    final manager = $$SessionParticipantsTableTableTableManager(
      $_db,
      $_db.sessionParticipantsTable,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionParticipantsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableTableFilterComposer
    extends Composer<_$UserDatabase, $SessionsTableTable> {
  $$SessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get annotatorId => $composableBuilder(
    column: $table.annotatorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SessionType, SessionType, int>
  get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TemperatureRange, TemperatureRange, int>
  get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<WindLevel, WindLevel, int> get wind =>
      $composableBuilder(
        column: $table.wind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SkyCondition, SkyCondition, int> get sky =>
      $composableBuilder(
        column: $table.sky,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<RainLevel, RainLevel, int> get rain =>
      $composableBuilder(
        column: $table.rain,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<VisibilityLevel, VisibilityLevel, int>
  get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MoonPresence, MoonPresence, int> get moon =>
      $composableBuilder(
        column: $table.moon,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get listeningPoint => $composableBuilder(
    column: $table.listeningPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationErrorType?, LocationErrorType, int>
  get locationError => $composableBuilder(
    column: $table.locationError,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationSource?, LocationSource, int>
  get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SyncErrorType?, SyncErrorType, int>
  get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get censusId => $composableBuilder(
    column: $table.censusId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> observationsTableRefs(
    Expression<bool> Function($$ObservationsTableTableFilterComposer f) f,
  ) {
    final $$ObservationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observationsTable,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationsTableTableFilterComposer(
            $db: $db,
            $table: $db.observationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionParticipantsTableRefs(
    Expression<bool> Function($$SessionParticipantsTableTableFilterComposer f)
    f,
  ) {
    final $$SessionParticipantsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionParticipantsTable,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionParticipantsTableTableFilterComposer(
                $db: $db,
                $table: $db.sessionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SessionsTableTableOrderingComposer
    extends Composer<_$UserDatabase, $SessionsTableTable> {
  $$SessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get annotatorId => $composableBuilder(
    column: $table.annotatorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wind => $composableBuilder(
    column: $table.wind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sky => $composableBuilder(
    column: $table.sky,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rain => $composableBuilder(
    column: $table.rain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moon => $composableBuilder(
    column: $table.moon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get listeningPoint => $composableBuilder(
    column: $table.listeningPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locationError => $composableBuilder(
    column: $table.locationError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get censusId => $composableBuilder(
    column: $table.censusId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $SessionsTableTable> {
  $$SessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get annotatorId => $composableBuilder(
    column: $table.annotatorId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SessionType, int> get sessionType =>
      $composableBuilder(
        column: $table.sessionType,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TemperatureRange, int> get temperature =>
      $composableBuilder(
        column: $table.temperature,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<WindLevel, int> get wind =>
      $composableBuilder(column: $table.wind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SkyCondition, int> get sky =>
      $composableBuilder(column: $table.sky, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RainLevel, int> get rain =>
      $composableBuilder(column: $table.rain, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VisibilityLevel, int> get visibility =>
      $composableBuilder(
        column: $table.visibility,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<MoonPresence, int> get moon =>
      $composableBuilder(column: $table.moon, builder: (column) => column);

  GeneratedColumn<int> get listeningPoint => $composableBuilder(
    column: $table.listeningPoint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LocationErrorType?, int> get locationError =>
      $composableBuilder(
        column: $table.locationError,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<LocationSource?, int> get locationSource =>
      $composableBuilder(
        column: $table.locationSource,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SyncErrorType?, int> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<String> get censusId =>
      $composableBuilder(column: $table.censusId, builder: (column) => column);

  Expression<T> observationsTableRefs<T extends Object>(
    Expression<T> Function($$ObservationsTableTableAnnotationComposer a) f,
  ) {
    final $$ObservationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.observationsTable,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ObservationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.observationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> sessionParticipantsTableRefs<T extends Object>(
    Expression<T> Function($$SessionParticipantsTableTableAnnotationComposer a)
    f,
  ) {
    final $$SessionParticipantsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionParticipantsTable,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionParticipantsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SessionsTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $SessionsTableTable,
          SessionEntityData,
          $$SessionsTableTableFilterComposer,
          $$SessionsTableTableOrderingComposer,
          $$SessionsTableTableAnnotationComposer,
          $$SessionsTableTableCreateCompanionBuilder,
          $$SessionsTableTableUpdateCompanionBuilder,
          (SessionEntityData, $$SessionsTableTableReferences),
          SessionEntityData,
          PrefetchHooks Function({
            bool observationsTableRefs,
            bool sessionParticipantsTableRefs,
          })
        > {
  $$SessionsTableTableTableManager(_$UserDatabase db, $SessionsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> annotatorId = const Value.absent(),
                Value<SessionType> sessionType = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<TemperatureRange> temperature = const Value.absent(),
                Value<WindLevel> wind = const Value.absent(),
                Value<SkyCondition> sky = const Value.absent(),
                Value<RainLevel> rain = const Value.absent(),
                Value<VisibilityLevel> visibility = const Value.absent(),
                Value<MoonPresence> moon = const Value.absent(),
                Value<int?> listeningPoint = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double?> altitudeAccuracy = const Value.absent(),
                Value<DateTime?> positionTimestamp = const Value.absent(),
                Value<LocationErrorType?> locationError = const Value.absent(),
                Value<LocationSource?> locationSource = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<SyncErrorType?> syncError = const Value.absent(),
                Value<String?> censusId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                annotatorId: annotatorId,
                sessionType: sessionType,
                startTime: startTime,
                endTime: endTime,
                temperature: temperature,
                wind: wind,
                sky: sky,
                rain: rain,
                visibility: visibility,
                moon: moon,
                listeningPoint: listeningPoint,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                altitudeAccuracy: altitudeAccuracy,
                positionTimestamp: positionTimestamp,
                locationError: locationError,
                locationSource: locationSource,
                isLocked: isLocked,
                syncStatus: syncStatus,
                syncError: syncError,
                censusId: censusId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                required String annotatorId,
                required SessionType sessionType,
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<TemperatureRange> temperature = const Value.absent(),
                Value<WindLevel> wind = const Value.absent(),
                Value<SkyCondition> sky = const Value.absent(),
                Value<RainLevel> rain = const Value.absent(),
                Value<VisibilityLevel> visibility = const Value.absent(),
                Value<MoonPresence> moon = const Value.absent(),
                Value<int?> listeningPoint = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double?> altitudeAccuracy = const Value.absent(),
                Value<DateTime?> positionTimestamp = const Value.absent(),
                Value<LocationErrorType?> locationError = const Value.absent(),
                Value<LocationSource?> locationSource = const Value.absent(),
                required bool isLocked,
                required SyncStatus syncStatus,
                Value<SyncErrorType?> syncError = const Value.absent(),
                Value<String?> censusId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                annotatorId: annotatorId,
                sessionType: sessionType,
                startTime: startTime,
                endTime: endTime,
                temperature: temperature,
                wind: wind,
                sky: sky,
                rain: rain,
                visibility: visibility,
                moon: moon,
                listeningPoint: listeningPoint,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                altitudeAccuracy: altitudeAccuracy,
                positionTimestamp: positionTimestamp,
                locationError: locationError,
                locationSource: locationSource,
                isLocked: isLocked,
                syncStatus: syncStatus,
                syncError: syncError,
                censusId: censusId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                observationsTableRefs = false,
                sessionParticipantsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (observationsTableRefs) db.observationsTable,
                    if (sessionParticipantsTableRefs)
                      db.sessionParticipantsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (observationsTableRefs)
                        await $_getPrefetchedData<
                          SessionEntityData,
                          $SessionsTableTable,
                          ObservationEntityData
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableTableReferences
                              ._observationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).observationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionParticipantsTableRefs)
                        await $_getPrefetchedData<
                          SessionEntityData,
                          $SessionsTableTable,
                          SessionParticipantData
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableTableReferences
                              ._sessionParticipantsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionParticipantsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $SessionsTableTable,
      SessionEntityData,
      $$SessionsTableTableFilterComposer,
      $$SessionsTableTableOrderingComposer,
      $$SessionsTableTableAnnotationComposer,
      $$SessionsTableTableCreateCompanionBuilder,
      $$SessionsTableTableUpdateCompanionBuilder,
      (SessionEntityData, $$SessionsTableTableReferences),
      SessionEntityData,
      PrefetchHooks Function({
        bool observationsTableRefs,
        bool sessionParticipantsTableRefs,
      })
    >;
typedef $$ObservationsTableTableCreateCompanionBuilder =
    ObservationsTableCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isDeleted,
      required String sessionId,
      required String speciesId,
      required ContactType contactType,
      required int quantity,
      required DateTime startTime,
      required DateTime endTime,
      Value<String?> notes,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<double?> altitude,
      Value<double?> altitudeAccuracy,
      Value<DateTime?> positionTimestamp,
      Value<LocationErrorType?> locationError,
      Value<LocationSource?> locationSource,
      required double bearing,
      Value<int> rowid,
    });
typedef $$ObservationsTableTableUpdateCompanionBuilder =
    ObservationsTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String> sessionId,
      Value<String> speciesId,
      Value<ContactType> contactType,
      Value<int> quantity,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String?> notes,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<double?> altitude,
      Value<double?> altitudeAccuracy,
      Value<DateTime?> positionTimestamp,
      Value<LocationErrorType?> locationError,
      Value<LocationSource?> locationSource,
      Value<double> bearing,
      Value<int> rowid,
    });

final class $$ObservationsTableTableReferences
    extends
        BaseReferences<
          _$UserDatabase,
          $ObservationsTableTable,
          ObservationEntityData
        > {
  $$ObservationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTableTable _sessionIdTable(_$UserDatabase db) =>
      db.sessionsTable.createAlias(
        $_aliasNameGenerator(
          db.observationsTable.sessionId,
          db.sessionsTable.id,
        ),
      );

  $$SessionsTableTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableTableManager(
      $_db,
      $_db.sessionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ObservationsTableTableFilterComposer
    extends Composer<_$UserDatabase, $ObservationsTableTable> {
  $$ObservationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ContactType, ContactType, int>
  get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationErrorType?, LocationErrorType, int>
  get locationError => $composableBuilder(
    column: $table.locationError,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationSource?, LocationSource, int>
  get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get bearing => $composableBuilder(
    column: $table.bearing,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableTableFilterComposer get sessionId {
    final $$SessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableTableOrderingComposer
    extends Composer<_$UserDatabase, $ObservationsTableTable> {
  $$ObservationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locationError => $composableBuilder(
    column: $table.locationError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bearing => $composableBuilder(
    column: $table.bearing,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableTableOrderingComposer get sessionId {
    final $$SessionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $ObservationsTableTable> {
  $$ObservationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContactType, int> get contactType =>
      $composableBuilder(
        column: $table.contactType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeAccuracy => $composableBuilder(
    column: $table.altitudeAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get positionTimestamp => $composableBuilder(
    column: $table.positionTimestamp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LocationErrorType?, int> get locationError =>
      $composableBuilder(
        column: $table.locationError,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<LocationSource?, int> get locationSource =>
      $composableBuilder(
        column: $table.locationSource,
        builder: (column) => column,
      );

  GeneratedColumn<double> get bearing =>
      $composableBuilder(column: $table.bearing, builder: (column) => column);

  $$SessionsTableTableAnnotationComposer get sessionId {
    final $$SessionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $ObservationsTableTable,
          ObservationEntityData,
          $$ObservationsTableTableFilterComposer,
          $$ObservationsTableTableOrderingComposer,
          $$ObservationsTableTableAnnotationComposer,
          $$ObservationsTableTableCreateCompanionBuilder,
          $$ObservationsTableTableUpdateCompanionBuilder,
          (ObservationEntityData, $$ObservationsTableTableReferences),
          ObservationEntityData,
          PrefetchHooks Function({bool sessionId})
        > {
  $$ObservationsTableTableTableManager(
    _$UserDatabase db,
    $ObservationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObservationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<ContactType> contactType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double?> altitudeAccuracy = const Value.absent(),
                Value<DateTime?> positionTimestamp = const Value.absent(),
                Value<LocationErrorType?> locationError = const Value.absent(),
                Value<LocationSource?> locationSource = const Value.absent(),
                Value<double> bearing = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObservationsTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                sessionId: sessionId,
                speciesId: speciesId,
                contactType: contactType,
                quantity: quantity,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                altitudeAccuracy: altitudeAccuracy,
                positionTimestamp: positionTimestamp,
                locationError: locationError,
                locationSource: locationSource,
                bearing: bearing,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                required String sessionId,
                required String speciesId,
                required ContactType contactType,
                required int quantity,
                required DateTime startTime,
                required DateTime endTime,
                Value<String?> notes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double?> altitudeAccuracy = const Value.absent(),
                Value<DateTime?> positionTimestamp = const Value.absent(),
                Value<LocationErrorType?> locationError = const Value.absent(),
                Value<LocationSource?> locationSource = const Value.absent(),
                required double bearing,
                Value<int> rowid = const Value.absent(),
              }) => ObservationsTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                sessionId: sessionId,
                speciesId: speciesId,
                contactType: contactType,
                quantity: quantity,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                altitudeAccuracy: altitudeAccuracy,
                positionTimestamp: positionTimestamp,
                locationError: locationError,
                locationSource: locationSource,
                bearing: bearing,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$ObservationsTableTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$ObservationsTableTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ObservationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $ObservationsTableTable,
      ObservationEntityData,
      $$ObservationsTableTableFilterComposer,
      $$ObservationsTableTableOrderingComposer,
      $$ObservationsTableTableAnnotationComposer,
      $$ObservationsTableTableCreateCompanionBuilder,
      $$ObservationsTableTableUpdateCompanionBuilder,
      (ObservationEntityData, $$ObservationsTableTableReferences),
      ObservationEntityData,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$UserProfileTableTableCreateCompanionBuilder =
    UserProfileTableCompanion Function({
      required String id,
      required String name,
      required String phone,
      Value<String?> ornithologistCode,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$UserProfileTableTableUpdateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> phone,
      Value<String?> ornithologistCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UserProfileTableTableFilterComposer
    extends Composer<_$UserDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$UserDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfileTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $UserProfileTableTable,
          UserProfileData,
          $$UserProfileTableTableFilterComposer,
          $$UserProfileTableTableOrderingComposer,
          $$UserProfileTableTableAnnotationComposer,
          $$UserProfileTableTableCreateCompanionBuilder,
          $$UserProfileTableTableUpdateCompanionBuilder,
          (
            UserProfileData,
            BaseReferences<
              _$UserDatabase,
              $UserProfileTableTable,
              UserProfileData
            >,
          ),
          UserProfileData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableTableManager(
    _$UserDatabase db,
    $UserProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> ornithologistCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfileTableCompanion(
                id: id,
                name: name,
                phone: phone,
                ornithologistCode: ornithologistCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String phone,
                Value<String?> ornithologistCode = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProfileTableCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                ornithologistCode: ornithologistCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $UserProfileTableTable,
      UserProfileData,
      $$UserProfileTableTableFilterComposer,
      $$UserProfileTableTableOrderingComposer,
      $$UserProfileTableTableAnnotationComposer,
      $$UserProfileTableTableCreateCompanionBuilder,
      $$UserProfileTableTableUpdateCompanionBuilder,
      (
        UserProfileData,
        BaseReferences<_$UserDatabase, $UserProfileTableTable, UserProfileData>,
      ),
      UserProfileData,
      PrefetchHooks Function()
    >;
typedef $$SessionParticipantsTableTableCreateCompanionBuilder =
    SessionParticipantsTableCompanion Function({
      required String sessionId,
      required String ornithologistCode,
      Value<int> rowid,
    });
typedef $$SessionParticipantsTableTableUpdateCompanionBuilder =
    SessionParticipantsTableCompanion Function({
      Value<String> sessionId,
      Value<String> ornithologistCode,
      Value<int> rowid,
    });

final class $$SessionParticipantsTableTableReferences
    extends
        BaseReferences<
          _$UserDatabase,
          $SessionParticipantsTableTable,
          SessionParticipantData
        > {
  $$SessionParticipantsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTableTable _sessionIdTable(_$UserDatabase db) =>
      db.sessionsTable.createAlias(
        $_aliasNameGenerator(
          db.sessionParticipantsTable.sessionId,
          db.sessionsTable.id,
        ),
      );

  $$SessionsTableTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableTableManager(
      $_db,
      $_db.sessionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionParticipantsTableTableFilterComposer
    extends Composer<_$UserDatabase, $SessionParticipantsTableTable> {
  $$SessionParticipantsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableTableFilterComposer get sessionId {
    final $$SessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionParticipantsTableTableOrderingComposer
    extends Composer<_$UserDatabase, $SessionParticipantsTableTable> {
  $$SessionParticipantsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableTableOrderingComposer get sessionId {
    final $$SessionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionParticipantsTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $SessionParticipantsTableTable> {
  $$SessionParticipantsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ornithologistCode => $composableBuilder(
    column: $table.ornithologistCode,
    builder: (column) => column,
  );

  $$SessionsTableTableAnnotationComposer get sessionId {
    final $$SessionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionParticipantsTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $SessionParticipantsTableTable,
          SessionParticipantData,
          $$SessionParticipantsTableTableFilterComposer,
          $$SessionParticipantsTableTableOrderingComposer,
          $$SessionParticipantsTableTableAnnotationComposer,
          $$SessionParticipantsTableTableCreateCompanionBuilder,
          $$SessionParticipantsTableTableUpdateCompanionBuilder,
          (SessionParticipantData, $$SessionParticipantsTableTableReferences),
          SessionParticipantData,
          PrefetchHooks Function({bool sessionId})
        > {
  $$SessionParticipantsTableTableTableManager(
    _$UserDatabase db,
    $SessionParticipantsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionParticipantsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SessionParticipantsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SessionParticipantsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> ornithologistCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionParticipantsTableCompanion(
                sessionId: sessionId,
                ornithologistCode: ornithologistCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String ornithologistCode,
                Value<int> rowid = const Value.absent(),
              }) => SessionParticipantsTableCompanion.insert(
                sessionId: sessionId,
                ornithologistCode: ornithologistCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionParticipantsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$SessionParticipantsTableTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$SessionParticipantsTableTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionParticipantsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $SessionParticipantsTableTable,
      SessionParticipantData,
      $$SessionParticipantsTableTableFilterComposer,
      $$SessionParticipantsTableTableOrderingComposer,
      $$SessionParticipantsTableTableAnnotationComposer,
      $$SessionParticipantsTableTableCreateCompanionBuilder,
      $$SessionParticipantsTableTableUpdateCompanionBuilder,
      (SessionParticipantData, $$SessionParticipantsTableTableReferences),
      SessionParticipantData,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$SyncMetadataTableTableCreateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      required String key,
      Value<String?> since,
      Value<int> currentPage,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableTableUpdateCompanionBuilder =
    SyncMetadataTableCompanion Function({
      Value<String> key,
      Value<String?> since,
      Value<int> currentPage,
      Value<int> rowid,
    });

class $$SyncMetadataTableTableFilterComposer
    extends Composer<_$UserDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get since => $composableBuilder(
    column: $table.since,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableTableOrderingComposer
    extends Composer<_$UserDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get since => $composableBuilder(
    column: $table.since,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get since =>
      $composableBuilder(column: $table.since, builder: (column) => column);

  GeneratedColumn<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $SyncMetadataTableTable,
          SyncMetadataData,
          $$SyncMetadataTableTableFilterComposer,
          $$SyncMetadataTableTableOrderingComposer,
          $$SyncMetadataTableTableAnnotationComposer,
          $$SyncMetadataTableTableCreateCompanionBuilder,
          $$SyncMetadataTableTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<
              _$UserDatabase,
              $SyncMetadataTableTable,
              SyncMetadataData
            >,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableTableManager(
    _$UserDatabase db,
    $SyncMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> since = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion(
                key: key,
                since: since,
                currentPage: currentPage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> since = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataTableCompanion.insert(
                key: key,
                since: since,
                currentPage: currentPage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $SyncMetadataTableTable,
      SyncMetadataData,
      $$SyncMetadataTableTableFilterComposer,
      $$SyncMetadataTableTableOrderingComposer,
      $$SyncMetadataTableTableAnnotationComposer,
      $$SyncMetadataTableTableCreateCompanionBuilder,
      $$SyncMetadataTableTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<
          _$UserDatabase,
          $SyncMetadataTableTable,
          SyncMetadataData
        >,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;
typedef $$CensusesTableTableCreateCompanionBuilder =
    CensusesTableCompanion Function({
      required String id,
      required String title,
      required DateTime startTime,
      Value<String?> locationName,
      Value<String?> description,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isJoined,
      Value<bool> alreadyDone,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CensusesTableTableUpdateCompanionBuilder =
    CensusesTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime> startTime,
      Value<String?> locationName,
      Value<String?> description,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isJoined,
      Value<bool> alreadyDone,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CensusesTableTableFilterComposer
    extends Composer<_$UserDatabase, $CensusesTableTable> {
  $$CensusesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get alreadyDone => $composableBuilder(
    column: $table.alreadyDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CensusesTableTableOrderingComposer
    extends Composer<_$UserDatabase, $CensusesTableTable> {
  $$CensusesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get alreadyDone => $composableBuilder(
    column: $table.alreadyDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CensusesTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $CensusesTableTable> {
  $$CensusesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isJoined =>
      $composableBuilder(column: $table.isJoined, builder: (column) => column);

  GeneratedColumn<bool> get alreadyDone => $composableBuilder(
    column: $table.alreadyDone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CensusesTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $CensusesTableTable,
          CensusEntityData,
          $$CensusesTableTableFilterComposer,
          $$CensusesTableTableOrderingComposer,
          $$CensusesTableTableAnnotationComposer,
          $$CensusesTableTableCreateCompanionBuilder,
          $$CensusesTableTableUpdateCompanionBuilder,
          (
            CensusEntityData,
            BaseReferences<
              _$UserDatabase,
              $CensusesTableTable,
              CensusEntityData
            >,
          ),
          CensusEntityData,
          PrefetchHooks Function()
        > {
  $$CensusesTableTableTableManager(_$UserDatabase db, $CensusesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CensusesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CensusesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CensusesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<String?> locationName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<bool> alreadyDone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CensusesTableCompanion(
                id: id,
                title: title,
                startTime: startTime,
                locationName: locationName,
                description: description,
                latitude: latitude,
                longitude: longitude,
                isJoined: isJoined,
                alreadyDone: alreadyDone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required DateTime startTime,
                Value<String?> locationName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<bool> alreadyDone = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CensusesTableCompanion.insert(
                id: id,
                title: title,
                startTime: startTime,
                locationName: locationName,
                description: description,
                latitude: latitude,
                longitude: longitude,
                isJoined: isJoined,
                alreadyDone: alreadyDone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CensusesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $CensusesTableTable,
      CensusEntityData,
      $$CensusesTableTableFilterComposer,
      $$CensusesTableTableOrderingComposer,
      $$CensusesTableTableAnnotationComposer,
      $$CensusesTableTableCreateCompanionBuilder,
      $$CensusesTableTableUpdateCompanionBuilder,
      (
        CensusEntityData,
        BaseReferences<_$UserDatabase, $CensusesTableTable, CensusEntityData>,
      ),
      CensusEntityData,
      PrefetchHooks Function()
    >;

class $UserDatabaseManager {
  final _$UserDatabase _db;
  $UserDatabaseManager(this._db);
  $$SessionsTableTableTableManager get sessionsTable =>
      $$SessionsTableTableTableManager(_db, _db.sessionsTable);
  $$ObservationsTableTableTableManager get observationsTable =>
      $$ObservationsTableTableTableManager(_db, _db.observationsTable);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
  $$SessionParticipantsTableTableTableManager get sessionParticipantsTable =>
      $$SessionParticipantsTableTableTableManager(
        _db,
        _db.sessionParticipantsTable,
      );
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(_db, _db.syncMetadataTable);
  $$CensusesTableTableTableManager get censusesTable =>
      $$CensusesTableTableTableManager(_db, _db.censusesTable);
}
