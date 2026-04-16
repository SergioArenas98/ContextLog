// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTableTable extends ProjectsTable
    with TableInfo<$ProjectsTableTable, ProjectsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _rubiconCodeMeta = const VerificationMeta(
    'rubiconCode',
  );
  @override
  late final GeneratedColumn<String> rubiconCode = GeneratedColumn<String>(
    'rubicon_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenceNumberMeta = const VerificationMeta(
    'licenceNumber',
  );
  @override
  late final GeneratedColumn<String> licenceNumber = GeneratedColumn<String>(
    'licence_number',
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
    name,
    rubiconCode,
    licenceNumber,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectsTableData> instance, {
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
    if (data.containsKey('rubicon_code')) {
      context.handle(
        _rubiconCodeMeta,
        rubiconCode.isAcceptableOrUnknown(
          data['rubicon_code']!,
          _rubiconCodeMeta,
        ),
      );
    }
    if (data.containsKey('licence_number')) {
      context.handle(
        _licenceNumberMeta,
        licenceNumber.isAcceptableOrUnknown(
          data['licence_number']!,
          _licenceNumberMeta,
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
  ProjectsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rubiconCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rubicon_code'],
      ),
      licenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}licence_number'],
      ),
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
  $ProjectsTableTable createAlias(String alias) {
    return $ProjectsTableTable(attachedDatabase, alias);
  }
}

class ProjectsTableData extends DataClass
    implements Insertable<ProjectsTableData> {
  final String id;
  final String name;
  final String? rubiconCode;
  final String? licenceNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProjectsTableData({
    required this.id,
    required this.name,
    this.rubiconCode,
    this.licenceNumber,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || rubiconCode != null) {
      map['rubicon_code'] = Variable<String>(rubiconCode);
    }
    if (!nullToAbsent || licenceNumber != null) {
      map['licence_number'] = Variable<String>(licenceNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProjectsTableCompanion toCompanion(bool nullToAbsent) {
    return ProjectsTableCompanion(
      id: Value(id),
      name: Value(name),
      rubiconCode: rubiconCode == null && nullToAbsent
          ? const Value.absent()
          : Value(rubiconCode),
      licenceNumber: licenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(licenceNumber),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProjectsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rubiconCode: serializer.fromJson<String?>(json['rubiconCode']),
      licenceNumber: serializer.fromJson<String?>(json['licenceNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'rubiconCode': serializer.toJson<String?>(rubiconCode),
      'licenceNumber': serializer.toJson<String?>(licenceNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProjectsTableData copyWith({
    String? id,
    String? name,
    Value<String?> rubiconCode = const Value.absent(),
    Value<String?> licenceNumber = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProjectsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    rubiconCode: rubiconCode.present ? rubiconCode.value : this.rubiconCode,
    licenceNumber: licenceNumber.present
        ? licenceNumber.value
        : this.licenceNumber,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProjectsTableData copyWithCompanion(ProjectsTableCompanion data) {
    return ProjectsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rubiconCode: data.rubiconCode.present
          ? data.rubiconCode.value
          : this.rubiconCode,
      licenceNumber: data.licenceNumber.present
          ? data.licenceNumber.value
          : this.licenceNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rubiconCode: $rubiconCode, ')
          ..write('licenceNumber: $licenceNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, rubiconCode, licenceNumber, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.rubiconCode == this.rubiconCode &&
          other.licenceNumber == this.licenceNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProjectsTableCompanion extends UpdateCompanion<ProjectsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> rubiconCode;
  final Value<String?> licenceNumber;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProjectsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rubiconCode = const Value.absent(),
    this.licenceNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsTableCompanion.insert({
    required String id,
    required String name,
    this.rubiconCode = const Value.absent(),
    this.licenceNumber = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? rubiconCode,
    Expression<String>? licenceNumber,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rubiconCode != null) 'rubicon_code': rubiconCode,
      if (licenceNumber != null) 'licence_number': licenceNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? rubiconCode,
    Value<String?>? licenceNumber,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProjectsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rubiconCode: rubiconCode ?? this.rubiconCode,
      licenceNumber: licenceNumber ?? this.licenceNumber,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rubiconCode.present) {
      map['rubicon_code'] = Variable<String>(rubiconCode.value);
    }
    if (licenceNumber.present) {
      map['licence_number'] = Variable<String>(licenceNumber.value);
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
    return (StringBuffer('ProjectsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rubiconCode: $rubiconCode, ')
          ..write('licenceNumber: $licenceNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeaturesTableTable extends FeaturesTable
    with TableInfo<$FeaturesTableTable, FeaturesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeaturesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureNumberMeta = const VerificationMeta(
    'featureNumber',
  );
  @override
  late final GeneratedColumn<String> featureNumber = GeneratedColumn<String>(
    'feature_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNonArchaeologicalMeta =
      const VerificationMeta('isNonArchaeological');
  @override
  late final GeneratedColumn<bool> isNonArchaeological = GeneratedColumn<bool>(
    'is_non_archaeological',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_non_archaeological" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeatureType, String> featureType =
      GeneratedColumn<String>(
        'feature_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('standard'),
      ).withConverter<FeatureType>($FeaturesTableTable.$converterfeatureType);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    featureNumber,
    projectId,
    area,
    isNonArchaeological,
    featureType,
    date,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'features';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeaturesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_number')) {
      context.handle(
        _featureNumberMeta,
        featureNumber.isAcceptableOrUnknown(
          data['feature_number']!,
          _featureNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_featureNumberMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('is_non_archaeological')) {
      context.handle(
        _isNonArchaeologicalMeta,
        isNonArchaeological.isAcceptableOrUnknown(
          data['is_non_archaeological']!,
          _isNonArchaeologicalMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
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
  FeaturesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeaturesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_number'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      isNonArchaeological: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_non_archaeological'],
      )!,
      featureType: $FeaturesTableTable.$converterfeatureType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feature_type'],
        )!,
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
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
  $FeaturesTableTable createAlias(String alias) {
    return $FeaturesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<FeatureType, String> $converterfeatureType =
      const FeatureTypeConverter();
}

class FeaturesTableData extends DataClass
    implements Insertable<FeaturesTableData> {
  final String id;
  final String featureNumber;
  final String? projectId;
  final String? area;
  final bool isNonArchaeological;
  final FeatureType featureType;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FeaturesTableData({
    required this.id,
    required this.featureNumber,
    this.projectId,
    this.area,
    required this.isNonArchaeological,
    required this.featureType,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_number'] = Variable<String>(featureNumber);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    map['is_non_archaeological'] = Variable<bool>(isNonArchaeological);
    {
      map['feature_type'] = Variable<String>(
        $FeaturesTableTable.$converterfeatureType.toSql(featureType),
      );
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FeaturesTableCompanion toCompanion(bool nullToAbsent) {
    return FeaturesTableCompanion(
      id: Value(id),
      featureNumber: Value(featureNumber),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      isNonArchaeological: Value(isNonArchaeological),
      featureType: Value(featureType),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FeaturesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeaturesTableData(
      id: serializer.fromJson<String>(json['id']),
      featureNumber: serializer.fromJson<String>(json['featureNumber']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      area: serializer.fromJson<String?>(json['area']),
      isNonArchaeological: serializer.fromJson<bool>(
        json['isNonArchaeological'],
      ),
      featureType: serializer.fromJson<FeatureType>(json['featureType']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureNumber': serializer.toJson<String>(featureNumber),
      'projectId': serializer.toJson<String?>(projectId),
      'area': serializer.toJson<String?>(area),
      'isNonArchaeological': serializer.toJson<bool>(isNonArchaeological),
      'featureType': serializer.toJson<FeatureType>(featureType),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FeaturesTableData copyWith({
    String? id,
    String? featureNumber,
    Value<String?> projectId = const Value.absent(),
    Value<String?> area = const Value.absent(),
    bool? isNonArchaeological,
    FeatureType? featureType,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FeaturesTableData(
    id: id ?? this.id,
    featureNumber: featureNumber ?? this.featureNumber,
    projectId: projectId.present ? projectId.value : this.projectId,
    area: area.present ? area.value : this.area,
    isNonArchaeological: isNonArchaeological ?? this.isNonArchaeological,
    featureType: featureType ?? this.featureType,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FeaturesTableData copyWithCompanion(FeaturesTableCompanion data) {
    return FeaturesTableData(
      id: data.id.present ? data.id.value : this.id,
      featureNumber: data.featureNumber.present
          ? data.featureNumber.value
          : this.featureNumber,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      area: data.area.present ? data.area.value : this.area,
      isNonArchaeological: data.isNonArchaeological.present
          ? data.isNonArchaeological.value
          : this.isNonArchaeological,
      featureType: data.featureType.present
          ? data.featureType.value
          : this.featureType,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeaturesTableData(')
          ..write('id: $id, ')
          ..write('featureNumber: $featureNumber, ')
          ..write('projectId: $projectId, ')
          ..write('area: $area, ')
          ..write('isNonArchaeological: $isNonArchaeological, ')
          ..write('featureType: $featureType, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureNumber,
    projectId,
    area,
    isNonArchaeological,
    featureType,
    date,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeaturesTableData &&
          other.id == this.id &&
          other.featureNumber == this.featureNumber &&
          other.projectId == this.projectId &&
          other.area == this.area &&
          other.isNonArchaeological == this.isNonArchaeological &&
          other.featureType == this.featureType &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FeaturesTableCompanion extends UpdateCompanion<FeaturesTableData> {
  final Value<String> id;
  final Value<String> featureNumber;
  final Value<String?> projectId;
  final Value<String?> area;
  final Value<bool> isNonArchaeological;
  final Value<FeatureType> featureType;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FeaturesTableCompanion({
    this.id = const Value.absent(),
    this.featureNumber = const Value.absent(),
    this.projectId = const Value.absent(),
    this.area = const Value.absent(),
    this.isNonArchaeological = const Value.absent(),
    this.featureType = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeaturesTableCompanion.insert({
    required String id,
    required String featureNumber,
    this.projectId = const Value.absent(),
    this.area = const Value.absent(),
    this.isNonArchaeological = const Value.absent(),
    this.featureType = const Value.absent(),
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureNumber = Value(featureNumber),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FeaturesTableData> custom({
    Expression<String>? id,
    Expression<String>? featureNumber,
    Expression<String>? projectId,
    Expression<String>? area,
    Expression<bool>? isNonArchaeological,
    Expression<String>? featureType,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureNumber != null) 'feature_number': featureNumber,
      if (projectId != null) 'project_id': projectId,
      if (area != null) 'area': area,
      if (isNonArchaeological != null)
        'is_non_archaeological': isNonArchaeological,
      if (featureType != null) 'feature_type': featureType,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeaturesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureNumber,
    Value<String?>? projectId,
    Value<String?>? area,
    Value<bool>? isNonArchaeological,
    Value<FeatureType>? featureType,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FeaturesTableCompanion(
      id: id ?? this.id,
      featureNumber: featureNumber ?? this.featureNumber,
      projectId: projectId ?? this.projectId,
      area: area ?? this.area,
      isNonArchaeological: isNonArchaeological ?? this.isNonArchaeological,
      featureType: featureType ?? this.featureType,
      date: date ?? this.date,
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
    if (featureNumber.present) {
      map['feature_number'] = Variable<String>(featureNumber.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (isNonArchaeological.present) {
      map['is_non_archaeological'] = Variable<bool>(isNonArchaeological.value);
    }
    if (featureType.present) {
      map['feature_type'] = Variable<String>(
        $FeaturesTableTable.$converterfeatureType.toSql(featureType.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
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
    return (StringBuffer('FeaturesTableCompanion(')
          ..write('id: $id, ')
          ..write('featureNumber: $featureNumber, ')
          ..write('projectId: $projectId, ')
          ..write('area: $area, ')
          ..write('isNonArchaeological: $isNonArchaeological, ')
          ..write('featureType: $featureType, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotosTableTable extends PhotosTable
    with TableInfo<$PhotosTableTable, PhotosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PhotoStage, String> stage =
      GeneratedColumn<String>(
        'stage',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PhotoStage>($PhotosTableTable.$converterstage);
  static const VerificationMeta _manualCameraPhotoNumberMeta =
      const VerificationMeta('manualCameraPhotoNumber');
  @override
  late final GeneratedColumn<String> manualCameraPhotoNumber =
      GeneratedColumn<String>(
        'manual_camera_photo_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<CardinalOrientation, String>
  cardinalOrientation =
      GeneratedColumn<String>(
        'cardinal_orientation',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('unknown'),
      ).withConverter<CardinalOrientation>(
        $PhotosTableTable.$convertercardinalOrientation,
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
    featureId,
    stage,
    manualCameraPhotoNumber,
    cardinalOrientation,
    notes,
    localImagePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('manual_camera_photo_number')) {
      context.handle(
        _manualCameraPhotoNumberMeta,
        manualCameraPhotoNumber.isAcceptableOrUnknown(
          data['manual_camera_photo_number']!,
          _manualCameraPhotoNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
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
  PhotosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      stage: $PhotosTableTable.$converterstage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stage'],
        )!,
      ),
      manualCameraPhotoNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manual_camera_photo_number'],
      ),
      cardinalOrientation: $PhotosTableTable.$convertercardinalOrientation
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}cardinal_orientation'],
            )!,
          ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
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
  $PhotosTableTable createAlias(String alias) {
    return $PhotosTableTable(attachedDatabase, alias);
  }

  static TypeConverter<PhotoStage, String> $converterstage =
      const PhotoStageConverter();
  static TypeConverter<CardinalOrientation, String>
  $convertercardinalOrientation = const CardinalOrientationConverter();
}

class PhotosTableData extends DataClass implements Insertable<PhotosTableData> {
  final String id;
  final String featureId;
  final PhotoStage stage;
  final String? manualCameraPhotoNumber;
  final CardinalOrientation cardinalOrientation;
  final String? notes;
  final String? localImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PhotosTableData({
    required this.id,
    required this.featureId,
    required this.stage,
    this.manualCameraPhotoNumber,
    required this.cardinalOrientation,
    this.notes,
    this.localImagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    {
      map['stage'] = Variable<String>(
        $PhotosTableTable.$converterstage.toSql(stage),
      );
    }
    if (!nullToAbsent || manualCameraPhotoNumber != null) {
      map['manual_camera_photo_number'] = Variable<String>(
        manualCameraPhotoNumber,
      );
    }
    {
      map['cardinal_orientation'] = Variable<String>(
        $PhotosTableTable.$convertercardinalOrientation.toSql(
          cardinalOrientation,
        ),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PhotosTableCompanion toCompanion(bool nullToAbsent) {
    return PhotosTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      stage: Value(stage),
      manualCameraPhotoNumber: manualCameraPhotoNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(manualCameraPhotoNumber),
      cardinalOrientation: Value(cardinalOrientation),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PhotosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotosTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      stage: serializer.fromJson<PhotoStage>(json['stage']),
      manualCameraPhotoNumber: serializer.fromJson<String?>(
        json['manualCameraPhotoNumber'],
      ),
      cardinalOrientation: serializer.fromJson<CardinalOrientation>(
        json['cardinalOrientation'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'stage': serializer.toJson<PhotoStage>(stage),
      'manualCameraPhotoNumber': serializer.toJson<String?>(
        manualCameraPhotoNumber,
      ),
      'cardinalOrientation': serializer.toJson<CardinalOrientation>(
        cardinalOrientation,
      ),
      'notes': serializer.toJson<String?>(notes),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PhotosTableData copyWith({
    String? id,
    String? featureId,
    PhotoStage? stage,
    Value<String?> manualCameraPhotoNumber = const Value.absent(),
    CardinalOrientation? cardinalOrientation,
    Value<String?> notes = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PhotosTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    stage: stage ?? this.stage,
    manualCameraPhotoNumber: manualCameraPhotoNumber.present
        ? manualCameraPhotoNumber.value
        : this.manualCameraPhotoNumber,
    cardinalOrientation: cardinalOrientation ?? this.cardinalOrientation,
    notes: notes.present ? notes.value : this.notes,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PhotosTableData copyWithCompanion(PhotosTableCompanion data) {
    return PhotosTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      stage: data.stage.present ? data.stage.value : this.stage,
      manualCameraPhotoNumber: data.manualCameraPhotoNumber.present
          ? data.manualCameraPhotoNumber.value
          : this.manualCameraPhotoNumber,
      cardinalOrientation: data.cardinalOrientation.present
          ? data.cardinalOrientation.value
          : this.cardinalOrientation,
      notes: data.notes.present ? data.notes.value : this.notes,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotosTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('stage: $stage, ')
          ..write('manualCameraPhotoNumber: $manualCameraPhotoNumber, ')
          ..write('cardinalOrientation: $cardinalOrientation, ')
          ..write('notes: $notes, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    stage,
    manualCameraPhotoNumber,
    cardinalOrientation,
    notes,
    localImagePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotosTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.stage == this.stage &&
          other.manualCameraPhotoNumber == this.manualCameraPhotoNumber &&
          other.cardinalOrientation == this.cardinalOrientation &&
          other.notes == this.notes &&
          other.localImagePath == this.localImagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PhotosTableCompanion extends UpdateCompanion<PhotosTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<PhotoStage> stage;
  final Value<String?> manualCameraPhotoNumber;
  final Value<CardinalOrientation> cardinalOrientation;
  final Value<String?> notes;
  final Value<String?> localImagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PhotosTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.stage = const Value.absent(),
    this.manualCameraPhotoNumber = const Value.absent(),
    this.cardinalOrientation = const Value.absent(),
    this.notes = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosTableCompanion.insert({
    required String id,
    required String featureId,
    required PhotoStage stage,
    this.manualCameraPhotoNumber = const Value.absent(),
    this.cardinalOrientation = const Value.absent(),
    this.notes = const Value.absent(),
    this.localImagePath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       stage = Value(stage),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PhotosTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<String>? stage,
    Expression<String>? manualCameraPhotoNumber,
    Expression<String>? cardinalOrientation,
    Expression<String>? notes,
    Expression<String>? localImagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (stage != null) 'stage': stage,
      if (manualCameraPhotoNumber != null)
        'manual_camera_photo_number': manualCameraPhotoNumber,
      if (cardinalOrientation != null)
        'cardinal_orientation': cardinalOrientation,
      if (notes != null) 'notes': notes,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<PhotoStage>? stage,
    Value<String?>? manualCameraPhotoNumber,
    Value<CardinalOrientation>? cardinalOrientation,
    Value<String?>? notes,
    Value<String?>? localImagePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PhotosTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      stage: stage ?? this.stage,
      manualCameraPhotoNumber:
          manualCameraPhotoNumber ?? this.manualCameraPhotoNumber,
      cardinalOrientation: cardinalOrientation ?? this.cardinalOrientation,
      notes: notes ?? this.notes,
      localImagePath: localImagePath ?? this.localImagePath,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(
        $PhotosTableTable.$converterstage.toSql(stage.value),
      );
    }
    if (manualCameraPhotoNumber.present) {
      map['manual_camera_photo_number'] = Variable<String>(
        manualCameraPhotoNumber.value,
      );
    }
    if (cardinalOrientation.present) {
      map['cardinal_orientation'] = Variable<String>(
        $PhotosTableTable.$convertercardinalOrientation.toSql(
          cardinalOrientation.value,
        ),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
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
    return (StringBuffer('PhotosTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('stage: $stage, ')
          ..write('manualCameraPhotoNumber: $manualCameraPhotoNumber, ')
          ..write('cardinalOrientation: $cardinalOrientation, ')
          ..write('notes: $notes, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrawingsTableTable extends DrawingsTable
    with TableInfo<$DrawingsTableTable, DrawingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _drawingNumberMeta = const VerificationMeta(
    'drawingNumber',
  );
  @override
  late final GeneratedColumn<String> drawingNumber = GeneratedColumn<String>(
    'drawing_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardNumberMeta = const VerificationMeta(
    'boardNumber',
  );
  @override
  late final GeneratedColumn<String> boardNumber = GeneratedColumn<String>(
    'board_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DrawingType?, String>
  drawingType = GeneratedColumn<String>(
    'drawing_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<DrawingType?>($DrawingsTableTable.$converterdrawingType);
  @override
  late final GeneratedColumnWithTypeConverter<CardinalOrientation, String>
  facing = GeneratedColumn<String>(
    'facing',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  ).withConverter<CardinalOrientation>($DrawingsTableTable.$converterfacing);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceImagePathMeta =
      const VerificationMeta('referenceImagePath');
  @override
  late final GeneratedColumn<String> referenceImagePath =
      GeneratedColumn<String>(
        'reference_image_path',
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
    featureId,
    drawingNumber,
    boardNumber,
    drawingType,
    facing,
    notes,
    referenceImagePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drawings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrawingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('drawing_number')) {
      context.handle(
        _drawingNumberMeta,
        drawingNumber.isAcceptableOrUnknown(
          data['drawing_number']!,
          _drawingNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_drawingNumberMeta);
    }
    if (data.containsKey('board_number')) {
      context.handle(
        _boardNumberMeta,
        boardNumber.isAcceptableOrUnknown(
          data['board_number']!,
          _boardNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('reference_image_path')) {
      context.handle(
        _referenceImagePathMeta,
        referenceImagePath.isAcceptableOrUnknown(
          data['reference_image_path']!,
          _referenceImagePathMeta,
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
  DrawingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      drawingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drawing_number'],
      )!,
      boardNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_number'],
      ),
      drawingType: $DrawingsTableTable.$converterdrawingType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}drawing_type'],
        ),
      ),
      facing: $DrawingsTableTable.$converterfacing.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}facing'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      referenceImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_image_path'],
      ),
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
  $DrawingsTableTable createAlias(String alias) {
    return $DrawingsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DrawingType?, String?> $converterdrawingType =
      const NullableDrawingTypeConverter();
  static TypeConverter<CardinalOrientation, String> $converterfacing =
      const CardinalOrientationConverter();
}

class DrawingsTableData extends DataClass
    implements Insertable<DrawingsTableData> {
  final String id;
  final String featureId;
  final String drawingNumber;
  final String? boardNumber;
  final DrawingType? drawingType;
  final CardinalOrientation facing;
  final String? notes;
  final String? referenceImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DrawingsTableData({
    required this.id,
    required this.featureId,
    required this.drawingNumber,
    this.boardNumber,
    this.drawingType,
    required this.facing,
    this.notes,
    this.referenceImagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    map['drawing_number'] = Variable<String>(drawingNumber);
    if (!nullToAbsent || boardNumber != null) {
      map['board_number'] = Variable<String>(boardNumber);
    }
    if (!nullToAbsent || drawingType != null) {
      map['drawing_type'] = Variable<String>(
        $DrawingsTableTable.$converterdrawingType.toSql(drawingType),
      );
    }
    {
      map['facing'] = Variable<String>(
        $DrawingsTableTable.$converterfacing.toSql(facing),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || referenceImagePath != null) {
      map['reference_image_path'] = Variable<String>(referenceImagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DrawingsTableCompanion toCompanion(bool nullToAbsent) {
    return DrawingsTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      drawingNumber: Value(drawingNumber),
      boardNumber: boardNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(boardNumber),
      drawingType: drawingType == null && nullToAbsent
          ? const Value.absent()
          : Value(drawingType),
      facing: Value(facing),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      referenceImagePath: referenceImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceImagePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DrawingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawingsTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      drawingNumber: serializer.fromJson<String>(json['drawingNumber']),
      boardNumber: serializer.fromJson<String?>(json['boardNumber']),
      drawingType: serializer.fromJson<DrawingType?>(json['drawingType']),
      facing: serializer.fromJson<CardinalOrientation>(json['facing']),
      notes: serializer.fromJson<String?>(json['notes']),
      referenceImagePath: serializer.fromJson<String?>(
        json['referenceImagePath'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'drawingNumber': serializer.toJson<String>(drawingNumber),
      'boardNumber': serializer.toJson<String?>(boardNumber),
      'drawingType': serializer.toJson<DrawingType?>(drawingType),
      'facing': serializer.toJson<CardinalOrientation>(facing),
      'notes': serializer.toJson<String?>(notes),
      'referenceImagePath': serializer.toJson<String?>(referenceImagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DrawingsTableData copyWith({
    String? id,
    String? featureId,
    String? drawingNumber,
    Value<String?> boardNumber = const Value.absent(),
    Value<DrawingType?> drawingType = const Value.absent(),
    CardinalOrientation? facing,
    Value<String?> notes = const Value.absent(),
    Value<String?> referenceImagePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DrawingsTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    drawingNumber: drawingNumber ?? this.drawingNumber,
    boardNumber: boardNumber.present ? boardNumber.value : this.boardNumber,
    drawingType: drawingType.present ? drawingType.value : this.drawingType,
    facing: facing ?? this.facing,
    notes: notes.present ? notes.value : this.notes,
    referenceImagePath: referenceImagePath.present
        ? referenceImagePath.value
        : this.referenceImagePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DrawingsTableData copyWithCompanion(DrawingsTableCompanion data) {
    return DrawingsTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      drawingNumber: data.drawingNumber.present
          ? data.drawingNumber.value
          : this.drawingNumber,
      boardNumber: data.boardNumber.present
          ? data.boardNumber.value
          : this.boardNumber,
      drawingType: data.drawingType.present
          ? data.drawingType.value
          : this.drawingType,
      facing: data.facing.present ? data.facing.value : this.facing,
      notes: data.notes.present ? data.notes.value : this.notes,
      referenceImagePath: data.referenceImagePath.present
          ? data.referenceImagePath.value
          : this.referenceImagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawingsTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('drawingNumber: $drawingNumber, ')
          ..write('boardNumber: $boardNumber, ')
          ..write('drawingType: $drawingType, ')
          ..write('facing: $facing, ')
          ..write('notes: $notes, ')
          ..write('referenceImagePath: $referenceImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    drawingNumber,
    boardNumber,
    drawingType,
    facing,
    notes,
    referenceImagePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawingsTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.drawingNumber == this.drawingNumber &&
          other.boardNumber == this.boardNumber &&
          other.drawingType == this.drawingType &&
          other.facing == this.facing &&
          other.notes == this.notes &&
          other.referenceImagePath == this.referenceImagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DrawingsTableCompanion extends UpdateCompanion<DrawingsTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<String> drawingNumber;
  final Value<String?> boardNumber;
  final Value<DrawingType?> drawingType;
  final Value<CardinalOrientation> facing;
  final Value<String?> notes;
  final Value<String?> referenceImagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DrawingsTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.drawingNumber = const Value.absent(),
    this.boardNumber = const Value.absent(),
    this.drawingType = const Value.absent(),
    this.facing = const Value.absent(),
    this.notes = const Value.absent(),
    this.referenceImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawingsTableCompanion.insert({
    required String id,
    required String featureId,
    required String drawingNumber,
    this.boardNumber = const Value.absent(),
    this.drawingType = const Value.absent(),
    this.facing = const Value.absent(),
    this.notes = const Value.absent(),
    this.referenceImagePath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       drawingNumber = Value(drawingNumber),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DrawingsTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<String>? drawingNumber,
    Expression<String>? boardNumber,
    Expression<String>? drawingType,
    Expression<String>? facing,
    Expression<String>? notes,
    Expression<String>? referenceImagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (drawingNumber != null) 'drawing_number': drawingNumber,
      if (boardNumber != null) 'board_number': boardNumber,
      if (drawingType != null) 'drawing_type': drawingType,
      if (facing != null) 'facing': facing,
      if (notes != null) 'notes': notes,
      if (referenceImagePath != null)
        'reference_image_path': referenceImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<String>? drawingNumber,
    Value<String?>? boardNumber,
    Value<DrawingType?>? drawingType,
    Value<CardinalOrientation>? facing,
    Value<String?>? notes,
    Value<String?>? referenceImagePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DrawingsTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      drawingNumber: drawingNumber ?? this.drawingNumber,
      boardNumber: boardNumber ?? this.boardNumber,
      drawingType: drawingType ?? this.drawingType,
      facing: facing ?? this.facing,
      notes: notes ?? this.notes,
      referenceImagePath: referenceImagePath ?? this.referenceImagePath,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (drawingNumber.present) {
      map['drawing_number'] = Variable<String>(drawingNumber.value);
    }
    if (boardNumber.present) {
      map['board_number'] = Variable<String>(boardNumber.value);
    }
    if (drawingType.present) {
      map['drawing_type'] = Variable<String>(
        $DrawingsTableTable.$converterdrawingType.toSql(drawingType.value),
      );
    }
    if (facing.present) {
      map['facing'] = Variable<String>(
        $DrawingsTableTable.$converterfacing.toSql(facing.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (referenceImagePath.present) {
      map['reference_image_path'] = Variable<String>(referenceImagePath.value);
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
    return (StringBuffer('DrawingsTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('drawingNumber: $drawingNumber, ')
          ..write('boardNumber: $boardNumber, ')
          ..write('drawingType: $drawingType, ')
          ..write('facing: $facing, ')
          ..write('notes: $notes, ')
          ..write('referenceImagePath: $referenceImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContextsTableTable extends ContextsTable
    with TableInfo<$ContextsTableTable, ContextsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContextsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contextNumberMeta = const VerificationMeta(
    'contextNumber',
  );
  @override
  late final GeneratedColumn<int> contextNumber = GeneratedColumn<int>(
    'context_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContextType, String> contextType =
      GeneratedColumn<String>(
        'context_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ContextType>($ContextsTableTable.$convertercontextType);
  @override
  late final GeneratedColumnWithTypeConverter<CutType?, String> cutType =
      GeneratedColumn<String>(
        'cut_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<CutType?>($ContextsTableTable.$convertercutTypen);
  static const VerificationMeta _customCutTypeTextMeta = const VerificationMeta(
    'customCutTypeText',
  );
  @override
  late final GeneratedColumn<String> customCutTypeText =
      GeneratedColumn<String>(
        'custom_cut_type_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<double> depth = GeneratedColumn<double>(
    'depth',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentCutIdMeta = const VerificationMeta(
    'parentCutId',
  );
  @override
  late final GeneratedColumn<String> parentCutId = GeneratedColumn<String>(
    'parent_cut_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FillComposition?, String>
  composition = GeneratedColumn<String>(
    'composition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<FillComposition?>($ContextsTableTable.$convertercomposition);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FillCompaction?, String>
  compaction = GeneratedColumn<String>(
    'compaction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<FillCompaction?>($ContextsTableTable.$convertercompaction);
  static const VerificationMeta _inclusionsMeta = const VerificationMeta(
    'inclusions',
  );
  @override
  late final GeneratedColumn<String> inclusions = GeneratedColumn<String>(
    'inclusions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    featureId,
    contextNumber,
    contextType,
    cutType,
    customCutTypeText,
    height,
    width,
    depth,
    parentCutId,
    composition,
    color,
    compaction,
    inclusions,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contexts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContextsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('context_number')) {
      context.handle(
        _contextNumberMeta,
        contextNumber.isAcceptableOrUnknown(
          data['context_number']!,
          _contextNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contextNumberMeta);
    }
    if (data.containsKey('custom_cut_type_text')) {
      context.handle(
        _customCutTypeTextMeta,
        customCutTypeText.isAcceptableOrUnknown(
          data['custom_cut_type_text']!,
          _customCutTypeTextMeta,
        ),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    }
    if (data.containsKey('parent_cut_id')) {
      context.handle(
        _parentCutIdMeta,
        parentCutId.isAcceptableOrUnknown(
          data['parent_cut_id']!,
          _parentCutIdMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('inclusions')) {
      context.handle(
        _inclusionsMeta,
        inclusions.isAcceptableOrUnknown(data['inclusions']!, _inclusionsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  ContextsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContextsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      contextNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}context_number'],
      )!,
      contextType: $ContextsTableTable.$convertercontextType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}context_type'],
        )!,
      ),
      cutType: $ContextsTableTable.$convertercutTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cut_type'],
        ),
      ),
      customCutTypeText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_cut_type_text'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      ),
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}depth'],
      ),
      parentCutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_cut_id'],
      ),
      composition: $ContextsTableTable.$convertercomposition.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}composition'],
        ),
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      compaction: $ContextsTableTable.$convertercompaction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}compaction'],
        ),
      ),
      inclusions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inclusions'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $ContextsTableTable createAlias(String alias) {
    return $ContextsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ContextType, String> $convertercontextType =
      const ContextTypeConverter();
  static TypeConverter<CutType, String> $convertercutType =
      const CutTypeConverter();
  static TypeConverter<CutType?, String?> $convertercutTypen =
      NullAwareTypeConverter.wrap($convertercutType);
  static TypeConverter<FillComposition?, String?> $convertercomposition =
      const NullableFillCompositionConverter();
  static TypeConverter<FillCompaction?, String?> $convertercompaction =
      const NullableFillCompactionConverter();
}

class ContextsTableData extends DataClass
    implements Insertable<ContextsTableData> {
  final String id;
  final String featureId;
  final int contextNumber;
  final ContextType contextType;
  final CutType? cutType;
  final String? customCutTypeText;
  final double? height;
  final double? width;
  final double? depth;
  final String? parentCutId;
  final FillComposition? composition;
  final String? color;
  final FillCompaction? compaction;
  final String? inclusions;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ContextsTableData({
    required this.id,
    required this.featureId,
    required this.contextNumber,
    required this.contextType,
    this.cutType,
    this.customCutTypeText,
    this.height,
    this.width,
    this.depth,
    this.parentCutId,
    this.composition,
    this.color,
    this.compaction,
    this.inclusions,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    map['context_number'] = Variable<int>(contextNumber);
    {
      map['context_type'] = Variable<String>(
        $ContextsTableTable.$convertercontextType.toSql(contextType),
      );
    }
    if (!nullToAbsent || cutType != null) {
      map['cut_type'] = Variable<String>(
        $ContextsTableTable.$convertercutTypen.toSql(cutType),
      );
    }
    if (!nullToAbsent || customCutTypeText != null) {
      map['custom_cut_type_text'] = Variable<String>(customCutTypeText);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<double>(width);
    }
    if (!nullToAbsent || depth != null) {
      map['depth'] = Variable<double>(depth);
    }
    if (!nullToAbsent || parentCutId != null) {
      map['parent_cut_id'] = Variable<String>(parentCutId);
    }
    if (!nullToAbsent || composition != null) {
      map['composition'] = Variable<String>(
        $ContextsTableTable.$convertercomposition.toSql(composition),
      );
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || compaction != null) {
      map['compaction'] = Variable<String>(
        $ContextsTableTable.$convertercompaction.toSql(compaction),
      );
    }
    if (!nullToAbsent || inclusions != null) {
      map['inclusions'] = Variable<String>(inclusions);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ContextsTableCompanion toCompanion(bool nullToAbsent) {
    return ContextsTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      contextNumber: Value(contextNumber),
      contextType: Value(contextType),
      cutType: cutType == null && nullToAbsent
          ? const Value.absent()
          : Value(cutType),
      customCutTypeText: customCutTypeText == null && nullToAbsent
          ? const Value.absent()
          : Value(customCutTypeText),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      depth: depth == null && nullToAbsent
          ? const Value.absent()
          : Value(depth),
      parentCutId: parentCutId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCutId),
      composition: composition == null && nullToAbsent
          ? const Value.absent()
          : Value(composition),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      compaction: compaction == null && nullToAbsent
          ? const Value.absent()
          : Value(compaction),
      inclusions: inclusions == null && nullToAbsent
          ? const Value.absent()
          : Value(inclusions),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ContextsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContextsTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      contextNumber: serializer.fromJson<int>(json['contextNumber']),
      contextType: serializer.fromJson<ContextType>(json['contextType']),
      cutType: serializer.fromJson<CutType?>(json['cutType']),
      customCutTypeText: serializer.fromJson<String?>(
        json['customCutTypeText'],
      ),
      height: serializer.fromJson<double?>(json['height']),
      width: serializer.fromJson<double?>(json['width']),
      depth: serializer.fromJson<double?>(json['depth']),
      parentCutId: serializer.fromJson<String?>(json['parentCutId']),
      composition: serializer.fromJson<FillComposition?>(json['composition']),
      color: serializer.fromJson<String?>(json['color']),
      compaction: serializer.fromJson<FillCompaction?>(json['compaction']),
      inclusions: serializer.fromJson<String?>(json['inclusions']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'contextNumber': serializer.toJson<int>(contextNumber),
      'contextType': serializer.toJson<ContextType>(contextType),
      'cutType': serializer.toJson<CutType?>(cutType),
      'customCutTypeText': serializer.toJson<String?>(customCutTypeText),
      'height': serializer.toJson<double?>(height),
      'width': serializer.toJson<double?>(width),
      'depth': serializer.toJson<double?>(depth),
      'parentCutId': serializer.toJson<String?>(parentCutId),
      'composition': serializer.toJson<FillComposition?>(composition),
      'color': serializer.toJson<String?>(color),
      'compaction': serializer.toJson<FillCompaction?>(compaction),
      'inclusions': serializer.toJson<String?>(inclusions),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ContextsTableData copyWith({
    String? id,
    String? featureId,
    int? contextNumber,
    ContextType? contextType,
    Value<CutType?> cutType = const Value.absent(),
    Value<String?> customCutTypeText = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> width = const Value.absent(),
    Value<double?> depth = const Value.absent(),
    Value<String?> parentCutId = const Value.absent(),
    Value<FillComposition?> composition = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<FillCompaction?> compaction = const Value.absent(),
    Value<String?> inclusions = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ContextsTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    contextNumber: contextNumber ?? this.contextNumber,
    contextType: contextType ?? this.contextType,
    cutType: cutType.present ? cutType.value : this.cutType,
    customCutTypeText: customCutTypeText.present
        ? customCutTypeText.value
        : this.customCutTypeText,
    height: height.present ? height.value : this.height,
    width: width.present ? width.value : this.width,
    depth: depth.present ? depth.value : this.depth,
    parentCutId: parentCutId.present ? parentCutId.value : this.parentCutId,
    composition: composition.present ? composition.value : this.composition,
    color: color.present ? color.value : this.color,
    compaction: compaction.present ? compaction.value : this.compaction,
    inclusions: inclusions.present ? inclusions.value : this.inclusions,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ContextsTableData copyWithCompanion(ContextsTableCompanion data) {
    return ContextsTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      contextNumber: data.contextNumber.present
          ? data.contextNumber.value
          : this.contextNumber,
      contextType: data.contextType.present
          ? data.contextType.value
          : this.contextType,
      cutType: data.cutType.present ? data.cutType.value : this.cutType,
      customCutTypeText: data.customCutTypeText.present
          ? data.customCutTypeText.value
          : this.customCutTypeText,
      height: data.height.present ? data.height.value : this.height,
      width: data.width.present ? data.width.value : this.width,
      depth: data.depth.present ? data.depth.value : this.depth,
      parentCutId: data.parentCutId.present
          ? data.parentCutId.value
          : this.parentCutId,
      composition: data.composition.present
          ? data.composition.value
          : this.composition,
      color: data.color.present ? data.color.value : this.color,
      compaction: data.compaction.present
          ? data.compaction.value
          : this.compaction,
      inclusions: data.inclusions.present
          ? data.inclusions.value
          : this.inclusions,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContextsTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('contextNumber: $contextNumber, ')
          ..write('contextType: $contextType, ')
          ..write('cutType: $cutType, ')
          ..write('customCutTypeText: $customCutTypeText, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('depth: $depth, ')
          ..write('parentCutId: $parentCutId, ')
          ..write('composition: $composition, ')
          ..write('color: $color, ')
          ..write('compaction: $compaction, ')
          ..write('inclusions: $inclusions, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    contextNumber,
    contextType,
    cutType,
    customCutTypeText,
    height,
    width,
    depth,
    parentCutId,
    composition,
    color,
    compaction,
    inclusions,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContextsTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.contextNumber == this.contextNumber &&
          other.contextType == this.contextType &&
          other.cutType == this.cutType &&
          other.customCutTypeText == this.customCutTypeText &&
          other.height == this.height &&
          other.width == this.width &&
          other.depth == this.depth &&
          other.parentCutId == this.parentCutId &&
          other.composition == this.composition &&
          other.color == this.color &&
          other.compaction == this.compaction &&
          other.inclusions == this.inclusions &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ContextsTableCompanion extends UpdateCompanion<ContextsTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<int> contextNumber;
  final Value<ContextType> contextType;
  final Value<CutType?> cutType;
  final Value<String?> customCutTypeText;
  final Value<double?> height;
  final Value<double?> width;
  final Value<double?> depth;
  final Value<String?> parentCutId;
  final Value<FillComposition?> composition;
  final Value<String?> color;
  final Value<FillCompaction?> compaction;
  final Value<String?> inclusions;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ContextsTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.contextNumber = const Value.absent(),
    this.contextType = const Value.absent(),
    this.cutType = const Value.absent(),
    this.customCutTypeText = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.depth = const Value.absent(),
    this.parentCutId = const Value.absent(),
    this.composition = const Value.absent(),
    this.color = const Value.absent(),
    this.compaction = const Value.absent(),
    this.inclusions = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContextsTableCompanion.insert({
    required String id,
    required String featureId,
    required int contextNumber,
    required ContextType contextType,
    this.cutType = const Value.absent(),
    this.customCutTypeText = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.depth = const Value.absent(),
    this.parentCutId = const Value.absent(),
    this.composition = const Value.absent(),
    this.color = const Value.absent(),
    this.compaction = const Value.absent(),
    this.inclusions = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       contextNumber = Value(contextNumber),
       contextType = Value(contextType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ContextsTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<int>? contextNumber,
    Expression<String>? contextType,
    Expression<String>? cutType,
    Expression<String>? customCutTypeText,
    Expression<double>? height,
    Expression<double>? width,
    Expression<double>? depth,
    Expression<String>? parentCutId,
    Expression<String>? composition,
    Expression<String>? color,
    Expression<String>? compaction,
    Expression<String>? inclusions,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (contextNumber != null) 'context_number': contextNumber,
      if (contextType != null) 'context_type': contextType,
      if (cutType != null) 'cut_type': cutType,
      if (customCutTypeText != null) 'custom_cut_type_text': customCutTypeText,
      if (height != null) 'height': height,
      if (width != null) 'width': width,
      if (depth != null) 'depth': depth,
      if (parentCutId != null) 'parent_cut_id': parentCutId,
      if (composition != null) 'composition': composition,
      if (color != null) 'color': color,
      if (compaction != null) 'compaction': compaction,
      if (inclusions != null) 'inclusions': inclusions,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContextsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<int>? contextNumber,
    Value<ContextType>? contextType,
    Value<CutType?>? cutType,
    Value<String?>? customCutTypeText,
    Value<double?>? height,
    Value<double?>? width,
    Value<double?>? depth,
    Value<String?>? parentCutId,
    Value<FillComposition?>? composition,
    Value<String?>? color,
    Value<FillCompaction?>? compaction,
    Value<String?>? inclusions,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ContextsTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      contextNumber: contextNumber ?? this.contextNumber,
      contextType: contextType ?? this.contextType,
      cutType: cutType ?? this.cutType,
      customCutTypeText: customCutTypeText ?? this.customCutTypeText,
      height: height ?? this.height,
      width: width ?? this.width,
      depth: depth ?? this.depth,
      parentCutId: parentCutId ?? this.parentCutId,
      composition: composition ?? this.composition,
      color: color ?? this.color,
      compaction: compaction ?? this.compaction,
      inclusions: inclusions ?? this.inclusions,
      notes: notes ?? this.notes,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (contextNumber.present) {
      map['context_number'] = Variable<int>(contextNumber.value);
    }
    if (contextType.present) {
      map['context_type'] = Variable<String>(
        $ContextsTableTable.$convertercontextType.toSql(contextType.value),
      );
    }
    if (cutType.present) {
      map['cut_type'] = Variable<String>(
        $ContextsTableTable.$convertercutTypen.toSql(cutType.value),
      );
    }
    if (customCutTypeText.present) {
      map['custom_cut_type_text'] = Variable<String>(customCutTypeText.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (depth.present) {
      map['depth'] = Variable<double>(depth.value);
    }
    if (parentCutId.present) {
      map['parent_cut_id'] = Variable<String>(parentCutId.value);
    }
    if (composition.present) {
      map['composition'] = Variable<String>(
        $ContextsTableTable.$convertercomposition.toSql(composition.value),
      );
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (compaction.present) {
      map['compaction'] = Variable<String>(
        $ContextsTableTable.$convertercompaction.toSql(compaction.value),
      );
    }
    if (inclusions.present) {
      map['inclusions'] = Variable<String>(inclusions.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('ContextsTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('contextNumber: $contextNumber, ')
          ..write('contextType: $contextType, ')
          ..write('cutType: $cutType, ')
          ..write('customCutTypeText: $customCutTypeText, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('depth: $depth, ')
          ..write('parentCutId: $parentCutId, ')
          ..write('composition: $composition, ')
          ..write('color: $color, ')
          ..write('compaction: $compaction, ')
          ..write('inclusions: $inclusions, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FindsTableTable extends FindsTable
    with TableInfo<$FindsTableTable, FindsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FindsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fillIdMeta = const VerificationMeta('fillId');
  @override
  late final GeneratedColumn<String> fillId = GeneratedColumn<String>(
    'fill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contexts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _findNumberMeta = const VerificationMeta(
    'findNumber',
  );
  @override
  late final GeneratedColumn<int> findNumber = GeneratedColumn<int>(
    'find_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FindMaterialType, String>
  materialType = GeneratedColumn<String>(
    'material_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<FindMaterialType>($FindsTableTable.$convertermaterialType);
  static const VerificationMeta _customMaterialTextMeta =
      const VerificationMeta('customMaterialText');
  @override
  late final GeneratedColumn<String> customMaterialText =
      GeneratedColumn<String>(
        'custom_material_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    featureId,
    fillId,
    findNumber,
    materialType,
    customMaterialText,
    quantity,
    description,
    localImagePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finds';
  @override
  VerificationContext validateIntegrity(
    Insertable<FindsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('fill_id')) {
      context.handle(
        _fillIdMeta,
        fillId.isAcceptableOrUnknown(data['fill_id']!, _fillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fillIdMeta);
    }
    if (data.containsKey('find_number')) {
      context.handle(
        _findNumberMeta,
        findNumber.isAcceptableOrUnknown(data['find_number']!, _findNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_findNumberMeta);
    }
    if (data.containsKey('custom_material_text')) {
      context.handle(
        _customMaterialTextMeta,
        customMaterialText.isAcceptableOrUnknown(
          data['custom_material_text']!,
          _customMaterialTextMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
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
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
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
  FindsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FindsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      fillId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fill_id'],
      )!,
      findNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}find_number'],
      )!,
      materialType: $FindsTableTable.$convertermaterialType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}material_type'],
        )!,
      ),
      customMaterialText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_material_text'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
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
  $FindsTableTable createAlias(String alias) {
    return $FindsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<FindMaterialType, String> $convertermaterialType =
      const FindMaterialTypeConverter();
}

class FindsTableData extends DataClass implements Insertable<FindsTableData> {
  final String id;
  final String featureId;
  final String fillId;
  final int findNumber;
  final FindMaterialType materialType;
  final String? customMaterialText;
  final int quantity;
  final String? description;
  final String? localImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FindsTableData({
    required this.id,
    required this.featureId,
    required this.fillId,
    required this.findNumber,
    required this.materialType,
    this.customMaterialText,
    required this.quantity,
    this.description,
    this.localImagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    map['fill_id'] = Variable<String>(fillId);
    map['find_number'] = Variable<int>(findNumber);
    {
      map['material_type'] = Variable<String>(
        $FindsTableTable.$convertermaterialType.toSql(materialType),
      );
    }
    if (!nullToAbsent || customMaterialText != null) {
      map['custom_material_text'] = Variable<String>(customMaterialText);
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FindsTableCompanion toCompanion(bool nullToAbsent) {
    return FindsTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      fillId: Value(fillId),
      findNumber: Value(findNumber),
      materialType: Value(materialType),
      customMaterialText: customMaterialText == null && nullToAbsent
          ? const Value.absent()
          : Value(customMaterialText),
      quantity: Value(quantity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FindsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FindsTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      fillId: serializer.fromJson<String>(json['fillId']),
      findNumber: serializer.fromJson<int>(json['findNumber']),
      materialType: serializer.fromJson<FindMaterialType>(json['materialType']),
      customMaterialText: serializer.fromJson<String?>(
        json['customMaterialText'],
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
      description: serializer.fromJson<String?>(json['description']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'fillId': serializer.toJson<String>(fillId),
      'findNumber': serializer.toJson<int>(findNumber),
      'materialType': serializer.toJson<FindMaterialType>(materialType),
      'customMaterialText': serializer.toJson<String?>(customMaterialText),
      'quantity': serializer.toJson<int>(quantity),
      'description': serializer.toJson<String?>(description),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FindsTableData copyWith({
    String? id,
    String? featureId,
    String? fillId,
    int? findNumber,
    FindMaterialType? materialType,
    Value<String?> customMaterialText = const Value.absent(),
    int? quantity,
    Value<String?> description = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FindsTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    fillId: fillId ?? this.fillId,
    findNumber: findNumber ?? this.findNumber,
    materialType: materialType ?? this.materialType,
    customMaterialText: customMaterialText.present
        ? customMaterialText.value
        : this.customMaterialText,
    quantity: quantity ?? this.quantity,
    description: description.present ? description.value : this.description,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FindsTableData copyWithCompanion(FindsTableCompanion data) {
    return FindsTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      fillId: data.fillId.present ? data.fillId.value : this.fillId,
      findNumber: data.findNumber.present
          ? data.findNumber.value
          : this.findNumber,
      materialType: data.materialType.present
          ? data.materialType.value
          : this.materialType,
      customMaterialText: data.customMaterialText.present
          ? data.customMaterialText.value
          : this.customMaterialText,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      description: data.description.present
          ? data.description.value
          : this.description,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FindsTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fillId: $fillId, ')
          ..write('findNumber: $findNumber, ')
          ..write('materialType: $materialType, ')
          ..write('customMaterialText: $customMaterialText, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    fillId,
    findNumber,
    materialType,
    customMaterialText,
    quantity,
    description,
    localImagePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FindsTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.fillId == this.fillId &&
          other.findNumber == this.findNumber &&
          other.materialType == this.materialType &&
          other.customMaterialText == this.customMaterialText &&
          other.quantity == this.quantity &&
          other.description == this.description &&
          other.localImagePath == this.localImagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FindsTableCompanion extends UpdateCompanion<FindsTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<String> fillId;
  final Value<int> findNumber;
  final Value<FindMaterialType> materialType;
  final Value<String?> customMaterialText;
  final Value<int> quantity;
  final Value<String?> description;
  final Value<String?> localImagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FindsTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.fillId = const Value.absent(),
    this.findNumber = const Value.absent(),
    this.materialType = const Value.absent(),
    this.customMaterialText = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FindsTableCompanion.insert({
    required String id,
    required String featureId,
    required String fillId,
    required int findNumber,
    required FindMaterialType materialType,
    this.customMaterialText = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.localImagePath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       fillId = Value(fillId),
       findNumber = Value(findNumber),
       materialType = Value(materialType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FindsTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<String>? fillId,
    Expression<int>? findNumber,
    Expression<String>? materialType,
    Expression<String>? customMaterialText,
    Expression<int>? quantity,
    Expression<String>? description,
    Expression<String>? localImagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (fillId != null) 'fill_id': fillId,
      if (findNumber != null) 'find_number': findNumber,
      if (materialType != null) 'material_type': materialType,
      if (customMaterialText != null)
        'custom_material_text': customMaterialText,
      if (quantity != null) 'quantity': quantity,
      if (description != null) 'description': description,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FindsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<String>? fillId,
    Value<int>? findNumber,
    Value<FindMaterialType>? materialType,
    Value<String?>? customMaterialText,
    Value<int>? quantity,
    Value<String?>? description,
    Value<String?>? localImagePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FindsTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      fillId: fillId ?? this.fillId,
      findNumber: findNumber ?? this.findNumber,
      materialType: materialType ?? this.materialType,
      customMaterialText: customMaterialText ?? this.customMaterialText,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      localImagePath: localImagePath ?? this.localImagePath,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (fillId.present) {
      map['fill_id'] = Variable<String>(fillId.value);
    }
    if (findNumber.present) {
      map['find_number'] = Variable<int>(findNumber.value);
    }
    if (materialType.present) {
      map['material_type'] = Variable<String>(
        $FindsTableTable.$convertermaterialType.toSql(materialType.value),
      );
    }
    if (customMaterialText.present) {
      map['custom_material_text'] = Variable<String>(customMaterialText.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
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
    return (StringBuffer('FindsTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fillId: $fillId, ')
          ..write('findNumber: $findNumber, ')
          ..write('materialType: $materialType, ')
          ..write('customMaterialText: $customMaterialText, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SamplesTableTable extends SamplesTable
    with TableInfo<$SamplesTableTable, SamplesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SamplesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fillIdMeta = const VerificationMeta('fillId');
  @override
  late final GeneratedColumn<String> fillId = GeneratedColumn<String>(
    'fill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contexts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cutIdMeta = const VerificationMeta('cutId');
  @override
  late final GeneratedColumn<String> cutId = GeneratedColumn<String>(
    'cut_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sampleNumberMeta = const VerificationMeta(
    'sampleNumber',
  );
  @override
  late final GeneratedColumn<int> sampleNumber = GeneratedColumn<int>(
    'sample_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SampleType, String> sampleType =
      GeneratedColumn<String>(
        'sample_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SampleType>($SamplesTableTable.$convertersampleType);
  static const VerificationMeta _customSampleTypeTextMeta =
      const VerificationMeta('customSampleTypeText');
  @override
  late final GeneratedColumn<String> customSampleTypeText =
      GeneratedColumn<String>(
        'custom_sample_type_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<StorageType, String> storageType =
      GeneratedColumn<String>(
        'storage_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<StorageType>($SamplesTableTable.$converterstorageType);
  static const VerificationMeta _storageCountMeta = const VerificationMeta(
    'storageCount',
  );
  @override
  late final GeneratedColumn<int> storageCount = GeneratedColumn<int>(
    'storage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    featureId,
    fillId,
    cutId,
    sampleNumber,
    sampleType,
    customSampleTypeText,
    storageType,
    storageCount,
    liters,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'samples';
  @override
  VerificationContext validateIntegrity(
    Insertable<SamplesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('fill_id')) {
      context.handle(
        _fillIdMeta,
        fillId.isAcceptableOrUnknown(data['fill_id']!, _fillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fillIdMeta);
    }
    if (data.containsKey('cut_id')) {
      context.handle(
        _cutIdMeta,
        cutId.isAcceptableOrUnknown(data['cut_id']!, _cutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cutIdMeta);
    }
    if (data.containsKey('sample_number')) {
      context.handle(
        _sampleNumberMeta,
        sampleNumber.isAcceptableOrUnknown(
          data['sample_number']!,
          _sampleNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sampleNumberMeta);
    }
    if (data.containsKey('custom_sample_type_text')) {
      context.handle(
        _customSampleTypeTextMeta,
        customSampleTypeText.isAcceptableOrUnknown(
          data['custom_sample_type_text']!,
          _customSampleTypeTextMeta,
        ),
      );
    }
    if (data.containsKey('storage_count')) {
      context.handle(
        _storageCountMeta,
        storageCount.isAcceptableOrUnknown(
          data['storage_count']!,
          _storageCountMeta,
        ),
      );
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
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
  SamplesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SamplesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      fillId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fill_id'],
      )!,
      cutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cut_id'],
      )!,
      sampleNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_number'],
      )!,
      sampleType: $SamplesTableTable.$convertersampleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sample_type'],
        )!,
      ),
      customSampleTypeText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_sample_type_text'],
      ),
      storageType: $SamplesTableTable.$converterstorageType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}storage_type'],
        )!,
      ),
      storageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}storage_count'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      ),
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
  $SamplesTableTable createAlias(String alias) {
    return $SamplesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<SampleType, String> $convertersampleType =
      const SampleTypeConverter();
  static TypeConverter<StorageType, String> $converterstorageType =
      const StorageTypeConverter();
}

class SamplesTableData extends DataClass
    implements Insertable<SamplesTableData> {
  final String id;
  final String featureId;
  final String fillId;
  final String cutId;
  final int sampleNumber;
  final SampleType sampleType;
  final String? customSampleTypeText;
  final StorageType storageType;
  final int storageCount;
  final double? liters;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SamplesTableData({
    required this.id,
    required this.featureId,
    required this.fillId,
    required this.cutId,
    required this.sampleNumber,
    required this.sampleType,
    this.customSampleTypeText,
    required this.storageType,
    required this.storageCount,
    this.liters,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    map['fill_id'] = Variable<String>(fillId);
    map['cut_id'] = Variable<String>(cutId);
    map['sample_number'] = Variable<int>(sampleNumber);
    {
      map['sample_type'] = Variable<String>(
        $SamplesTableTable.$convertersampleType.toSql(sampleType),
      );
    }
    if (!nullToAbsent || customSampleTypeText != null) {
      map['custom_sample_type_text'] = Variable<String>(customSampleTypeText);
    }
    {
      map['storage_type'] = Variable<String>(
        $SamplesTableTable.$converterstorageType.toSql(storageType),
      );
    }
    map['storage_count'] = Variable<int>(storageCount);
    if (!nullToAbsent || liters != null) {
      map['liters'] = Variable<double>(liters);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SamplesTableCompanion toCompanion(bool nullToAbsent) {
    return SamplesTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      fillId: Value(fillId),
      cutId: Value(cutId),
      sampleNumber: Value(sampleNumber),
      sampleType: Value(sampleType),
      customSampleTypeText: customSampleTypeText == null && nullToAbsent
          ? const Value.absent()
          : Value(customSampleTypeText),
      storageType: Value(storageType),
      storageCount: Value(storageCount),
      liters: liters == null && nullToAbsent
          ? const Value.absent()
          : Value(liters),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SamplesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SamplesTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      fillId: serializer.fromJson<String>(json['fillId']),
      cutId: serializer.fromJson<String>(json['cutId']),
      sampleNumber: serializer.fromJson<int>(json['sampleNumber']),
      sampleType: serializer.fromJson<SampleType>(json['sampleType']),
      customSampleTypeText: serializer.fromJson<String?>(
        json['customSampleTypeText'],
      ),
      storageType: serializer.fromJson<StorageType>(json['storageType']),
      storageCount: serializer.fromJson<int>(json['storageCount']),
      liters: serializer.fromJson<double?>(json['liters']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'fillId': serializer.toJson<String>(fillId),
      'cutId': serializer.toJson<String>(cutId),
      'sampleNumber': serializer.toJson<int>(sampleNumber),
      'sampleType': serializer.toJson<SampleType>(sampleType),
      'customSampleTypeText': serializer.toJson<String?>(customSampleTypeText),
      'storageType': serializer.toJson<StorageType>(storageType),
      'storageCount': serializer.toJson<int>(storageCount),
      'liters': serializer.toJson<double?>(liters),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SamplesTableData copyWith({
    String? id,
    String? featureId,
    String? fillId,
    String? cutId,
    int? sampleNumber,
    SampleType? sampleType,
    Value<String?> customSampleTypeText = const Value.absent(),
    StorageType? storageType,
    int? storageCount,
    Value<double?> liters = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SamplesTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    fillId: fillId ?? this.fillId,
    cutId: cutId ?? this.cutId,
    sampleNumber: sampleNumber ?? this.sampleNumber,
    sampleType: sampleType ?? this.sampleType,
    customSampleTypeText: customSampleTypeText.present
        ? customSampleTypeText.value
        : this.customSampleTypeText,
    storageType: storageType ?? this.storageType,
    storageCount: storageCount ?? this.storageCount,
    liters: liters.present ? liters.value : this.liters,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SamplesTableData copyWithCompanion(SamplesTableCompanion data) {
    return SamplesTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      fillId: data.fillId.present ? data.fillId.value : this.fillId,
      cutId: data.cutId.present ? data.cutId.value : this.cutId,
      sampleNumber: data.sampleNumber.present
          ? data.sampleNumber.value
          : this.sampleNumber,
      sampleType: data.sampleType.present
          ? data.sampleType.value
          : this.sampleType,
      customSampleTypeText: data.customSampleTypeText.present
          ? data.customSampleTypeText.value
          : this.customSampleTypeText,
      storageType: data.storageType.present
          ? data.storageType.value
          : this.storageType,
      storageCount: data.storageCount.present
          ? data.storageCount.value
          : this.storageCount,
      liters: data.liters.present ? data.liters.value : this.liters,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SamplesTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fillId: $fillId, ')
          ..write('cutId: $cutId, ')
          ..write('sampleNumber: $sampleNumber, ')
          ..write('sampleType: $sampleType, ')
          ..write('customSampleTypeText: $customSampleTypeText, ')
          ..write('storageType: $storageType, ')
          ..write('storageCount: $storageCount, ')
          ..write('liters: $liters, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    fillId,
    cutId,
    sampleNumber,
    sampleType,
    customSampleTypeText,
    storageType,
    storageCount,
    liters,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SamplesTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.fillId == this.fillId &&
          other.cutId == this.cutId &&
          other.sampleNumber == this.sampleNumber &&
          other.sampleType == this.sampleType &&
          other.customSampleTypeText == this.customSampleTypeText &&
          other.storageType == this.storageType &&
          other.storageCount == this.storageCount &&
          other.liters == this.liters &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SamplesTableCompanion extends UpdateCompanion<SamplesTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<String> fillId;
  final Value<String> cutId;
  final Value<int> sampleNumber;
  final Value<SampleType> sampleType;
  final Value<String?> customSampleTypeText;
  final Value<StorageType> storageType;
  final Value<int> storageCount;
  final Value<double?> liters;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SamplesTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.fillId = const Value.absent(),
    this.cutId = const Value.absent(),
    this.sampleNumber = const Value.absent(),
    this.sampleType = const Value.absent(),
    this.customSampleTypeText = const Value.absent(),
    this.storageType = const Value.absent(),
    this.storageCount = const Value.absent(),
    this.liters = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SamplesTableCompanion.insert({
    required String id,
    required String featureId,
    required String fillId,
    required String cutId,
    required int sampleNumber,
    required SampleType sampleType,
    this.customSampleTypeText = const Value.absent(),
    required StorageType storageType,
    this.storageCount = const Value.absent(),
    this.liters = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       fillId = Value(fillId),
       cutId = Value(cutId),
       sampleNumber = Value(sampleNumber),
       sampleType = Value(sampleType),
       storageType = Value(storageType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SamplesTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<String>? fillId,
    Expression<String>? cutId,
    Expression<int>? sampleNumber,
    Expression<String>? sampleType,
    Expression<String>? customSampleTypeText,
    Expression<String>? storageType,
    Expression<int>? storageCount,
    Expression<double>? liters,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (fillId != null) 'fill_id': fillId,
      if (cutId != null) 'cut_id': cutId,
      if (sampleNumber != null) 'sample_number': sampleNumber,
      if (sampleType != null) 'sample_type': sampleType,
      if (customSampleTypeText != null)
        'custom_sample_type_text': customSampleTypeText,
      if (storageType != null) 'storage_type': storageType,
      if (storageCount != null) 'storage_count': storageCount,
      if (liters != null) 'liters': liters,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SamplesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<String>? fillId,
    Value<String>? cutId,
    Value<int>? sampleNumber,
    Value<SampleType>? sampleType,
    Value<String?>? customSampleTypeText,
    Value<StorageType>? storageType,
    Value<int>? storageCount,
    Value<double?>? liters,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SamplesTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      fillId: fillId ?? this.fillId,
      cutId: cutId ?? this.cutId,
      sampleNumber: sampleNumber ?? this.sampleNumber,
      sampleType: sampleType ?? this.sampleType,
      customSampleTypeText: customSampleTypeText ?? this.customSampleTypeText,
      storageType: storageType ?? this.storageType,
      storageCount: storageCount ?? this.storageCount,
      liters: liters ?? this.liters,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (fillId.present) {
      map['fill_id'] = Variable<String>(fillId.value);
    }
    if (cutId.present) {
      map['cut_id'] = Variable<String>(cutId.value);
    }
    if (sampleNumber.present) {
      map['sample_number'] = Variable<int>(sampleNumber.value);
    }
    if (sampleType.present) {
      map['sample_type'] = Variable<String>(
        $SamplesTableTable.$convertersampleType.toSql(sampleType.value),
      );
    }
    if (customSampleTypeText.present) {
      map['custom_sample_type_text'] = Variable<String>(
        customSampleTypeText.value,
      );
    }
    if (storageType.present) {
      map['storage_type'] = Variable<String>(
        $SamplesTableTable.$converterstorageType.toSql(storageType.value),
      );
    }
    if (storageCount.present) {
      map['storage_count'] = Variable<int>(storageCount.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
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
    return (StringBuffer('SamplesTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fillId: $fillId, ')
          ..write('cutId: $cutId, ')
          ..write('sampleNumber: $sampleNumber, ')
          ..write('sampleType: $sampleType, ')
          ..write('customSampleTypeText: $customSampleTypeText, ')
          ..write('storageType: $storageType, ')
          ..write('storageCount: $storageCount, ')
          ..write('liters: $liters, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HarrisRelationsTableTable extends HarrisRelationsTable
    with TableInfo<$HarrisRelationsTableTable, HarrisRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HarrisRelationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureIdMeta = const VerificationMeta(
    'featureId',
  );
  @override
  late final GeneratedColumn<String> featureId = GeneratedColumn<String>(
    'feature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES features (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromContextIdMeta = const VerificationMeta(
    'fromContextId',
  );
  @override
  late final GeneratedColumn<String> fromContextId = GeneratedColumn<String>(
    'from_context_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contexts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _toContextIdMeta = const VerificationMeta(
    'toContextId',
  );
  @override
  late final GeneratedColumn<String> toContextId = GeneratedColumn<String>(
    'to_context_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contexts (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HarrisRelationType, String>
  relationType =
      GeneratedColumn<String>(
        'relation_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HarrisRelationType>(
        $HarrisRelationsTableTable.$converterrelationType,
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
    featureId,
    fromContextId,
    toContextId,
    relationType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'harris_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<HarrisRelationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('feature_id')) {
      context.handle(
        _featureIdMeta,
        featureId.isAcceptableOrUnknown(data['feature_id']!, _featureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_featureIdMeta);
    }
    if (data.containsKey('from_context_id')) {
      context.handle(
        _fromContextIdMeta,
        fromContextId.isAcceptableOrUnknown(
          data['from_context_id']!,
          _fromContextIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromContextIdMeta);
    }
    if (data.containsKey('to_context_id')) {
      context.handle(
        _toContextIdMeta,
        toContextId.isAcceptableOrUnknown(
          data['to_context_id']!,
          _toContextIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toContextIdMeta);
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
  HarrisRelationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HarrisRelationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      featureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_id'],
      )!,
      fromContextId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_context_id'],
      )!,
      toContextId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_context_id'],
      )!,
      relationType: $HarrisRelationsTableTable.$converterrelationType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}relation_type'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HarrisRelationsTableTable createAlias(String alias) {
    return $HarrisRelationsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<HarrisRelationType, String> $converterrelationType =
      const HarrisRelationTypeConverter();
}

class HarrisRelationsTableData extends DataClass
    implements Insertable<HarrisRelationsTableData> {
  final String id;
  final String featureId;
  final String fromContextId;
  final String toContextId;
  final HarrisRelationType relationType;
  final DateTime createdAt;
  const HarrisRelationsTableData({
    required this.id,
    required this.featureId,
    required this.fromContextId,
    required this.toContextId,
    required this.relationType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['feature_id'] = Variable<String>(featureId);
    map['from_context_id'] = Variable<String>(fromContextId);
    map['to_context_id'] = Variable<String>(toContextId);
    {
      map['relation_type'] = Variable<String>(
        $HarrisRelationsTableTable.$converterrelationType.toSql(relationType),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HarrisRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return HarrisRelationsTableCompanion(
      id: Value(id),
      featureId: Value(featureId),
      fromContextId: Value(fromContextId),
      toContextId: Value(toContextId),
      relationType: Value(relationType),
      createdAt: Value(createdAt),
    );
  }

  factory HarrisRelationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HarrisRelationsTableData(
      id: serializer.fromJson<String>(json['id']),
      featureId: serializer.fromJson<String>(json['featureId']),
      fromContextId: serializer.fromJson<String>(json['fromContextId']),
      toContextId: serializer.fromJson<String>(json['toContextId']),
      relationType: serializer.fromJson<HarrisRelationType>(
        json['relationType'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'featureId': serializer.toJson<String>(featureId),
      'fromContextId': serializer.toJson<String>(fromContextId),
      'toContextId': serializer.toJson<String>(toContextId),
      'relationType': serializer.toJson<HarrisRelationType>(relationType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HarrisRelationsTableData copyWith({
    String? id,
    String? featureId,
    String? fromContextId,
    String? toContextId,
    HarrisRelationType? relationType,
    DateTime? createdAt,
  }) => HarrisRelationsTableData(
    id: id ?? this.id,
    featureId: featureId ?? this.featureId,
    fromContextId: fromContextId ?? this.fromContextId,
    toContextId: toContextId ?? this.toContextId,
    relationType: relationType ?? this.relationType,
    createdAt: createdAt ?? this.createdAt,
  );
  HarrisRelationsTableData copyWithCompanion(
    HarrisRelationsTableCompanion data,
  ) {
    return HarrisRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      featureId: data.featureId.present ? data.featureId.value : this.featureId,
      fromContextId: data.fromContextId.present
          ? data.fromContextId.value
          : this.fromContextId,
      toContextId: data.toContextId.present
          ? data.toContextId.value
          : this.toContextId,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HarrisRelationsTableData(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fromContextId: $fromContextId, ')
          ..write('toContextId: $toContextId, ')
          ..write('relationType: $relationType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    featureId,
    fromContextId,
    toContextId,
    relationType,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HarrisRelationsTableData &&
          other.id == this.id &&
          other.featureId == this.featureId &&
          other.fromContextId == this.fromContextId &&
          other.toContextId == this.toContextId &&
          other.relationType == this.relationType &&
          other.createdAt == this.createdAt);
}

class HarrisRelationsTableCompanion
    extends UpdateCompanion<HarrisRelationsTableData> {
  final Value<String> id;
  final Value<String> featureId;
  final Value<String> fromContextId;
  final Value<String> toContextId;
  final Value<HarrisRelationType> relationType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HarrisRelationsTableCompanion({
    this.id = const Value.absent(),
    this.featureId = const Value.absent(),
    this.fromContextId = const Value.absent(),
    this.toContextId = const Value.absent(),
    this.relationType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HarrisRelationsTableCompanion.insert({
    required String id,
    required String featureId,
    required String fromContextId,
    required String toContextId,
    required HarrisRelationType relationType,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       featureId = Value(featureId),
       fromContextId = Value(fromContextId),
       toContextId = Value(toContextId),
       relationType = Value(relationType),
       createdAt = Value(createdAt);
  static Insertable<HarrisRelationsTableData> custom({
    Expression<String>? id,
    Expression<String>? featureId,
    Expression<String>? fromContextId,
    Expression<String>? toContextId,
    Expression<String>? relationType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureId != null) 'feature_id': featureId,
      if (fromContextId != null) 'from_context_id': fromContextId,
      if (toContextId != null) 'to_context_id': toContextId,
      if (relationType != null) 'relation_type': relationType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HarrisRelationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? featureId,
    Value<String>? fromContextId,
    Value<String>? toContextId,
    Value<HarrisRelationType>? relationType,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HarrisRelationsTableCompanion(
      id: id ?? this.id,
      featureId: featureId ?? this.featureId,
      fromContextId: fromContextId ?? this.fromContextId,
      toContextId: toContextId ?? this.toContextId,
      relationType: relationType ?? this.relationType,
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
    if (featureId.present) {
      map['feature_id'] = Variable<String>(featureId.value);
    }
    if (fromContextId.present) {
      map['from_context_id'] = Variable<String>(fromContextId.value);
    }
    if (toContextId.present) {
      map['to_context_id'] = Variable<String>(toContextId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(
        $HarrisRelationsTableTable.$converterrelationType.toSql(
          relationType.value,
        ),
      );
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
    return (StringBuffer('HarrisRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('featureId: $featureId, ')
          ..write('fromContextId: $fromContextId, ')
          ..write('toContextId: $toContextId, ')
          ..write('relationType: $relationType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTableTable projectsTable = $ProjectsTableTable(this);
  late final $FeaturesTableTable featuresTable = $FeaturesTableTable(this);
  late final $PhotosTableTable photosTable = $PhotosTableTable(this);
  late final $DrawingsTableTable drawingsTable = $DrawingsTableTable(this);
  late final $ContextsTableTable contextsTable = $ContextsTableTable(this);
  late final $FindsTableTable findsTable = $FindsTableTable(this);
  late final $SamplesTableTable samplesTable = $SamplesTableTable(this);
  late final $HarrisRelationsTableTable harrisRelationsTable =
      $HarrisRelationsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projectsTable,
    featuresTable,
    photosTable,
    drawingsTable,
    contextsTable,
    findsTable,
    samplesTable,
    harrisRelationsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('drawings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contexts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('finds', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contexts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('finds', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('samples', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contexts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('samples', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'features',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('harris_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contexts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('harris_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contexts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('harris_relations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProjectsTableTableCreateCompanionBuilder =
    ProjectsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> rubiconCode,
      Value<String?> licenceNumber,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProjectsTableTableUpdateCompanionBuilder =
    ProjectsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> rubiconCode,
      Value<String?> licenceNumber,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProjectsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTableTable> {
  $$ProjectsTableTableFilterComposer({
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

  ColumnFilters<String> get rubiconCode => $composableBuilder(
    column: $table.rubiconCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenceNumber => $composableBuilder(
    column: $table.licenceNumber,
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

class $$ProjectsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTableTable> {
  $$ProjectsTableTableOrderingComposer({
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

  ColumnOrderings<String> get rubiconCode => $composableBuilder(
    column: $table.rubiconCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenceNumber => $composableBuilder(
    column: $table.licenceNumber,
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

class $$ProjectsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTableTable> {
  $$ProjectsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get rubiconCode => $composableBuilder(
    column: $table.rubiconCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenceNumber => $composableBuilder(
    column: $table.licenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProjectsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTableTable,
          ProjectsTableData,
          $$ProjectsTableTableFilterComposer,
          $$ProjectsTableTableOrderingComposer,
          $$ProjectsTableTableAnnotationComposer,
          $$ProjectsTableTableCreateCompanionBuilder,
          $$ProjectsTableTableUpdateCompanionBuilder,
          (
            ProjectsTableData,
            BaseReferences<
              _$AppDatabase,
              $ProjectsTableTable,
              ProjectsTableData
            >,
          ),
          ProjectsTableData,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableTableManager(_$AppDatabase db, $ProjectsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> rubiconCode = const Value.absent(),
                Value<String?> licenceNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsTableCompanion(
                id: id,
                name: name,
                rubiconCode: rubiconCode,
                licenceNumber: licenceNumber,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> rubiconCode = const Value.absent(),
                Value<String?> licenceNumber = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProjectsTableCompanion.insert(
                id: id,
                name: name,
                rubiconCode: rubiconCode,
                licenceNumber: licenceNumber,
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

typedef $$ProjectsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTableTable,
      ProjectsTableData,
      $$ProjectsTableTableFilterComposer,
      $$ProjectsTableTableOrderingComposer,
      $$ProjectsTableTableAnnotationComposer,
      $$ProjectsTableTableCreateCompanionBuilder,
      $$ProjectsTableTableUpdateCompanionBuilder,
      (
        ProjectsTableData,
        BaseReferences<_$AppDatabase, $ProjectsTableTable, ProjectsTableData>,
      ),
      ProjectsTableData,
      PrefetchHooks Function()
    >;
typedef $$FeaturesTableTableCreateCompanionBuilder =
    FeaturesTableCompanion Function({
      required String id,
      required String featureNumber,
      Value<String?> projectId,
      Value<String?> area,
      Value<bool> isNonArchaeological,
      Value<FeatureType> featureType,
      required DateTime date,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FeaturesTableTableUpdateCompanionBuilder =
    FeaturesTableCompanion Function({
      Value<String> id,
      Value<String> featureNumber,
      Value<String?> projectId,
      Value<String?> area,
      Value<bool> isNonArchaeological,
      Value<FeatureType> featureType,
      Value<DateTime> date,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FeaturesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $FeaturesTableTable, FeaturesTableData> {
  $$FeaturesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PhotosTableTable, List<PhotosTableData>>
  _photosTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.photosTable,
    aliasName: $_aliasNameGenerator(
      db.featuresTable.id,
      db.photosTable.featureId,
    ),
  );

  $$PhotosTableTableProcessedTableManager get photosTableRefs {
    final manager = $$PhotosTableTableTableManager(
      $_db,
      $_db.photosTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DrawingsTableTable, List<DrawingsTableData>>
  _drawingsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.drawingsTable,
    aliasName: $_aliasNameGenerator(
      db.featuresTable.id,
      db.drawingsTable.featureId,
    ),
  );

  $$DrawingsTableTableProcessedTableManager get drawingsTableRefs {
    final manager = $$DrawingsTableTableTableManager(
      $_db,
      $_db.drawingsTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drawingsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContextsTableTable, List<ContextsTableData>>
  _contextsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contextsTable,
    aliasName: $_aliasNameGenerator(
      db.featuresTable.id,
      db.contextsTable.featureId,
    ),
  );

  $$ContextsTableTableProcessedTableManager get contextsTableRefs {
    final manager = $$ContextsTableTableTableManager(
      $_db,
      $_db.contextsTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contextsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FindsTableTable, List<FindsTableData>>
  _findsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.findsTable,
    aliasName: $_aliasNameGenerator(
      db.featuresTable.id,
      db.findsTable.featureId,
    ),
  );

  $$FindsTableTableProcessedTableManager get findsTableRefs {
    final manager = $$FindsTableTableTableManager(
      $_db,
      $_db.findsTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_findsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SamplesTableTable, List<SamplesTableData>>
  _samplesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.samplesTable,
    aliasName: $_aliasNameGenerator(
      db.featuresTable.id,
      db.samplesTable.featureId,
    ),
  );

  $$SamplesTableTableProcessedTableManager get samplesTableRefs {
    final manager = $$SamplesTableTableTableManager(
      $_db,
      $_db.samplesTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_samplesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $HarrisRelationsTableTable,
    List<HarrisRelationsTableData>
  >
  _harrisRelationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.harrisRelationsTable,
        aliasName: $_aliasNameGenerator(
          db.featuresTable.id,
          db.harrisRelationsTable.featureId,
        ),
      );

  $$HarrisRelationsTableTableProcessedTableManager
  get harrisRelationsTableRefs {
    final manager = $$HarrisRelationsTableTableTableManager(
      $_db,
      $_db.harrisRelationsTable,
    ).filter((f) => f.featureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _harrisRelationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeaturesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FeaturesTableTable> {
  $$FeaturesTableTableFilterComposer({
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

  ColumnFilters<String> get featureNumber => $composableBuilder(
    column: $table.featureNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNonArchaeological => $composableBuilder(
    column: $table.isNonArchaeological,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeatureType, FeatureType, String>
  get featureType => $composableBuilder(
    column: $table.featureType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
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

  Expression<bool> photosTableRefs(
    Expression<bool> Function($$PhotosTableTableFilterComposer f) f,
  ) {
    final $$PhotosTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photosTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableTableFilterComposer(
            $db: $db,
            $table: $db.photosTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> drawingsTableRefs(
    Expression<bool> Function($$DrawingsTableTableFilterComposer f) f,
  ) {
    final $$DrawingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawingsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawingsTableTableFilterComposer(
            $db: $db,
            $table: $db.drawingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contextsTableRefs(
    Expression<bool> Function($$ContextsTableTableFilterComposer f) f,
  ) {
    final $$ContextsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableFilterComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> findsTableRefs(
    Expression<bool> Function($$FindsTableTableFilterComposer f) f,
  ) {
    final $$FindsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.findsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FindsTableTableFilterComposer(
            $db: $db,
            $table: $db.findsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> samplesTableRefs(
    Expression<bool> Function($$SamplesTableTableFilterComposer f) f,
  ) {
    final $$SamplesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.samplesTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SamplesTableTableFilterComposer(
            $db: $db,
            $table: $db.samplesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> harrisRelationsTableRefs(
    Expression<bool> Function($$HarrisRelationsTableTableFilterComposer f) f,
  ) {
    final $$HarrisRelationsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.harrisRelationsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarrisRelationsTableTableFilterComposer(
            $db: $db,
            $table: $db.harrisRelationsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeaturesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FeaturesTableTable> {
  $$FeaturesTableTableOrderingComposer({
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

  ColumnOrderings<String> get featureNumber => $composableBuilder(
    column: $table.featureNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNonArchaeological => $composableBuilder(
    column: $table.isNonArchaeological,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get featureType => $composableBuilder(
    column: $table.featureType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
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

class $$FeaturesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeaturesTableTable> {
  $$FeaturesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get featureNumber => $composableBuilder(
    column: $table.featureNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<bool> get isNonArchaeological => $composableBuilder(
    column: $table.isNonArchaeological,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FeatureType, String> get featureType =>
      $composableBuilder(
        column: $table.featureType,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> photosTableRefs<T extends Object>(
    Expression<T> Function($$PhotosTableTableAnnotationComposer a) f,
  ) {
    final $$PhotosTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photosTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableTableAnnotationComposer(
            $db: $db,
            $table: $db.photosTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> drawingsTableRefs<T extends Object>(
    Expression<T> Function($$DrawingsTableTableAnnotationComposer a) f,
  ) {
    final $$DrawingsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawingsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawingsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.drawingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contextsTableRefs<T extends Object>(
    Expression<T> Function($$ContextsTableTableAnnotationComposer a) f,
  ) {
    final $$ContextsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> findsTableRefs<T extends Object>(
    Expression<T> Function($$FindsTableTableAnnotationComposer a) f,
  ) {
    final $$FindsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.findsTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FindsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.findsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> samplesTableRefs<T extends Object>(
    Expression<T> Function($$SamplesTableTableAnnotationComposer a) f,
  ) {
    final $$SamplesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.samplesTable,
      getReferencedColumn: (t) => t.featureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SamplesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.samplesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> harrisRelationsTableRefs<T extends Object>(
    Expression<T> Function($$HarrisRelationsTableTableAnnotationComposer a) f,
  ) {
    final $$HarrisRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.harrisRelationsTable,
          getReferencedColumn: (t) => t.featureId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HarrisRelationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.harrisRelationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FeaturesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeaturesTableTable,
          FeaturesTableData,
          $$FeaturesTableTableFilterComposer,
          $$FeaturesTableTableOrderingComposer,
          $$FeaturesTableTableAnnotationComposer,
          $$FeaturesTableTableCreateCompanionBuilder,
          $$FeaturesTableTableUpdateCompanionBuilder,
          (FeaturesTableData, $$FeaturesTableTableReferences),
          FeaturesTableData,
          PrefetchHooks Function({
            bool photosTableRefs,
            bool drawingsTableRefs,
            bool contextsTableRefs,
            bool findsTableRefs,
            bool samplesTableRefs,
            bool harrisRelationsTableRefs,
          })
        > {
  $$FeaturesTableTableTableManager(_$AppDatabase db, $FeaturesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeaturesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeaturesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeaturesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureNumber = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<bool> isNonArchaeological = const Value.absent(),
                Value<FeatureType> featureType = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeaturesTableCompanion(
                id: id,
                featureNumber: featureNumber,
                projectId: projectId,
                area: area,
                isNonArchaeological: isNonArchaeological,
                featureType: featureType,
                date: date,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureNumber,
                Value<String?> projectId = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<bool> isNonArchaeological = const Value.absent(),
                Value<FeatureType> featureType = const Value.absent(),
                required DateTime date,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FeaturesTableCompanion.insert(
                id: id,
                featureNumber: featureNumber,
                projectId: projectId,
                area: area,
                isNonArchaeological: isNonArchaeological,
                featureType: featureType,
                date: date,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeaturesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                photosTableRefs = false,
                drawingsTableRefs = false,
                contextsTableRefs = false,
                findsTableRefs = false,
                samplesTableRefs = false,
                harrisRelationsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (photosTableRefs) db.photosTable,
                    if (drawingsTableRefs) db.drawingsTable,
                    if (contextsTableRefs) db.contextsTable,
                    if (findsTableRefs) db.findsTable,
                    if (samplesTableRefs) db.samplesTable,
                    if (harrisRelationsTableRefs) db.harrisRelationsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (photosTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          PhotosTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._photosTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).photosTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (drawingsTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          DrawingsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._drawingsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).drawingsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contextsTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          ContextsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._contextsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).contextsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (findsTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          FindsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._findsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).findsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (samplesTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          SamplesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._samplesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).samplesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (harrisRelationsTableRefs)
                        await $_getPrefetchedData<
                          FeaturesTableData,
                          $FeaturesTableTable,
                          HarrisRelationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FeaturesTableTableReferences
                              ._harrisRelationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeaturesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).harrisRelationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.featureId == item.id,
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

typedef $$FeaturesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeaturesTableTable,
      FeaturesTableData,
      $$FeaturesTableTableFilterComposer,
      $$FeaturesTableTableOrderingComposer,
      $$FeaturesTableTableAnnotationComposer,
      $$FeaturesTableTableCreateCompanionBuilder,
      $$FeaturesTableTableUpdateCompanionBuilder,
      (FeaturesTableData, $$FeaturesTableTableReferences),
      FeaturesTableData,
      PrefetchHooks Function({
        bool photosTableRefs,
        bool drawingsTableRefs,
        bool contextsTableRefs,
        bool findsTableRefs,
        bool samplesTableRefs,
        bool harrisRelationsTableRefs,
      })
    >;
typedef $$PhotosTableTableCreateCompanionBuilder =
    PhotosTableCompanion Function({
      required String id,
      required String featureId,
      required PhotoStage stage,
      Value<String?> manualCameraPhotoNumber,
      Value<CardinalOrientation> cardinalOrientation,
      Value<String?> notes,
      Value<String?> localImagePath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PhotosTableTableUpdateCompanionBuilder =
    PhotosTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<PhotoStage> stage,
      Value<String?> manualCameraPhotoNumber,
      Value<CardinalOrientation> cardinalOrientation,
      Value<String?> notes,
      Value<String?> localImagePath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PhotosTableTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTableTable, PhotosTableData> {
  $$PhotosTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(db.photosTable.featureId, db.featuresTable.id),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhotosTableTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTableTable> {
  $$PhotosTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<PhotoStage, PhotoStage, String> get stage =>
      $composableBuilder(
        column: $table.stage,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get manualCameraPhotoNumber => $composableBuilder(
    column: $table.manualCameraPhotoNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CardinalOrientation,
    CardinalOrientation,
    String
  >
  get cardinalOrientation => $composableBuilder(
    column: $table.cardinalOrientation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
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

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTableTable> {
  $$PhotosTableTableOrderingComposer({
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

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manualCameraPhotoNumber => $composableBuilder(
    column: $table.manualCameraPhotoNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardinalOrientation => $composableBuilder(
    column: $table.cardinalOrientation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
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

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTableTable> {
  $$PhotosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PhotoStage, String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get manualCameraPhotoNumber => $composableBuilder(
    column: $table.manualCameraPhotoNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CardinalOrientation, String>
  get cardinalOrientation => $composableBuilder(
    column: $table.cardinalOrientation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTableTable,
          PhotosTableData,
          $$PhotosTableTableFilterComposer,
          $$PhotosTableTableOrderingComposer,
          $$PhotosTableTableAnnotationComposer,
          $$PhotosTableTableCreateCompanionBuilder,
          $$PhotosTableTableUpdateCompanionBuilder,
          (PhotosTableData, $$PhotosTableTableReferences),
          PhotosTableData,
          PrefetchHooks Function({bool featureId})
        > {
  $$PhotosTableTableTableManager(_$AppDatabase db, $PhotosTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<PhotoStage> stage = const Value.absent(),
                Value<String?> manualCameraPhotoNumber = const Value.absent(),
                Value<CardinalOrientation> cardinalOrientation =
                    const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosTableCompanion(
                id: id,
                featureId: featureId,
                stage: stage,
                manualCameraPhotoNumber: manualCameraPhotoNumber,
                cardinalOrientation: cardinalOrientation,
                notes: notes,
                localImagePath: localImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required PhotoStage stage,
                Value<String?> manualCameraPhotoNumber = const Value.absent(),
                Value<CardinalOrientation> cardinalOrientation =
                    const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PhotosTableCompanion.insert(
                id: id,
                featureId: featureId,
                stage: stage,
                manualCameraPhotoNumber: manualCameraPhotoNumber,
                cardinalOrientation: cardinalOrientation,
                notes: notes,
                localImagePath: localImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PhotosTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({featureId = false}) {
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
                    if (featureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.featureId,
                                referencedTable: $$PhotosTableTableReferences
                                    ._featureIdTable(db),
                                referencedColumn: $$PhotosTableTableReferences
                                    ._featureIdTable(db)
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

typedef $$PhotosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTableTable,
      PhotosTableData,
      $$PhotosTableTableFilterComposer,
      $$PhotosTableTableOrderingComposer,
      $$PhotosTableTableAnnotationComposer,
      $$PhotosTableTableCreateCompanionBuilder,
      $$PhotosTableTableUpdateCompanionBuilder,
      (PhotosTableData, $$PhotosTableTableReferences),
      PhotosTableData,
      PrefetchHooks Function({bool featureId})
    >;
typedef $$DrawingsTableTableCreateCompanionBuilder =
    DrawingsTableCompanion Function({
      required String id,
      required String featureId,
      required String drawingNumber,
      Value<String?> boardNumber,
      Value<DrawingType?> drawingType,
      Value<CardinalOrientation> facing,
      Value<String?> notes,
      Value<String?> referenceImagePath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DrawingsTableTableUpdateCompanionBuilder =
    DrawingsTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<String> drawingNumber,
      Value<String?> boardNumber,
      Value<DrawingType?> drawingType,
      Value<CardinalOrientation> facing,
      Value<String?> notes,
      Value<String?> referenceImagePath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DrawingsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $DrawingsTableTable, DrawingsTableData> {
  $$DrawingsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(db.drawingsTable.featureId, db.featuresTable.id),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DrawingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DrawingsTableTable> {
  $$DrawingsTableTableFilterComposer({
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

  ColumnFilters<String> get drawingNumber => $composableBuilder(
    column: $table.drawingNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardNumber => $composableBuilder(
    column: $table.boardNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DrawingType?, DrawingType, String>
  get drawingType => $composableBuilder(
    column: $table.drawingType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CardinalOrientation,
    CardinalOrientation,
    String
  >
  get facing => $composableBuilder(
    column: $table.facing,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceImagePath => $composableBuilder(
    column: $table.referenceImagePath,
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

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrawingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawingsTableTable> {
  $$DrawingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get drawingNumber => $composableBuilder(
    column: $table.drawingNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardNumber => $composableBuilder(
    column: $table.boardNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get drawingType => $composableBuilder(
    column: $table.drawingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facing => $composableBuilder(
    column: $table.facing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceImagePath => $composableBuilder(
    column: $table.referenceImagePath,
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

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrawingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawingsTableTable> {
  $$DrawingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get drawingNumber => $composableBuilder(
    column: $table.drawingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get boardNumber => $composableBuilder(
    column: $table.boardNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DrawingType?, String> get drawingType =>
      $composableBuilder(
        column: $table.drawingType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CardinalOrientation, String> get facing =>
      $composableBuilder(column: $table.facing, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get referenceImagePath => $composableBuilder(
    column: $table.referenceImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrawingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrawingsTableTable,
          DrawingsTableData,
          $$DrawingsTableTableFilterComposer,
          $$DrawingsTableTableOrderingComposer,
          $$DrawingsTableTableAnnotationComposer,
          $$DrawingsTableTableCreateCompanionBuilder,
          $$DrawingsTableTableUpdateCompanionBuilder,
          (DrawingsTableData, $$DrawingsTableTableReferences),
          DrawingsTableData,
          PrefetchHooks Function({bool featureId})
        > {
  $$DrawingsTableTableTableManager(_$AppDatabase db, $DrawingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrawingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<String> drawingNumber = const Value.absent(),
                Value<String?> boardNumber = const Value.absent(),
                Value<DrawingType?> drawingType = const Value.absent(),
                Value<CardinalOrientation> facing = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> referenceImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrawingsTableCompanion(
                id: id,
                featureId: featureId,
                drawingNumber: drawingNumber,
                boardNumber: boardNumber,
                drawingType: drawingType,
                facing: facing,
                notes: notes,
                referenceImagePath: referenceImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required String drawingNumber,
                Value<String?> boardNumber = const Value.absent(),
                Value<DrawingType?> drawingType = const Value.absent(),
                Value<CardinalOrientation> facing = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> referenceImagePath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DrawingsTableCompanion.insert(
                id: id,
                featureId: featureId,
                drawingNumber: drawingNumber,
                boardNumber: boardNumber,
                drawingType: drawingType,
                facing: facing,
                notes: notes,
                referenceImagePath: referenceImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrawingsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({featureId = false}) {
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
                    if (featureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.featureId,
                                referencedTable: $$DrawingsTableTableReferences
                                    ._featureIdTable(db),
                                referencedColumn: $$DrawingsTableTableReferences
                                    ._featureIdTable(db)
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

typedef $$DrawingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrawingsTableTable,
      DrawingsTableData,
      $$DrawingsTableTableFilterComposer,
      $$DrawingsTableTableOrderingComposer,
      $$DrawingsTableTableAnnotationComposer,
      $$DrawingsTableTableCreateCompanionBuilder,
      $$DrawingsTableTableUpdateCompanionBuilder,
      (DrawingsTableData, $$DrawingsTableTableReferences),
      DrawingsTableData,
      PrefetchHooks Function({bool featureId})
    >;
typedef $$ContextsTableTableCreateCompanionBuilder =
    ContextsTableCompanion Function({
      required String id,
      required String featureId,
      required int contextNumber,
      required ContextType contextType,
      Value<CutType?> cutType,
      Value<String?> customCutTypeText,
      Value<double?> height,
      Value<double?> width,
      Value<double?> depth,
      Value<String?> parentCutId,
      Value<FillComposition?> composition,
      Value<String?> color,
      Value<FillCompaction?> compaction,
      Value<String?> inclusions,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ContextsTableTableUpdateCompanionBuilder =
    ContextsTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<int> contextNumber,
      Value<ContextType> contextType,
      Value<CutType?> cutType,
      Value<String?> customCutTypeText,
      Value<double?> height,
      Value<double?> width,
      Value<double?> depth,
      Value<String?> parentCutId,
      Value<FillComposition?> composition,
      Value<String?> color,
      Value<FillCompaction?> compaction,
      Value<String?> inclusions,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ContextsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ContextsTableTable, ContextsTableData> {
  $$ContextsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(db.contextsTable.featureId, db.featuresTable.id),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FindsTableTable, List<FindsTableData>>
  _findsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.findsTable,
    aliasName: $_aliasNameGenerator(db.contextsTable.id, db.findsTable.fillId),
  );

  $$FindsTableTableProcessedTableManager get findsTableRefs {
    final manager = $$FindsTableTableTableManager(
      $_db,
      $_db.findsTable,
    ).filter((f) => f.fillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_findsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SamplesTableTable, List<SamplesTableData>>
  _samplesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.samplesTable,
    aliasName: $_aliasNameGenerator(
      db.contextsTable.id,
      db.samplesTable.fillId,
    ),
  );

  $$SamplesTableTableProcessedTableManager get samplesTableRefs {
    final manager = $$SamplesTableTableTableManager(
      $_db,
      $_db.samplesTable,
    ).filter((f) => f.fillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_samplesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContextsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ContextsTableTable> {
  $$ContextsTableTableFilterComposer({
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

  ColumnFilters<int> get contextNumber => $composableBuilder(
    column: $table.contextNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ContextType, ContextType, String>
  get contextType => $composableBuilder(
    column: $table.contextType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CutType?, CutType, String> get cutType =>
      $composableBuilder(
        column: $table.cutType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get customCutTypeText => $composableBuilder(
    column: $table.customCutTypeText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentCutId => $composableBuilder(
    column: $table.parentCutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FillComposition?, FillComposition, String>
  get composition => $composableBuilder(
    column: $table.composition,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FillCompaction?, FillCompaction, String>
  get compaction => $composableBuilder(
    column: $table.compaction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get inclusions => $composableBuilder(
    column: $table.inclusions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> findsTableRefs(
    Expression<bool> Function($$FindsTableTableFilterComposer f) f,
  ) {
    final $$FindsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.findsTable,
      getReferencedColumn: (t) => t.fillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FindsTableTableFilterComposer(
            $db: $db,
            $table: $db.findsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> samplesTableRefs(
    Expression<bool> Function($$SamplesTableTableFilterComposer f) f,
  ) {
    final $$SamplesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.samplesTable,
      getReferencedColumn: (t) => t.fillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SamplesTableTableFilterComposer(
            $db: $db,
            $table: $db.samplesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContextsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ContextsTableTable> {
  $$ContextsTableTableOrderingComposer({
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

  ColumnOrderings<int> get contextNumber => $composableBuilder(
    column: $table.contextNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextType => $composableBuilder(
    column: $table.contextType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cutType => $composableBuilder(
    column: $table.cutType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customCutTypeText => $composableBuilder(
    column: $table.customCutTypeText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentCutId => $composableBuilder(
    column: $table.parentCutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get composition => $composableBuilder(
    column: $table.composition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compaction => $composableBuilder(
    column: $table.compaction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inclusions => $composableBuilder(
    column: $table.inclusions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContextsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContextsTableTable> {
  $$ContextsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get contextNumber => $composableBuilder(
    column: $table.contextNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ContextType, String> get contextType =>
      $composableBuilder(
        column: $table.contextType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CutType?, String> get cutType =>
      $composableBuilder(column: $table.cutType, builder: (column) => column);

  GeneratedColumn<String> get customCutTypeText => $composableBuilder(
    column: $table.customCutTypeText,
    builder: (column) => column,
  );

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<String> get parentCutId => $composableBuilder(
    column: $table.parentCutId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FillComposition?, String> get composition =>
      $composableBuilder(
        column: $table.composition,
        builder: (column) => column,
      );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FillCompaction?, String> get compaction =>
      $composableBuilder(
        column: $table.compaction,
        builder: (column) => column,
      );

  GeneratedColumn<String> get inclusions => $composableBuilder(
    column: $table.inclusions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> findsTableRefs<T extends Object>(
    Expression<T> Function($$FindsTableTableAnnotationComposer a) f,
  ) {
    final $$FindsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.findsTable,
      getReferencedColumn: (t) => t.fillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FindsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.findsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> samplesTableRefs<T extends Object>(
    Expression<T> Function($$SamplesTableTableAnnotationComposer a) f,
  ) {
    final $$SamplesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.samplesTable,
      getReferencedColumn: (t) => t.fillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SamplesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.samplesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContextsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContextsTableTable,
          ContextsTableData,
          $$ContextsTableTableFilterComposer,
          $$ContextsTableTableOrderingComposer,
          $$ContextsTableTableAnnotationComposer,
          $$ContextsTableTableCreateCompanionBuilder,
          $$ContextsTableTableUpdateCompanionBuilder,
          (ContextsTableData, $$ContextsTableTableReferences),
          ContextsTableData,
          PrefetchHooks Function({
            bool featureId,
            bool findsTableRefs,
            bool samplesTableRefs,
          })
        > {
  $$ContextsTableTableTableManager(_$AppDatabase db, $ContextsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContextsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContextsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContextsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<int> contextNumber = const Value.absent(),
                Value<ContextType> contextType = const Value.absent(),
                Value<CutType?> cutType = const Value.absent(),
                Value<String?> customCutTypeText = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> width = const Value.absent(),
                Value<double?> depth = const Value.absent(),
                Value<String?> parentCutId = const Value.absent(),
                Value<FillComposition?> composition = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<FillCompaction?> compaction = const Value.absent(),
                Value<String?> inclusions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContextsTableCompanion(
                id: id,
                featureId: featureId,
                contextNumber: contextNumber,
                contextType: contextType,
                cutType: cutType,
                customCutTypeText: customCutTypeText,
                height: height,
                width: width,
                depth: depth,
                parentCutId: parentCutId,
                composition: composition,
                color: color,
                compaction: compaction,
                inclusions: inclusions,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required int contextNumber,
                required ContextType contextType,
                Value<CutType?> cutType = const Value.absent(),
                Value<String?> customCutTypeText = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> width = const Value.absent(),
                Value<double?> depth = const Value.absent(),
                Value<String?> parentCutId = const Value.absent(),
                Value<FillComposition?> composition = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<FillCompaction?> compaction = const Value.absent(),
                Value<String?> inclusions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ContextsTableCompanion.insert(
                id: id,
                featureId: featureId,
                contextNumber: contextNumber,
                contextType: contextType,
                cutType: cutType,
                customCutTypeText: customCutTypeText,
                height: height,
                width: width,
                depth: depth,
                parentCutId: parentCutId,
                composition: composition,
                color: color,
                compaction: compaction,
                inclusions: inclusions,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContextsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                featureId = false,
                findsTableRefs = false,
                samplesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (findsTableRefs) db.findsTable,
                    if (samplesTableRefs) db.samplesTable,
                  ],
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
                        if (featureId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.featureId,
                                    referencedTable:
                                        $$ContextsTableTableReferences
                                            ._featureIdTable(db),
                                    referencedColumn:
                                        $$ContextsTableTableReferences
                                            ._featureIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (findsTableRefs)
                        await $_getPrefetchedData<
                          ContextsTableData,
                          $ContextsTableTable,
                          FindsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ContextsTableTableReferences
                              ._findsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContextsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).findsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fillId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (samplesTableRefs)
                        await $_getPrefetchedData<
                          ContextsTableData,
                          $ContextsTableTable,
                          SamplesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ContextsTableTableReferences
                              ._samplesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContextsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).samplesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fillId == item.id,
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

typedef $$ContextsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContextsTableTable,
      ContextsTableData,
      $$ContextsTableTableFilterComposer,
      $$ContextsTableTableOrderingComposer,
      $$ContextsTableTableAnnotationComposer,
      $$ContextsTableTableCreateCompanionBuilder,
      $$ContextsTableTableUpdateCompanionBuilder,
      (ContextsTableData, $$ContextsTableTableReferences),
      ContextsTableData,
      PrefetchHooks Function({
        bool featureId,
        bool findsTableRefs,
        bool samplesTableRefs,
      })
    >;
typedef $$FindsTableTableCreateCompanionBuilder =
    FindsTableCompanion Function({
      required String id,
      required String featureId,
      required String fillId,
      required int findNumber,
      required FindMaterialType materialType,
      Value<String?> customMaterialText,
      Value<int> quantity,
      Value<String?> description,
      Value<String?> localImagePath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FindsTableTableUpdateCompanionBuilder =
    FindsTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<String> fillId,
      Value<int> findNumber,
      Value<FindMaterialType> materialType,
      Value<String?> customMaterialText,
      Value<int> quantity,
      Value<String?> description,
      Value<String?> localImagePath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FindsTableTableReferences
    extends BaseReferences<_$AppDatabase, $FindsTableTable, FindsTableData> {
  $$FindsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(db.findsTable.featureId, db.featuresTable.id),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContextsTableTable _fillIdTable(_$AppDatabase db) =>
      db.contextsTable.createAlias(
        $_aliasNameGenerator(db.findsTable.fillId, db.contextsTable.id),
      );

  $$ContextsTableTableProcessedTableManager get fillId {
    final $_column = $_itemColumn<String>('fill_id')!;

    final manager = $$ContextsTableTableTableManager(
      $_db,
      $_db.contextsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FindsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FindsTableTable> {
  $$FindsTableTableFilterComposer({
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

  ColumnFilters<int> get findNumber => $composableBuilder(
    column: $table.findNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FindMaterialType, FindMaterialType, String>
  get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get customMaterialText => $composableBuilder(
    column: $table.customMaterialText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
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

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableFilterComposer get fillId {
    final $$ContextsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableFilterComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FindsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FindsTableTable> {
  $$FindsTableTableOrderingComposer({
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

  ColumnOrderings<int> get findNumber => $composableBuilder(
    column: $table.findNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customMaterialText => $composableBuilder(
    column: $table.customMaterialText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
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

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableOrderingComposer get fillId {
    final $$ContextsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableOrderingComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FindsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FindsTableTable> {
  $$FindsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get findNumber => $composableBuilder(
    column: $table.findNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FindMaterialType, String> get materialType =>
      $composableBuilder(
        column: $table.materialType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get customMaterialText => $composableBuilder(
    column: $table.customMaterialText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableAnnotationComposer get fillId {
    final $$ContextsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FindsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FindsTableTable,
          FindsTableData,
          $$FindsTableTableFilterComposer,
          $$FindsTableTableOrderingComposer,
          $$FindsTableTableAnnotationComposer,
          $$FindsTableTableCreateCompanionBuilder,
          $$FindsTableTableUpdateCompanionBuilder,
          (FindsTableData, $$FindsTableTableReferences),
          FindsTableData,
          PrefetchHooks Function({bool featureId, bool fillId})
        > {
  $$FindsTableTableTableManager(_$AppDatabase db, $FindsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FindsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FindsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FindsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<String> fillId = const Value.absent(),
                Value<int> findNumber = const Value.absent(),
                Value<FindMaterialType> materialType = const Value.absent(),
                Value<String?> customMaterialText = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FindsTableCompanion(
                id: id,
                featureId: featureId,
                fillId: fillId,
                findNumber: findNumber,
                materialType: materialType,
                customMaterialText: customMaterialText,
                quantity: quantity,
                description: description,
                localImagePath: localImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required String fillId,
                required int findNumber,
                required FindMaterialType materialType,
                Value<String?> customMaterialText = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FindsTableCompanion.insert(
                id: id,
                featureId: featureId,
                fillId: fillId,
                findNumber: findNumber,
                materialType: materialType,
                customMaterialText: customMaterialText,
                quantity: quantity,
                description: description,
                localImagePath: localImagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FindsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({featureId = false, fillId = false}) {
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
                    if (featureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.featureId,
                                referencedTable: $$FindsTableTableReferences
                                    ._featureIdTable(db),
                                referencedColumn: $$FindsTableTableReferences
                                    ._featureIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (fillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fillId,
                                referencedTable: $$FindsTableTableReferences
                                    ._fillIdTable(db),
                                referencedColumn: $$FindsTableTableReferences
                                    ._fillIdTable(db)
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

typedef $$FindsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FindsTableTable,
      FindsTableData,
      $$FindsTableTableFilterComposer,
      $$FindsTableTableOrderingComposer,
      $$FindsTableTableAnnotationComposer,
      $$FindsTableTableCreateCompanionBuilder,
      $$FindsTableTableUpdateCompanionBuilder,
      (FindsTableData, $$FindsTableTableReferences),
      FindsTableData,
      PrefetchHooks Function({bool featureId, bool fillId})
    >;
typedef $$SamplesTableTableCreateCompanionBuilder =
    SamplesTableCompanion Function({
      required String id,
      required String featureId,
      required String fillId,
      required String cutId,
      required int sampleNumber,
      required SampleType sampleType,
      Value<String?> customSampleTypeText,
      required StorageType storageType,
      Value<int> storageCount,
      Value<double?> liters,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SamplesTableTableUpdateCompanionBuilder =
    SamplesTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<String> fillId,
      Value<String> cutId,
      Value<int> sampleNumber,
      Value<SampleType> sampleType,
      Value<String?> customSampleTypeText,
      Value<StorageType> storageType,
      Value<int> storageCount,
      Value<double?> liters,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SamplesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $SamplesTableTable, SamplesTableData> {
  $$SamplesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(db.samplesTable.featureId, db.featuresTable.id),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContextsTableTable _fillIdTable(_$AppDatabase db) =>
      db.contextsTable.createAlias(
        $_aliasNameGenerator(db.samplesTable.fillId, db.contextsTable.id),
      );

  $$ContextsTableTableProcessedTableManager get fillId {
    final $_column = $_itemColumn<String>('fill_id')!;

    final manager = $$ContextsTableTableTableManager(
      $_db,
      $_db.contextsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SamplesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SamplesTableTable> {
  $$SamplesTableTableFilterComposer({
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

  ColumnFilters<String> get cutId => $composableBuilder(
    column: $table.cutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleNumber => $composableBuilder(
    column: $table.sampleNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SampleType, SampleType, String>
  get sampleType => $composableBuilder(
    column: $table.sampleType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get customSampleTypeText => $composableBuilder(
    column: $table.customSampleTypeText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StorageType, StorageType, String>
  get storageType => $composableBuilder(
    column: $table.storageType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get storageCount => $composableBuilder(
    column: $table.storageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
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

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableFilterComposer get fillId {
    final $$ContextsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableFilterComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SamplesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SamplesTableTable> {
  $$SamplesTableTableOrderingComposer({
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

  ColumnOrderings<String> get cutId => $composableBuilder(
    column: $table.cutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleNumber => $composableBuilder(
    column: $table.sampleNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sampleType => $composableBuilder(
    column: $table.sampleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customSampleTypeText => $composableBuilder(
    column: $table.customSampleTypeText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageType => $composableBuilder(
    column: $table.storageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get storageCount => $composableBuilder(
    column: $table.storageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
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

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableOrderingComposer get fillId {
    final $$ContextsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableOrderingComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SamplesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SamplesTableTable> {
  $$SamplesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cutId =>
      $composableBuilder(column: $table.cutId, builder: (column) => column);

  GeneratedColumn<int> get sampleNumber => $composableBuilder(
    column: $table.sampleNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SampleType, String> get sampleType =>
      $composableBuilder(
        column: $table.sampleType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get customSampleTypeText => $composableBuilder(
    column: $table.customSampleTypeText,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StorageType, String> get storageType =>
      $composableBuilder(
        column: $table.storageType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get storageCount => $composableBuilder(
    column: $table.storageCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableAnnotationComposer get fillId {
    final $$ContextsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fillId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SamplesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SamplesTableTable,
          SamplesTableData,
          $$SamplesTableTableFilterComposer,
          $$SamplesTableTableOrderingComposer,
          $$SamplesTableTableAnnotationComposer,
          $$SamplesTableTableCreateCompanionBuilder,
          $$SamplesTableTableUpdateCompanionBuilder,
          (SamplesTableData, $$SamplesTableTableReferences),
          SamplesTableData,
          PrefetchHooks Function({bool featureId, bool fillId})
        > {
  $$SamplesTableTableTableManager(_$AppDatabase db, $SamplesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SamplesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SamplesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SamplesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<String> fillId = const Value.absent(),
                Value<String> cutId = const Value.absent(),
                Value<int> sampleNumber = const Value.absent(),
                Value<SampleType> sampleType = const Value.absent(),
                Value<String?> customSampleTypeText = const Value.absent(),
                Value<StorageType> storageType = const Value.absent(),
                Value<int> storageCount = const Value.absent(),
                Value<double?> liters = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SamplesTableCompanion(
                id: id,
                featureId: featureId,
                fillId: fillId,
                cutId: cutId,
                sampleNumber: sampleNumber,
                sampleType: sampleType,
                customSampleTypeText: customSampleTypeText,
                storageType: storageType,
                storageCount: storageCount,
                liters: liters,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required String fillId,
                required String cutId,
                required int sampleNumber,
                required SampleType sampleType,
                Value<String?> customSampleTypeText = const Value.absent(),
                required StorageType storageType,
                Value<int> storageCount = const Value.absent(),
                Value<double?> liters = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SamplesTableCompanion.insert(
                id: id,
                featureId: featureId,
                fillId: fillId,
                cutId: cutId,
                sampleNumber: sampleNumber,
                sampleType: sampleType,
                customSampleTypeText: customSampleTypeText,
                storageType: storageType,
                storageCount: storageCount,
                liters: liters,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SamplesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({featureId = false, fillId = false}) {
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
                    if (featureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.featureId,
                                referencedTable: $$SamplesTableTableReferences
                                    ._featureIdTable(db),
                                referencedColumn: $$SamplesTableTableReferences
                                    ._featureIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (fillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fillId,
                                referencedTable: $$SamplesTableTableReferences
                                    ._fillIdTable(db),
                                referencedColumn: $$SamplesTableTableReferences
                                    ._fillIdTable(db)
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

typedef $$SamplesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SamplesTableTable,
      SamplesTableData,
      $$SamplesTableTableFilterComposer,
      $$SamplesTableTableOrderingComposer,
      $$SamplesTableTableAnnotationComposer,
      $$SamplesTableTableCreateCompanionBuilder,
      $$SamplesTableTableUpdateCompanionBuilder,
      (SamplesTableData, $$SamplesTableTableReferences),
      SamplesTableData,
      PrefetchHooks Function({bool featureId, bool fillId})
    >;
typedef $$HarrisRelationsTableTableCreateCompanionBuilder =
    HarrisRelationsTableCompanion Function({
      required String id,
      required String featureId,
      required String fromContextId,
      required String toContextId,
      required HarrisRelationType relationType,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$HarrisRelationsTableTableUpdateCompanionBuilder =
    HarrisRelationsTableCompanion Function({
      Value<String> id,
      Value<String> featureId,
      Value<String> fromContextId,
      Value<String> toContextId,
      Value<HarrisRelationType> relationType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$HarrisRelationsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HarrisRelationsTableTable,
          HarrisRelationsTableData
        > {
  $$HarrisRelationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FeaturesTableTable _featureIdTable(_$AppDatabase db) =>
      db.featuresTable.createAlias(
        $_aliasNameGenerator(
          db.harrisRelationsTable.featureId,
          db.featuresTable.id,
        ),
      );

  $$FeaturesTableTableProcessedTableManager get featureId {
    final $_column = $_itemColumn<String>('feature_id')!;

    final manager = $$FeaturesTableTableTableManager(
      $_db,
      $_db.featuresTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_featureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContextsTableTable _fromContextIdTable(_$AppDatabase db) =>
      db.contextsTable.createAlias(
        $_aliasNameGenerator(
          db.harrisRelationsTable.fromContextId,
          db.contextsTable.id,
        ),
      );

  $$ContextsTableTableProcessedTableManager get fromContextId {
    final $_column = $_itemColumn<String>('from_context_id')!;

    final manager = $$ContextsTableTableTableManager(
      $_db,
      $_db.contextsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromContextIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContextsTableTable _toContextIdTable(_$AppDatabase db) =>
      db.contextsTable.createAlias(
        $_aliasNameGenerator(
          db.harrisRelationsTable.toContextId,
          db.contextsTable.id,
        ),
      );

  $$ContextsTableTableProcessedTableManager get toContextId {
    final $_column = $_itemColumn<String>('to_context_id')!;

    final manager = $$ContextsTableTableTableManager(
      $_db,
      $_db.contextsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toContextIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HarrisRelationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HarrisRelationsTableTable> {
  $$HarrisRelationsTableTableFilterComposer({
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

  ColumnWithTypeConverterFilters<HarrisRelationType, HarrisRelationType, String>
  get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FeaturesTableTableFilterComposer get featureId {
    final $$FeaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableFilterComposer get fromContextId {
    final $$ContextsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableFilterComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableFilterComposer get toContextId {
    final $$ContextsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableFilterComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarrisRelationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HarrisRelationsTableTable> {
  $$HarrisRelationsTableTableOrderingComposer({
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

  ColumnOrderings<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeaturesTableTableOrderingComposer get featureId {
    final $$FeaturesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableOrderingComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableOrderingComposer get fromContextId {
    final $$ContextsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableOrderingComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableOrderingComposer get toContextId {
    final $$ContextsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableOrderingComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarrisRelationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HarrisRelationsTableTable> {
  $$HarrisRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HarrisRelationType, String>
  get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FeaturesTableTableAnnotationComposer get featureId {
    final $$FeaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.featureId,
      referencedTable: $db.featuresTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.featuresTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableAnnotationComposer get fromContextId {
    final $$ContextsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContextsTableTableAnnotationComposer get toContextId {
    final $$ContextsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toContextId,
      referencedTable: $db.contextsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.contextsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HarrisRelationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HarrisRelationsTableTable,
          HarrisRelationsTableData,
          $$HarrisRelationsTableTableFilterComposer,
          $$HarrisRelationsTableTableOrderingComposer,
          $$HarrisRelationsTableTableAnnotationComposer,
          $$HarrisRelationsTableTableCreateCompanionBuilder,
          $$HarrisRelationsTableTableUpdateCompanionBuilder,
          (HarrisRelationsTableData, $$HarrisRelationsTableTableReferences),
          HarrisRelationsTableData,
          PrefetchHooks Function({
            bool featureId,
            bool fromContextId,
            bool toContextId,
          })
        > {
  $$HarrisRelationsTableTableTableManager(
    _$AppDatabase db,
    $HarrisRelationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HarrisRelationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HarrisRelationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HarrisRelationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> featureId = const Value.absent(),
                Value<String> fromContextId = const Value.absent(),
                Value<String> toContextId = const Value.absent(),
                Value<HarrisRelationType> relationType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HarrisRelationsTableCompanion(
                id: id,
                featureId: featureId,
                fromContextId: fromContextId,
                toContextId: toContextId,
                relationType: relationType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String featureId,
                required String fromContextId,
                required String toContextId,
                required HarrisRelationType relationType,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HarrisRelationsTableCompanion.insert(
                id: id,
                featureId: featureId,
                fromContextId: fromContextId,
                toContextId: toContextId,
                relationType: relationType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HarrisRelationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                featureId = false,
                fromContextId = false,
                toContextId = false,
              }) {
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
                        if (featureId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.featureId,
                                    referencedTable:
                                        $$HarrisRelationsTableTableReferences
                                            ._featureIdTable(db),
                                    referencedColumn:
                                        $$HarrisRelationsTableTableReferences
                                            ._featureIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (fromContextId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromContextId,
                                    referencedTable:
                                        $$HarrisRelationsTableTableReferences
                                            ._fromContextIdTable(db),
                                    referencedColumn:
                                        $$HarrisRelationsTableTableReferences
                                            ._fromContextIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (toContextId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toContextId,
                                    referencedTable:
                                        $$HarrisRelationsTableTableReferences
                                            ._toContextIdTable(db),
                                    referencedColumn:
                                        $$HarrisRelationsTableTableReferences
                                            ._toContextIdTable(db)
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

typedef $$HarrisRelationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HarrisRelationsTableTable,
      HarrisRelationsTableData,
      $$HarrisRelationsTableTableFilterComposer,
      $$HarrisRelationsTableTableOrderingComposer,
      $$HarrisRelationsTableTableAnnotationComposer,
      $$HarrisRelationsTableTableCreateCompanionBuilder,
      $$HarrisRelationsTableTableUpdateCompanionBuilder,
      (HarrisRelationsTableData, $$HarrisRelationsTableTableReferences),
      HarrisRelationsTableData,
      PrefetchHooks Function({
        bool featureId,
        bool fromContextId,
        bool toContextId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableTableManager get projectsTable =>
      $$ProjectsTableTableTableManager(_db, _db.projectsTable);
  $$FeaturesTableTableTableManager get featuresTable =>
      $$FeaturesTableTableTableManager(_db, _db.featuresTable);
  $$PhotosTableTableTableManager get photosTable =>
      $$PhotosTableTableTableManager(_db, _db.photosTable);
  $$DrawingsTableTableTableManager get drawingsTable =>
      $$DrawingsTableTableTableManager(_db, _db.drawingsTable);
  $$ContextsTableTableTableManager get contextsTable =>
      $$ContextsTableTableTableManager(_db, _db.contextsTable);
  $$FindsTableTableTableManager get findsTable =>
      $$FindsTableTableTableManager(_db, _db.findsTable);
  $$SamplesTableTableTableManager get samplesTable =>
      $$SamplesTableTableTableManager(_db, _db.samplesTable);
  $$HarrisRelationsTableTableTableManager get harrisRelationsTable =>
      $$HarrisRelationsTableTableTableManager(_db, _db.harrisRelationsTable);
}
