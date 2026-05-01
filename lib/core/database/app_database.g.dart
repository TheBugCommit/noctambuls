// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localAudioPathMeta = const VerificationMeta(
    'localAudioPath',
  );
  @override
  late final GeneratedColumn<String> localAudioPath = GeneratedColumn<String>(
    'local_audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
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
    localImagePath,
    localAudioPath,
    imageUrl,
    audioUrl,
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
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('local_audio_path')) {
      context.handle(
        _localAudioPathMeta,
        localAudioPath.isAcceptableOrUnknown(
          data['local_audio_path']!,
          _localAudioPathMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_audioUrlMeta);
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
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      localAudioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_audio_path'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
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
  final String? localImagePath;
  final String? localAudioPath;
  final String imageUrl;
  final String audioUrl;
  final String? infoUrl;
  const BirdEntityData({
    required this.id,
    required this.scientificName,
    this.localImagePath,
    this.localAudioPath,
    required this.imageUrl,
    required this.audioUrl,
    this.infoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scientific_name'] = Variable<String>(scientificName);
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    if (!nullToAbsent || localAudioPath != null) {
      map['local_audio_path'] = Variable<String>(localAudioPath);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['audio_url'] = Variable<String>(audioUrl);
    if (!nullToAbsent || infoUrl != null) {
      map['info_url'] = Variable<String>(infoUrl);
    }
    return map;
  }

  BirdsTableCompanion toCompanion(bool nullToAbsent) {
    return BirdsTableCompanion(
      id: Value(id),
      scientificName: Value(scientificName),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      localAudioPath: localAudioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localAudioPath),
      imageUrl: Value(imageUrl),
      audioUrl: Value(audioUrl),
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
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      localAudioPath: serializer.fromJson<String?>(json['localAudioPath']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
      infoUrl: serializer.fromJson<String?>(json['infoUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scientificName': serializer.toJson<String>(scientificName),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'localAudioPath': serializer.toJson<String?>(localAudioPath),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'audioUrl': serializer.toJson<String>(audioUrl),
      'infoUrl': serializer.toJson<String?>(infoUrl),
    };
  }

  BirdEntityData copyWith({
    String? id,
    String? scientificName,
    Value<String?> localImagePath = const Value.absent(),
    Value<String?> localAudioPath = const Value.absent(),
    String? imageUrl,
    String? audioUrl,
    Value<String?> infoUrl = const Value.absent(),
  }) => BirdEntityData(
    id: id ?? this.id,
    scientificName: scientificName ?? this.scientificName,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    localAudioPath: localAudioPath.present
        ? localAudioPath.value
        : this.localAudioPath,
    imageUrl: imageUrl ?? this.imageUrl,
    audioUrl: audioUrl ?? this.audioUrl,
    infoUrl: infoUrl.present ? infoUrl.value : this.infoUrl,
  );
  BirdEntityData copyWithCompanion(BirdsTableCompanion data) {
    return BirdEntityData(
      id: data.id.present ? data.id.value : this.id,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      localAudioPath: data.localAudioPath.present
          ? data.localAudioPath.value
          : this.localAudioPath,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      infoUrl: data.infoUrl.present ? data.infoUrl.value : this.infoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BirdEntityData(')
          ..write('id: $id, ')
          ..write('scientificName: $scientificName, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('localAudioPath: $localAudioPath, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('infoUrl: $infoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scientificName,
    localImagePath,
    localAudioPath,
    imageUrl,
    audioUrl,
    infoUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BirdEntityData &&
          other.id == this.id &&
          other.scientificName == this.scientificName &&
          other.localImagePath == this.localImagePath &&
          other.localAudioPath == this.localAudioPath &&
          other.imageUrl == this.imageUrl &&
          other.audioUrl == this.audioUrl &&
          other.infoUrl == this.infoUrl);
}

class BirdsTableCompanion extends UpdateCompanion<BirdEntityData> {
  final Value<String> id;
  final Value<String> scientificName;
  final Value<String?> localImagePath;
  final Value<String?> localAudioPath;
  final Value<String> imageUrl;
  final Value<String> audioUrl;
  final Value<String?> infoUrl;
  final Value<int> rowid;
  const BirdsTableCompanion({
    this.id = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.localAudioPath = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.infoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BirdsTableCompanion.insert({
    required String id,
    required String scientificName,
    this.localImagePath = const Value.absent(),
    this.localAudioPath = const Value.absent(),
    required String imageUrl,
    required String audioUrl,
    this.infoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       scientificName = Value(scientificName),
       imageUrl = Value(imageUrl),
       audioUrl = Value(audioUrl);
  static Insertable<BirdEntityData> custom({
    Expression<String>? id,
    Expression<String>? scientificName,
    Expression<String>? localImagePath,
    Expression<String>? localAudioPath,
    Expression<String>? imageUrl,
    Expression<String>? audioUrl,
    Expression<String>? infoUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scientificName != null) 'scientific_name': scientificName,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (localAudioPath != null) 'local_audio_path': localAudioPath,
      if (imageUrl != null) 'image_url': imageUrl,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (infoUrl != null) 'info_url': infoUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BirdsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? scientificName,
    Value<String?>? localImagePath,
    Value<String?>? localAudioPath,
    Value<String>? imageUrl,
    Value<String>? audioUrl,
    Value<String?>? infoUrl,
    Value<int>? rowid,
  }) {
    return BirdsTableCompanion(
      id: id ?? this.id,
      scientificName: scientificName ?? this.scientificName,
      localImagePath: localImagePath ?? this.localImagePath,
      localAudioPath: localAudioPath ?? this.localAudioPath,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
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
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (localAudioPath.present) {
      map['local_audio_path'] = Variable<String>(localAudioPath.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
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
          ..write('localImagePath: $localImagePath, ')
          ..write('localAudioPath: $localAudioPath, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
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

class $CatalogMetadataTableTable extends CatalogMetadataTable
    with TableInfo<$CatalogMetadataTableTable, CatalogMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatalogMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catalog_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatalogMetadataData> instance, {
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
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  CatalogMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatalogMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $CatalogMetadataTableTable createAlias(String alias) {
    return $CatalogMetadataTableTable(attachedDatabase, alias);
  }
}

class CatalogMetadataData extends DataClass
    implements Insertable<CatalogMetadataData> {
  final String key;
  final String? value;
  const CatalogMetadataData({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  CatalogMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return CatalogMetadataTableCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory CatalogMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatalogMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  CatalogMetadataData copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => CatalogMetadataData(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  CatalogMetadataData copyWithCompanion(CatalogMetadataTableCompanion data) {
    return CatalogMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatalogMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatalogMetadataData &&
          other.key == this.key &&
          other.value == this.value);
}

class CatalogMetadataTableCompanion
    extends UpdateCompanion<CatalogMetadataData> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const CatalogMetadataTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatalogMetadataTableCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<CatalogMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatalogMetadataTableCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return CatalogMetadataTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatalogMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BirdsTableTable birdsTable = $BirdsTableTable(this);
  late final $BirdNamesTableTable birdNamesTable = $BirdNamesTableTable(this);
  late final $CatalogMetadataTableTable catalogMetadataTable =
      $CatalogMetadataTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    birdsTable,
    birdNamesTable,
    catalogMetadataTable,
  ];
}

typedef $$BirdsTableTableCreateCompanionBuilder =
    BirdsTableCompanion Function({
      required String id,
      required String scientificName,
      Value<String?> localImagePath,
      Value<String?> localAudioPath,
      required String imageUrl,
      required String audioUrl,
      Value<String?> infoUrl,
      Value<int> rowid,
    });
typedef $$BirdsTableTableUpdateCompanionBuilder =
    BirdsTableCompanion Function({
      Value<String> id,
      Value<String> scientificName,
      Value<String?> localImagePath,
      Value<String?> localAudioPath,
      Value<String> imageUrl,
      Value<String> audioUrl,
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

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localAudioPath => $composableBuilder(
    column: $table.localAudioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
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

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localAudioPath => $composableBuilder(
    column: $table.localAudioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
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

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localAudioPath => $composableBuilder(
    column: $table.localAudioPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

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
                Value<String?> localImagePath = const Value.absent(),
                Value<String?> localAudioPath = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
                Value<String?> infoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirdsTableCompanion(
                id: id,
                scientificName: scientificName,
                localImagePath: localImagePath,
                localAudioPath: localAudioPath,
                imageUrl: imageUrl,
                audioUrl: audioUrl,
                infoUrl: infoUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String scientificName,
                Value<String?> localImagePath = const Value.absent(),
                Value<String?> localAudioPath = const Value.absent(),
                required String imageUrl,
                required String audioUrl,
                Value<String?> infoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirdsTableCompanion.insert(
                id: id,
                scientificName: scientificName,
                localImagePath: localImagePath,
                localAudioPath: localAudioPath,
                imageUrl: imageUrl,
                audioUrl: audioUrl,
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
typedef $$CatalogMetadataTableTableCreateCompanionBuilder =
    CatalogMetadataTableCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$CatalogMetadataTableTableUpdateCompanionBuilder =
    CatalogMetadataTableCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$CatalogMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $CatalogMetadataTableTable> {
  $$CatalogMetadataTableTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CatalogMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CatalogMetadataTableTable> {
  $$CatalogMetadataTableTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CatalogMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatalogMetadataTableTable> {
  $$CatalogMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$CatalogMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatalogMetadataTableTable,
          CatalogMetadataData,
          $$CatalogMetadataTableTableFilterComposer,
          $$CatalogMetadataTableTableOrderingComposer,
          $$CatalogMetadataTableTableAnnotationComposer,
          $$CatalogMetadataTableTableCreateCompanionBuilder,
          $$CatalogMetadataTableTableUpdateCompanionBuilder,
          (
            CatalogMetadataData,
            BaseReferences<
              _$AppDatabase,
              $CatalogMetadataTableTable,
              CatalogMetadataData
            >,
          ),
          CatalogMetadataData,
          PrefetchHooks Function()
        > {
  $$CatalogMetadataTableTableTableManager(
    _$AppDatabase db,
    $CatalogMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatalogMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatalogMetadataTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CatalogMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatalogMetadataTableCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatalogMetadataTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CatalogMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatalogMetadataTableTable,
      CatalogMetadataData,
      $$CatalogMetadataTableTableFilterComposer,
      $$CatalogMetadataTableTableOrderingComposer,
      $$CatalogMetadataTableTableAnnotationComposer,
      $$CatalogMetadataTableTableCreateCompanionBuilder,
      $$CatalogMetadataTableTableUpdateCompanionBuilder,
      (
        CatalogMetadataData,
        BaseReferences<
          _$AppDatabase,
          $CatalogMetadataTableTable,
          CatalogMetadataData
        >,
      ),
      CatalogMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BirdsTableTableTableManager get birdsTable =>
      $$BirdsTableTableTableManager(_db, _db.birdsTable);
  $$BirdNamesTableTableTableManager get birdNamesTable =>
      $$BirdNamesTableTableTableManager(_db, _db.birdNamesTable);
  $$CatalogMetadataTableTableTableManager get catalogMetadataTable =>
      $$CatalogMetadataTableTableTableManager(_db, _db.catalogMetadataTable);
}
