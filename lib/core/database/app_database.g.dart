// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

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
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>($SessionsTableTable.$convertersyncStatus);
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
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
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
  static const VerificationMeta _weatherNotesMeta = const VerificationMeta(
    'weatherNotes',
  );
  @override
  late final GeneratedColumn<String> weatherNotes = GeneratedColumn<String>(
    'weather_notes',
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
  List<GeneratedColumn> get $columns => [
    id,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
    annotatorId,
    sessionType,
    startTime,
    endTime,
    weatherNotes,
    latitude,
    longitude,
    isLocked,
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
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
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
    if (data.containsKey('weather_notes')) {
      context.handle(
        _weatherNotesMeta,
        weatherNotes.isAcceptableOrUnknown(
          data['weather_notes']!,
          _weatherNotesMeta,
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
    if (data.containsKey('is_locked')) {
      context.handle(
        _isLockedMeta,
        isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta),
      );
    } else if (isInserting) {
      context.missing(_isLockedMeta);
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
      syncStatus: $SessionsTableTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
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
      weatherNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_notes'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
    );
  }

  @override
  $SessionsTableTable createAlias(String alias) {
    return $SessionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const SyncStatusConverter();
  static JsonTypeConverter2<SessionType, int, int> $convertersessionType =
      const SessionTypeConverter();
}

class SessionEntityData extends DataClass
    implements Insertable<SessionEntityData> {
  final String id;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String annotatorId;
  final SessionType sessionType;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? weatherNotes;
  final double? latitude;
  final double? longitude;
  final bool isLocked;
  const SessionEntityData({
    required this.id,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.annotatorId,
    required this.sessionType,
    this.startTime,
    this.endTime,
    this.weatherNotes,
    this.latitude,
    this.longitude,
    required this.isLocked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['sync_status'] = Variable<int>(
        $SessionsTableTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
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
    if (!nullToAbsent || weatherNotes != null) {
      map['weather_notes'] = Variable<String>(weatherNotes);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['is_locked'] = Variable<bool>(isLocked);
    return map;
  }

  SessionsTableCompanion toCompanion(bool nullToAbsent) {
    return SessionsTableCompanion(
      id: Value(id),
      syncStatus: Value(syncStatus),
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
      weatherNotes: weatherNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherNotes),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      isLocked: Value(isLocked),
    );
  }

  factory SessionEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionEntityData(
      id: serializer.fromJson<String>(json['id']),
      syncStatus: $SessionsTableTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      annotatorId: serializer.fromJson<String>(json['annotatorId']),
      sessionType: $SessionsTableTable.$convertersessionType.fromJson(
        serializer.fromJson<int>(json['sessionType']),
      ),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      weatherNotes: serializer.fromJson<String?>(json['weatherNotes']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncStatus': serializer.toJson<int>(
        $SessionsTableTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'annotatorId': serializer.toJson<String>(annotatorId),
      'sessionType': serializer.toJson<int>(
        $SessionsTableTable.$convertersessionType.toJson(sessionType),
      ),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'weatherNotes': serializer.toJson<String?>(weatherNotes),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'isLocked': serializer.toJson<bool>(isLocked),
    };
  }

  SessionEntityData copyWith({
    String? id,
    SyncStatus? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    String? annotatorId,
    SessionType? sessionType,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<String?> weatherNotes = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? isLocked,
  }) => SessionEntityData(
    id: id ?? this.id,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    annotatorId: annotatorId ?? this.annotatorId,
    sessionType: sessionType ?? this.sessionType,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    weatherNotes: weatherNotes.present ? weatherNotes.value : this.weatherNotes,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    isLocked: isLocked ?? this.isLocked,
  );
  SessionEntityData copyWithCompanion(SessionsTableCompanion data) {
    return SessionEntityData(
      id: data.id.present ? data.id.value : this.id,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
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
      weatherNotes: data.weatherNotes.present
          ? data.weatherNotes.value
          : this.weatherNotes,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntityData(')
          ..write('id: $id, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('annotatorId: $annotatorId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weatherNotes: $weatherNotes, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isLocked: $isLocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
    annotatorId,
    sessionType,
    startTime,
    endTime,
    weatherNotes,
    latitude,
    longitude,
    isLocked,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntityData &&
          other.id == this.id &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.annotatorId == this.annotatorId &&
          other.sessionType == this.sessionType &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.weatherNotes == this.weatherNotes &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isLocked == this.isLocked);
}

class SessionsTableCompanion extends UpdateCompanion<SessionEntityData> {
  final Value<String> id;
  final Value<SyncStatus> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> annotatorId;
  final Value<SessionType> sessionType;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> weatherNotes;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> isLocked;
  final Value<int> rowid;
  const SessionsTableCompanion({
    this.id = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.annotatorId = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weatherNotes = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsTableCompanion.insert({
    required String id,
    required SyncStatus syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isDeleted,
    required String annotatorId,
    required SessionType sessionType,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weatherNotes = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required bool isLocked,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       syncStatus = Value(syncStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       isDeleted = Value(isDeleted),
       annotatorId = Value(annotatorId),
       sessionType = Value(sessionType),
       isLocked = Value(isLocked);
  static Insertable<SessionEntityData> custom({
    Expression<String>? id,
    Expression<int>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? annotatorId,
    Expression<int>? sessionType,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? weatherNotes,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isLocked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (annotatorId != null) 'annotator_id': annotatorId,
      if (sessionType != null) 'session_type': sessionType,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (weatherNotes != null) 'weather_notes': weatherNotes,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isLocked != null) 'is_locked': isLocked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsTableCompanion copyWith({
    Value<String>? id,
    Value<SyncStatus>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<String>? annotatorId,
    Value<SessionType>? sessionType,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<String?>? weatherNotes,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? isLocked,
    Value<int>? rowid,
  }) {
    return SessionsTableCompanion(
      id: id ?? this.id,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      annotatorId: annotatorId ?? this.annotatorId,
      sessionType: sessionType ?? this.sessionType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      weatherNotes: weatherNotes ?? this.weatherNotes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isLocked: isLocked ?? this.isLocked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $SessionsTableTable.$convertersyncStatus.toSql(syncStatus.value),
      );
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
    if (weatherNotes.present) {
      map['weather_notes'] = Variable<String>(weatherNotes.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
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
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('annotatorId: $annotatorId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weatherNotes: $weatherNotes, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isLocked: $isLocked, ')
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
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, int> syncStatus =
      GeneratedColumn<int>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>($ObservationsTableTable.$convertersyncStatus);
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
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
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
  static const VerificationMeta _contactTypeMeta = const VerificationMeta(
    'contactType',
  );
  @override
  late final GeneratedColumn<String> contactType = GeneratedColumn<String>(
    'contact_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  late final GeneratedColumnWithTypeConverter<ValidationStatus, int>
  validationStatus =
      GeneratedColumn<int>(
        'validation_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ValidationStatus>(
        $ObservationsTableTable.$convertervalidationStatus,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncStatus,
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
    validationStatus,
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
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
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
    if (data.containsKey('contact_type')) {
      context.handle(
        _contactTypeMeta,
        contactType.isAcceptableOrUnknown(
          data['contact_type']!,
          _contactTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactTypeMeta);
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
      syncStatus: $ObservationsTableTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
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
      contactType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_type'],
      )!,
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
      validationStatus: $ObservationsTableTable.$convertervalidationStatus
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}validation_status'],
            )!,
          ),
    );
  }

  @override
  $ObservationsTableTable createAlias(String alias) {
    return $ObservationsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, int, int> $convertersyncStatus =
      const SyncStatusConverter();
  static JsonTypeConverter2<ValidationStatus, int, int>
  $convertervalidationStatus = const ValidationStatusConverter();
}

class ObservationEntityData extends DataClass
    implements Insertable<ObservationEntityData> {
  final String id;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String sessionId;
  final String speciesId;
  final String contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final ValidationStatus validationStatus;
  const ObservationEntityData({
    required this.id,
    required this.syncStatus,
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
    required this.validationStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['sync_status'] = Variable<int>(
        $ObservationsTableTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['session_id'] = Variable<String>(sessionId);
    map['species_id'] = Variable<String>(speciesId);
    map['contact_type'] = Variable<String>(contactType);
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
    {
      map['validation_status'] = Variable<int>(
        $ObservationsTableTable.$convertervalidationStatus.toSql(
          validationStatus,
        ),
      );
    }
    return map;
  }

  ObservationsTableCompanion toCompanion(bool nullToAbsent) {
    return ObservationsTableCompanion(
      id: Value(id),
      syncStatus: Value(syncStatus),
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
      validationStatus: Value(validationStatus),
    );
  }

  factory ObservationEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObservationEntityData(
      id: serializer.fromJson<String>(json['id']),
      syncStatus: $ObservationsTableTable.$convertersyncStatus.fromJson(
        serializer.fromJson<int>(json['syncStatus']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      contactType: serializer.fromJson<String>(json['contactType']),
      quantity: serializer.fromJson<int>(json['quantity']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      validationStatus: $ObservationsTableTable.$convertervalidationStatus
          .fromJson(serializer.fromJson<int>(json['validationStatus'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncStatus': serializer.toJson<int>(
        $ObservationsTableTable.$convertersyncStatus.toJson(syncStatus),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'sessionId': serializer.toJson<String>(sessionId),
      'speciesId': serializer.toJson<String>(speciesId),
      'contactType': serializer.toJson<String>(contactType),
      'quantity': serializer.toJson<int>(quantity),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'notes': serializer.toJson<String?>(notes),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'validationStatus': serializer.toJson<int>(
        $ObservationsTableTable.$convertervalidationStatus.toJson(
          validationStatus,
        ),
      ),
    };
  }

  ObservationEntityData copyWith({
    String? id,
    SyncStatus? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    String? sessionId,
    String? speciesId,
    String? contactType,
    int? quantity,
    DateTime? startTime,
    DateTime? endTime,
    Value<String?> notes = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    ValidationStatus? validationStatus,
  }) => ObservationEntityData(
    id: id ?? this.id,
    syncStatus: syncStatus ?? this.syncStatus,
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
    validationStatus: validationStatus ?? this.validationStatus,
  );
  ObservationEntityData copyWithCompanion(ObservationsTableCompanion data) {
    return ObservationEntityData(
      id: data.id.present ? data.id.value : this.id,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
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
      validationStatus: data.validationStatus.present
          ? data.validationStatus.value
          : this.validationStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObservationEntityData(')
          ..write('id: $id, ')
          ..write('syncStatus: $syncStatus, ')
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
          ..write('validationStatus: $validationStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncStatus,
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
    validationStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObservationEntityData &&
          other.id == this.id &&
          other.syncStatus == this.syncStatus &&
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
          other.validationStatus == this.validationStatus);
}

class ObservationsTableCompanion
    extends UpdateCompanion<ObservationEntityData> {
  final Value<String> id;
  final Value<SyncStatus> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> sessionId;
  final Value<String> speciesId;
  final Value<String> contactType;
  final Value<int> quantity;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String?> notes;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<ValidationStatus> validationStatus;
  final Value<int> rowid;
  const ObservationsTableCompanion({
    this.id = const Value.absent(),
    this.syncStatus = const Value.absent(),
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
    this.validationStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObservationsTableCompanion.insert({
    required String id,
    required SyncStatus syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isDeleted,
    required String sessionId,
    required String speciesId,
    required String contactType,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
    this.notes = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required ValidationStatus validationStatus,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       syncStatus = Value(syncStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       isDeleted = Value(isDeleted),
       sessionId = Value(sessionId),
       speciesId = Value(speciesId),
       contactType = Value(contactType),
       quantity = Value(quantity),
       startTime = Value(startTime),
       endTime = Value(endTime),
       validationStatus = Value(validationStatus);
  static Insertable<ObservationEntityData> custom({
    Expression<String>? id,
    Expression<int>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? sessionId,
    Expression<String>? speciesId,
    Expression<String>? contactType,
    Expression<int>? quantity,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? notes,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? validationStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncStatus != null) 'sync_status': syncStatus,
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
      if (validationStatus != null) 'validation_status': validationStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObservationsTableCompanion copyWith({
    Value<String>? id,
    Value<SyncStatus>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<String>? sessionId,
    Value<String>? speciesId,
    Value<String>? contactType,
    Value<int>? quantity,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<String?>? notes,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<ValidationStatus>? validationStatus,
    Value<int>? rowid,
  }) {
    return ObservationsTableCompanion(
      id: id ?? this.id,
      syncStatus: syncStatus ?? this.syncStatus,
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
      validationStatus: validationStatus ?? this.validationStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(
        $ObservationsTableTable.$convertersyncStatus.toSql(syncStatus.value),
      );
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
      map['contact_type'] = Variable<String>(contactType.value);
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
    if (validationStatus.present) {
      map['validation_status'] = Variable<int>(
        $ObservationsTableTable.$convertervalidationStatus.toSql(
          validationStatus.value,
        ),
      );
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
          ..write('syncStatus: $syncStatus, ')
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
          ..write('validationStatus: $validationStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BirdsTableTable extends BirdsTable
    with TableInfo<$BirdsTableTable, BirdEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirdsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _infoUrlMeta = const VerificationMeta(
    'infoUrl',
  );
  @override
  late final GeneratedColumn<String> infoUrl = GeneratedColumn<String>(
    'info_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scientificName,
    imagePath,
    audioPath,
    infoUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'birds_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BirdEntityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scientificNameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('info_url')) {
      context.handle(
        _infoUrlMeta,
        infoUrl.isAcceptableOrUnknown(data['info_url']!, _infoUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BirdEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BirdEntityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      scientificName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scientific_name'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      )!,
      infoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}info_url'],
      ),
    );
  }

  @override
  $BirdsTableTable createAlias(String alias) {
    return $BirdsTableTable(attachedDatabase, alias);
  }
}

class BirdEntityData extends DataClass implements Insertable<BirdEntityData> {
  final String id;
  final String scientificName;
  final String imagePath;
  final String audioPath;
  final String? infoUrl;
  const BirdEntityData({
    required this.id,
    required this.scientificName,
    required this.imagePath,
    required this.audioPath,
    this.infoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scientific_name'] = Variable<String>(scientificName);
    map['image_path'] = Variable<String>(imagePath);
    map['audio_path'] = Variable<String>(audioPath);
    if (!nullToAbsent || infoUrl != null) {
      map['info_url'] = Variable<String>(infoUrl);
    }
    return map;
  }

  BirdsTableCompanion toCompanion(bool nullToAbsent) {
    return BirdsTableCompanion(
      id: Value(id),
      scientificName: Value(scientificName),
      imagePath: Value(imagePath),
      audioPath: Value(audioPath),
      infoUrl: infoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(infoUrl),
    );
  }

  factory BirdEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BirdEntityData(
      id: serializer.fromJson<String>(json['id']),
      scientificName: serializer.fromJson<String>(json['scientificName']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      infoUrl: serializer.fromJson<String?>(json['infoUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scientificName': serializer.toJson<String>(scientificName),
      'imagePath': serializer.toJson<String>(imagePath),
      'audioPath': serializer.toJson<String>(audioPath),
      'infoUrl': serializer.toJson<String?>(infoUrl),
    };
  }

  BirdEntityData copyWith({
    String? id,
    String? scientificName,
    String? imagePath,
    String? audioPath,
    Value<String?> infoUrl = const Value.absent(),
  }) => BirdEntityData(
    id: id ?? this.id,
    scientificName: scientificName ?? this.scientificName,
    imagePath: imagePath ?? this.imagePath,
    audioPath: audioPath ?? this.audioPath,
    infoUrl: infoUrl.present ? infoUrl.value : this.infoUrl,
  );
  BirdEntityData copyWithCompanion(BirdsTableCompanion data) {
    return BirdEntityData(
      id: data.id.present ? data.id.value : this.id,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      infoUrl: data.infoUrl.present ? data.infoUrl.value : this.infoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BirdEntityData(')
          ..write('id: $id, ')
          ..write('scientificName: $scientificName, ')
          ..write('imagePath: $imagePath, ')
          ..write('audioPath: $audioPath, ')
          ..write('infoUrl: $infoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, scientificName, imagePath, audioPath, infoUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BirdEntityData &&
          other.id == this.id &&
          other.scientificName == this.scientificName &&
          other.imagePath == this.imagePath &&
          other.audioPath == this.audioPath &&
          other.infoUrl == this.infoUrl);
}

class BirdsTableCompanion extends UpdateCompanion<BirdEntityData> {
  final Value<String> id;
  final Value<String> scientificName;
  final Value<String> imagePath;
  final Value<String> audioPath;
  final Value<String?> infoUrl;
  final Value<int> rowid;
  const BirdsTableCompanion({
    this.id = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.infoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BirdsTableCompanion.insert({
    required String id,
    required String scientificName,
    required String imagePath,
    required String audioPath,
    this.infoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       scientificName = Value(scientificName),
       imagePath = Value(imagePath),
       audioPath = Value(audioPath);
  static Insertable<BirdEntityData> custom({
    Expression<String>? id,
    Expression<String>? scientificName,
    Expression<String>? imagePath,
    Expression<String>? audioPath,
    Expression<String>? infoUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scientificName != null) 'scientific_name': scientificName,
      if (imagePath != null) 'image_path': imagePath,
      if (audioPath != null) 'audio_path': audioPath,
      if (infoUrl != null) 'info_url': infoUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BirdsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? scientificName,
    Value<String>? imagePath,
    Value<String>? audioPath,
    Value<String?>? infoUrl,
    Value<int>? rowid,
  }) {
    return BirdsTableCompanion(
      id: id ?? this.id,
      scientificName: scientificName ?? this.scientificName,
      imagePath: imagePath ?? this.imagePath,
      audioPath: audioPath ?? this.audioPath,
      infoUrl: infoUrl ?? this.infoUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (infoUrl.present) {
      map['info_url'] = Variable<String>(infoUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirdsTableCompanion(')
          ..write('id: $id, ')
          ..write('scientificName: $scientificName, ')
          ..write('imagePath: $imagePath, ')
          ..write('audioPath: $audioPath, ')
          ..write('infoUrl: $infoUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BirdNamesTableTable extends BirdNamesTable
    with TableInfo<$BirdNamesTableTable, BirdNameEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirdNamesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birdIdMeta = const VerificationMeta('birdId');
  @override
  late final GeneratedColumn<String> birdId = GeneratedColumn<String>(
    'bird_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES birds_table (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commonNameMeta = const VerificationMeta(
    'commonName',
  );
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
    'common_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    birdId,
    languageCode,
    commonName,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bird_names_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BirdNameEntityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bird_id')) {
      context.handle(
        _birdIdMeta,
        birdId.isAcceptableOrUnknown(data['bird_id']!, _birdIdMeta),
      );
    } else if (isInserting) {
      context.missing(_birdIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('common_name')) {
      context.handle(
        _commonNameMeta,
        commonName.isAcceptableOrUnknown(data['common_name']!, _commonNameMeta),
      );
    } else if (isInserting) {
      context.missing(_commonNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BirdNameEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BirdNameEntityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      birdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bird_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      commonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $BirdNamesTableTable createAlias(String alias) {
    return $BirdNamesTableTable(attachedDatabase, alias);
  }
}

class BirdNameEntityData extends DataClass
    implements Insertable<BirdNameEntityData> {
  final String id;
  final String birdId;
  final String languageCode;
  final String commonName;
  final String description;
  const BirdNameEntityData({
    required this.id,
    required this.birdId,
    required this.languageCode,
    required this.commonName,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bird_id'] = Variable<String>(birdId);
    map['language_code'] = Variable<String>(languageCode);
    map['common_name'] = Variable<String>(commonName);
    map['description'] = Variable<String>(description);
    return map;
  }

  BirdNamesTableCompanion toCompanion(bool nullToAbsent) {
    return BirdNamesTableCompanion(
      id: Value(id),
      birdId: Value(birdId),
      languageCode: Value(languageCode),
      commonName: Value(commonName),
      description: Value(description),
    );
  }

  factory BirdNameEntityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BirdNameEntityData(
      id: serializer.fromJson<String>(json['id']),
      birdId: serializer.fromJson<String>(json['birdId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      commonName: serializer.fromJson<String>(json['commonName']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'birdId': serializer.toJson<String>(birdId),
      'languageCode': serializer.toJson<String>(languageCode),
      'commonName': serializer.toJson<String>(commonName),
      'description': serializer.toJson<String>(description),
    };
  }

  BirdNameEntityData copyWith({
    String? id,
    String? birdId,
    String? languageCode,
    String? commonName,
    String? description,
  }) => BirdNameEntityData(
    id: id ?? this.id,
    birdId: birdId ?? this.birdId,
    languageCode: languageCode ?? this.languageCode,
    commonName: commonName ?? this.commonName,
    description: description ?? this.description,
  );
  BirdNameEntityData copyWithCompanion(BirdNamesTableCompanion data) {
    return BirdNameEntityData(
      id: data.id.present ? data.id.value : this.id,
      birdId: data.birdId.present ? data.birdId.value : this.birdId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      commonName: data.commonName.present
          ? data.commonName.value
          : this.commonName,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BirdNameEntityData(')
          ..write('id: $id, ')
          ..write('birdId: $birdId, ')
          ..write('languageCode: $languageCode, ')
          ..write('commonName: $commonName, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, birdId, languageCode, commonName, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BirdNameEntityData &&
          other.id == this.id &&
          other.birdId == this.birdId &&
          other.languageCode == this.languageCode &&
          other.commonName == this.commonName &&
          other.description == this.description);
}

class BirdNamesTableCompanion extends UpdateCompanion<BirdNameEntityData> {
  final Value<String> id;
  final Value<String> birdId;
  final Value<String> languageCode;
  final Value<String> commonName;
  final Value<String> description;
  final Value<int> rowid;
  const BirdNamesTableCompanion({
    this.id = const Value.absent(),
    this.birdId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.commonName = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BirdNamesTableCompanion.insert({
    required String id,
    required String birdId,
    required String languageCode,
    required String commonName,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       birdId = Value(birdId),
       languageCode = Value(languageCode),
       commonName = Value(commonName),
       description = Value(description);
  static Insertable<BirdNameEntityData> custom({
    Expression<String>? id,
    Expression<String>? birdId,
    Expression<String>? languageCode,
    Expression<String>? commonName,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (birdId != null) 'bird_id': birdId,
      if (languageCode != null) 'language_code': languageCode,
      if (commonName != null) 'common_name': commonName,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BirdNamesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? birdId,
    Value<String>? languageCode,
    Value<String>? commonName,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return BirdNamesTableCompanion(
      id: id ?? this.id,
      birdId: birdId ?? this.birdId,
      languageCode: languageCode ?? this.languageCode,
      commonName: commonName ?? this.commonName,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (birdId.present) {
      map['bird_id'] = Variable<String>(birdId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirdNamesTableCompanion(')
          ..write('id: $id, ')
          ..write('birdId: $birdId, ')
          ..write('languageCode: $languageCode, ')
          ..write('commonName: $commonName, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTableTable sessionsTable = $SessionsTableTable(this);
  late final $ObservationsTableTable observationsTable =
      $ObservationsTableTable(this);
  late final $BirdsTableTable birdsTable = $BirdsTableTable(this);
  late final $BirdNamesTableTable birdNamesTable = $BirdNamesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessionsTable,
    observationsTable,
    birdsTable,
    birdNamesTable,
  ];
}

typedef $$SessionsTableTableCreateCompanionBuilder =
    SessionsTableCompanion Function({
      required String id,
      required SyncStatus syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      required bool isDeleted,
      required String annotatorId,
      required SessionType sessionType,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<String?> weatherNotes,
      Value<double?> latitude,
      Value<double?> longitude,
      required bool isLocked,
      Value<int> rowid,
    });
typedef $$SessionsTableTableUpdateCompanionBuilder =
    SessionsTableCompanion Function({
      Value<String> id,
      Value<SyncStatus> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String> annotatorId,
      Value<SessionType> sessionType,
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<String?> weatherNotes,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isLocked,
      Value<int> rowid,
    });

final class $$SessionsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $SessionsTableTable, SessionEntityData> {
  $$SessionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ObservationsTableTable,
    List<ObservationEntityData>
  >
  _observationsTableRefsTable(_$AppDatabase db) =>
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
}

class $$SessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
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

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnFilters<String> get weatherNotes => $composableBuilder(
    column: $table.weatherNotes,
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

  ColumnFilters<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
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
}

class $$SessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
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

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
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

  ColumnOrderings<String> get weatherNotes => $composableBuilder(
    column: $table.weatherNotes,
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

  ColumnOrderings<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
  $$SessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

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

  GeneratedColumn<String> get weatherNotes => $composableBuilder(
    column: $table.weatherNotes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);

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
}

class $$SessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTableTable,
          SessionEntityData,
          $$SessionsTableTableFilterComposer,
          $$SessionsTableTableOrderingComposer,
          $$SessionsTableTableAnnotationComposer,
          $$SessionsTableTableCreateCompanionBuilder,
          $$SessionsTableTableUpdateCompanionBuilder,
          (SessionEntityData, $$SessionsTableTableReferences),
          SessionEntityData,
          PrefetchHooks Function({bool observationsTableRefs})
        > {
  $$SessionsTableTableTableManager(_$AppDatabase db, $SessionsTableTable table)
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
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> annotatorId = const Value.absent(),
                Value<SessionType> sessionType = const Value.absent(),
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> weatherNotes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion(
                id: id,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                annotatorId: annotatorId,
                sessionType: sessionType,
                startTime: startTime,
                endTime: endTime,
                weatherNotes: weatherNotes,
                latitude: latitude,
                longitude: longitude,
                isLocked: isLocked,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required SyncStatus syncStatus,
                required DateTime createdAt,
                required DateTime updatedAt,
                required bool isDeleted,
                required String annotatorId,
                required SessionType sessionType,
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> weatherNotes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required bool isLocked,
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion.insert(
                id: id,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                annotatorId: annotatorId,
                sessionType: sessionType,
                startTime: startTime,
                endTime: endTime,
                weatherNotes: weatherNotes,
                latitude: latitude,
                longitude: longitude,
                isLocked: isLocked,
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
          prefetchHooksCallback: ({observationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (observationsTableRefs) db.observationsTable,
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
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
      _$AppDatabase,
      $SessionsTableTable,
      SessionEntityData,
      $$SessionsTableTableFilterComposer,
      $$SessionsTableTableOrderingComposer,
      $$SessionsTableTableAnnotationComposer,
      $$SessionsTableTableCreateCompanionBuilder,
      $$SessionsTableTableUpdateCompanionBuilder,
      (SessionEntityData, $$SessionsTableTableReferences),
      SessionEntityData,
      PrefetchHooks Function({bool observationsTableRefs})
    >;
typedef $$ObservationsTableTableCreateCompanionBuilder =
    ObservationsTableCompanion Function({
      required String id,
      required SyncStatus syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      required bool isDeleted,
      required String sessionId,
      required String speciesId,
      required String contactType,
      required int quantity,
      required DateTime startTime,
      required DateTime endTime,
      Value<String?> notes,
      Value<double?> latitude,
      Value<double?> longitude,
      required ValidationStatus validationStatus,
      Value<int> rowid,
    });
typedef $$ObservationsTableTableUpdateCompanionBuilder =
    ObservationsTableCompanion Function({
      Value<String> id,
      Value<SyncStatus> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<String> sessionId,
      Value<String> speciesId,
      Value<String> contactType,
      Value<int> quantity,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String?> notes,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<ValidationStatus> validationStatus,
      Value<int> rowid,
    });

final class $$ObservationsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ObservationsTableTable,
          ObservationEntityData
        > {
  $$ObservationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTableTable _sessionIdTable(_$AppDatabase db) =>
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
    extends Composer<_$AppDatabase, $ObservationsTableTable> {
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

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnFilters<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnFilters(column),
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

  ColumnWithTypeConverterFilters<ValidationStatus, ValidationStatus, int>
  get validationStatus => $composableBuilder(
    column: $table.validationStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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
    extends Composer<_$AppDatabase, $ObservationsTableTable> {
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

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
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

  ColumnOrderings<String> get contactType => $composableBuilder(
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

  ColumnOrderings<int> get validationStatus => $composableBuilder(
    column: $table.validationStatus,
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
    extends Composer<_$AppDatabase, $ObservationsTableTable> {
  $$ObservationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, int> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get contactType => $composableBuilder(
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

  GeneratedColumnWithTypeConverter<ValidationStatus, int>
  get validationStatus => $composableBuilder(
    column: $table.validationStatus,
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

class $$ObservationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
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
    _$AppDatabase db,
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
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<String> contactType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<ValidationStatus> validationStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObservationsTableCompanion(
                id: id,
                syncStatus: syncStatus,
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
                validationStatus: validationStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required SyncStatus syncStatus,
                required DateTime createdAt,
                required DateTime updatedAt,
                required bool isDeleted,
                required String sessionId,
                required String speciesId,
                required String contactType,
                required int quantity,
                required DateTime startTime,
                required DateTime endTime,
                Value<String?> notes = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required ValidationStatus validationStatus,
                Value<int> rowid = const Value.absent(),
              }) => ObservationsTableCompanion.insert(
                id: id,
                syncStatus: syncStatus,
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
                validationStatus: validationStatus,
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
      _$AppDatabase,
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
typedef $$BirdsTableTableCreateCompanionBuilder =
    BirdsTableCompanion Function({
      required String id,
      required String scientificName,
      required String imagePath,
      required String audioPath,
      Value<String?> infoUrl,
      Value<int> rowid,
    });
typedef $$BirdsTableTableUpdateCompanionBuilder =
    BirdsTableCompanion Function({
      Value<String> id,
      Value<String> scientificName,
      Value<String> imagePath,
      Value<String> audioPath,
      Value<String?> infoUrl,
      Value<int> rowid,
    });

final class $$BirdsTableTableReferences
    extends BaseReferences<_$AppDatabase, $BirdsTableTable, BirdEntityData> {
  $$BirdsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BirdNamesTableTable, List<BirdNameEntityData>>
  _birdNamesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.birdNamesTable,
    aliasName: $_aliasNameGenerator(db.birdsTable.id, db.birdNamesTable.birdId),
  );

  $$BirdNamesTableTableProcessedTableManager get birdNamesTableRefs {
    final manager = $$BirdNamesTableTableTableManager(
      $_db,
      $_db.birdNamesTable,
    ).filter((f) => f.birdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_birdNamesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BirdsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BirdsTableTable> {
  $$BirdsTableTableFilterComposer({
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

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get infoUrl => $composableBuilder(
    column: $table.infoUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> birdNamesTableRefs(
    Expression<bool> Function($$BirdNamesTableTableFilterComposer f) f,
  ) {
    final $$BirdNamesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.birdNamesTable,
      getReferencedColumn: (t) => t.birdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BirdNamesTableTableFilterComposer(
            $db: $db,
            $table: $db.birdNamesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BirdsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BirdsTableTable> {
  $$BirdsTableTableOrderingComposer({
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

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get infoUrl => $composableBuilder(
    column: $table.infoUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BirdsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirdsTableTable> {
  $$BirdsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get infoUrl =>
      $composableBuilder(column: $table.infoUrl, builder: (column) => column);

  Expression<T> birdNamesTableRefs<T extends Object>(
    Expression<T> Function($$BirdNamesTableTableAnnotationComposer a) f,
  ) {
    final $$BirdNamesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.birdNamesTable,
      getReferencedColumn: (t) => t.birdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BirdNamesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.birdNamesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BirdsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BirdsTableTable,
          BirdEntityData,
          $$BirdsTableTableFilterComposer,
          $$BirdsTableTableOrderingComposer,
          $$BirdsTableTableAnnotationComposer,
          $$BirdsTableTableCreateCompanionBuilder,
          $$BirdsTableTableUpdateCompanionBuilder,
          (BirdEntityData, $$BirdsTableTableReferences),
          BirdEntityData,
          PrefetchHooks Function({bool birdNamesTableRefs})
        > {
  $$BirdsTableTableTableManager(_$AppDatabase db, $BirdsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BirdsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BirdsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BirdsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> scientificName = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> audioPath = const Value.absent(),
                Value<String?> infoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirdsTableCompanion(
                id: id,
                scientificName: scientificName,
                imagePath: imagePath,
                audioPath: audioPath,
                infoUrl: infoUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String scientificName,
                required String imagePath,
                required String audioPath,
                Value<String?> infoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirdsTableCompanion.insert(
                id: id,
                scientificName: scientificName,
                imagePath: imagePath,
                audioPath: audioPath,
                infoUrl: infoUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BirdsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({birdNamesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (birdNamesTableRefs) db.birdNamesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (birdNamesTableRefs)
                    await $_getPrefetchedData<
                      BirdEntityData,
                      $BirdsTableTable,
                      BirdNameEntityData
                    >(
                      currentTable: table,
                      referencedTable: $$BirdsTableTableReferences
                          ._birdNamesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BirdsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).birdNamesTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.birdId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BirdsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BirdsTableTable,
      BirdEntityData,
      $$BirdsTableTableFilterComposer,
      $$BirdsTableTableOrderingComposer,
      $$BirdsTableTableAnnotationComposer,
      $$BirdsTableTableCreateCompanionBuilder,
      $$BirdsTableTableUpdateCompanionBuilder,
      (BirdEntityData, $$BirdsTableTableReferences),
      BirdEntityData,
      PrefetchHooks Function({bool birdNamesTableRefs})
    >;
typedef $$BirdNamesTableTableCreateCompanionBuilder =
    BirdNamesTableCompanion Function({
      required String id,
      required String birdId,
      required String languageCode,
      required String commonName,
      required String description,
      Value<int> rowid,
    });
typedef $$BirdNamesTableTableUpdateCompanionBuilder =
    BirdNamesTableCompanion Function({
      Value<String> id,
      Value<String> birdId,
      Value<String> languageCode,
      Value<String> commonName,
      Value<String> description,
      Value<int> rowid,
    });

final class $$BirdNamesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BirdNamesTableTable,
          BirdNameEntityData
        > {
  $$BirdNamesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BirdsTableTable _birdIdTable(_$AppDatabase db) =>
      db.birdsTable.createAlias(
        $_aliasNameGenerator(db.birdNamesTable.birdId, db.birdsTable.id),
      );

  $$BirdsTableTableProcessedTableManager get birdId {
    final $_column = $_itemColumn<String>('bird_id')!;

    final manager = $$BirdsTableTableTableManager(
      $_db,
      $_db.birdsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_birdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BirdNamesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BirdNamesTableTable> {
  $$BirdNamesTableTableFilterComposer({
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

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$BirdsTableTableFilterComposer get birdId {
    final $$BirdsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.birdId,
      referencedTable: $db.birdsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BirdsTableTableFilterComposer(
            $db: $db,
            $table: $db.birdsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BirdNamesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BirdNamesTableTable> {
  $$BirdNamesTableTableOrderingComposer({
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

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$BirdsTableTableOrderingComposer get birdId {
    final $$BirdsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.birdId,
      referencedTable: $db.birdsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BirdsTableTableOrderingComposer(
            $db: $db,
            $table: $db.birdsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BirdNamesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirdNamesTableTable> {
  $$BirdNamesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$BirdsTableTableAnnotationComposer get birdId {
    final $$BirdsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.birdId,
      referencedTable: $db.birdsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BirdsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.birdsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BirdNamesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BirdNamesTableTable,
          BirdNameEntityData,
          $$BirdNamesTableTableFilterComposer,
          $$BirdNamesTableTableOrderingComposer,
          $$BirdNamesTableTableAnnotationComposer,
          $$BirdNamesTableTableCreateCompanionBuilder,
          $$BirdNamesTableTableUpdateCompanionBuilder,
          (BirdNameEntityData, $$BirdNamesTableTableReferences),
          BirdNameEntityData,
          PrefetchHooks Function({bool birdId})
        > {
  $$BirdNamesTableTableTableManager(
    _$AppDatabase db,
    $BirdNamesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BirdNamesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BirdNamesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BirdNamesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> birdId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> commonName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirdNamesTableCompanion(
                id: id,
                birdId: birdId,
                languageCode: languageCode,
                commonName: commonName,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String birdId,
                required String languageCode,
                required String commonName,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => BirdNamesTableCompanion.insert(
                id: id,
                birdId: birdId,
                languageCode: languageCode,
                commonName: commonName,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BirdNamesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({birdId = false}) {
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
                    if (birdId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.birdId,
                                referencedTable: $$BirdNamesTableTableReferences
                                    ._birdIdTable(db),
                                referencedColumn:
                                    $$BirdNamesTableTableReferences
                                        ._birdIdTable(db)
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

typedef $$BirdNamesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BirdNamesTableTable,
      BirdNameEntityData,
      $$BirdNamesTableTableFilterComposer,
      $$BirdNamesTableTableOrderingComposer,
      $$BirdNamesTableTableAnnotationComposer,
      $$BirdNamesTableTableCreateCompanionBuilder,
      $$BirdNamesTableTableUpdateCompanionBuilder,
      (BirdNameEntityData, $$BirdNamesTableTableReferences),
      BirdNameEntityData,
      PrefetchHooks Function({bool birdId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableTableManager get sessionsTable =>
      $$SessionsTableTableTableManager(_db, _db.sessionsTable);
  $$ObservationsTableTableTableManager get observationsTable =>
      $$ObservationsTableTableTableManager(_db, _db.observationsTable);
  $$BirdsTableTableTableManager get birdsTable =>
      $$BirdsTableTableTableManager(_db, _db.birdsTable);
  $$BirdNamesTableTableTableManager get birdNamesTable =>
      $$BirdNamesTableTableTableManager(_db, _db.birdNamesTable);
}
