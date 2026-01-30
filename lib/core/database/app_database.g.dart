// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LicenseTableTable extends LicenseTable
    with TableInfo<$LicenseTableTable, LicenseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LicenseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LicenseType, String> code =
      GeneratedColumn<String>(
        'code',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 3,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LicenseType>($LicenseTableTable.$convertercode);
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
  List<GeneratedColumn> get $columns => [id, code, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'license_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LicenseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  LicenseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LicenseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: $LicenseTableTable.$convertercode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}code'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $LicenseTableTable createAlias(String alias) {
    return $LicenseTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LicenseType, String, String> $convertercode =
      const EnumNameConverter<LicenseType>(LicenseType.values);
}

class LicenseTableData extends DataClass
    implements Insertable<LicenseTableData> {
  final int id;
  final LicenseType code;
  final String description;
  const LicenseTableData({
    required this.id,
    required this.code,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['code'] = Variable<String>(
        $LicenseTableTable.$convertercode.toSql(code),
      );
    }
    map['description'] = Variable<String>(description);
    return map;
  }

  LicenseTableCompanion toCompanion(bool nullToAbsent) {
    return LicenseTableCompanion(
      id: Value(id),
      code: Value(code),
      description: Value(description),
    );
  }

  factory LicenseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LicenseTableData(
      id: serializer.fromJson<int>(json['id']),
      code: $LicenseTableTable.$convertercode.fromJson(
        serializer.fromJson<String>(json['code']),
      ),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(
        $LicenseTableTable.$convertercode.toJson(code),
      ),
      'description': serializer.toJson<String>(description),
    };
  }

  LicenseTableData copyWith({
    int? id,
    LicenseType? code,
    String? description,
  }) => LicenseTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    description: description ?? this.description,
  );
  LicenseTableData copyWithCompanion(LicenseTableCompanion data) {
    return LicenseTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LicenseTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LicenseTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.description == this.description);
}

class LicenseTableCompanion extends UpdateCompanion<LicenseTableData> {
  final Value<int> id;
  final Value<LicenseType> code;
  final Value<String> description;
  const LicenseTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
  });
  LicenseTableCompanion.insert({
    this.id = const Value.absent(),
    required LicenseType code,
    required String description,
  }) : code = Value(code),
       description = Value(description);
  static Insertable<LicenseTableData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
    });
  }

  LicenseTableCompanion copyWith({
    Value<int>? id,
    Value<LicenseType>? code,
    Value<String>? description,
  }) {
    return LicenseTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(
        $LicenseTableTable.$convertercode.toSql(code.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LicenseTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _licenseIdMeta = const VerificationMeta(
    'licenseId',
  );
  @override
  late final GeneratedColumn<int> licenseId = GeneratedColumn<int>(
    'license_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES license_table (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    licenseId,
    name,
    age,
    gender,
    avatarPath,
    phoneNumber,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('license_id')) {
      context.handle(
        _licenseIdMeta,
        licenseId.isAcceptableOrUnknown(data['license_id']!, _licenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      licenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}license_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gender'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
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
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final int id;
  final int licenseId;
  final String name;
  final int age;
  final int gender;
  final String? avatarPath;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserTableData({
    required this.id,
    required this.licenseId,
    required this.name,
    required this.age,
    required this.gender,
    this.avatarPath,
    this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['license_id'] = Variable<int>(licenseId);
    map['name'] = Variable<String>(name);
    map['age'] = Variable<int>(age);
    map['gender'] = Variable<int>(gender);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      licenseId: Value(licenseId),
      name: Value(name),
      age: Value(age),
      gender: Value(gender),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      licenseId: serializer.fromJson<int>(json['licenseId']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int>(json['age']),
      gender: serializer.fromJson<int>(json['gender']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'licenseId': serializer.toJson<int>(licenseId),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int>(age),
      'gender': serializer.toJson<int>(gender),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserTableData copyWith({
    int? id,
    int? licenseId,
    String? name,
    int? age,
    int? gender,
    Value<String?> avatarPath = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserTableData(
    id: id ?? this.id,
    licenseId: licenseId ?? this.licenseId,
    name: name ?? this.name,
    age: age ?? this.age,
    gender: gender ?? this.gender,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      licenseId: data.licenseId.present ? data.licenseId.value : this.licenseId,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('licenseId: $licenseId, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    licenseId,
    name,
    age,
    gender,
    avatarPath,
    phoneNumber,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.licenseId == this.licenseId &&
          other.name == this.name &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.avatarPath == this.avatarPath &&
          other.phoneNumber == this.phoneNumber &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<int> licenseId;
  final Value<String> name;
  final Value<int> age;
  final Value<int> gender;
  final Value<String?> avatarPath;
  final Value<String?> phoneNumber;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.licenseId = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required int licenseId,
    required String name,
    required int age,
    this.gender = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : licenseId = Value(licenseId),
       name = Value(name),
       age = Value(age);
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<int>? licenseId,
    Expression<String>? name,
    Expression<int>? age,
    Expression<int>? gender,
    Expression<String>? avatarPath,
    Expression<String>? phoneNumber,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (licenseId != null) 'license_id': licenseId,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserTableCompanion copyWith({
    Value<int>? id,
    Value<int>? licenseId,
    Value<String>? name,
    Value<int>? age,
    Value<int>? gender,
    Value<String?>? avatarPath,
    Value<String?>? phoneNumber,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserTableCompanion(
      id: id ?? this.id,
      licenseId: licenseId ?? this.licenseId,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      avatarPath: avatarPath ?? this.avatarPath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (licenseId.present) {
      map['license_id'] = Variable<int>(licenseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('licenseId: $licenseId, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $QuestionCategoryTableTable extends QuestionCategoryTable
    with TableInfo<$QuestionCategoryTableTable, QuestionCategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionCategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionCategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionCategoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionCategoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $QuestionCategoryTableTable createAlias(String alias) {
    return $QuestionCategoryTableTable(attachedDatabase, alias);
  }
}

class QuestionCategoryTableData extends DataClass
    implements Insertable<QuestionCategoryTableData> {
  final int id;
  final String label;
  final String? description;
  const QuestionCategoryTableData({
    required this.id,
    required this.label,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  QuestionCategoryTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionCategoryTableCompanion(
      id: Value(id),
      label: Value(label),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory QuestionCategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionCategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'description': serializer.toJson<String?>(description),
    };
  }

  QuestionCategoryTableData copyWith({
    int? id,
    String? label,
    Value<String?> description = const Value.absent(),
  }) => QuestionCategoryTableData(
    id: id ?? this.id,
    label: label ?? this.label,
    description: description.present ? description.value : this.description,
  );
  QuestionCategoryTableData copyWithCompanion(
    QuestionCategoryTableCompanion data,
  ) {
    return QuestionCategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionCategoryTableData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionCategoryTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.description == this.description);
}

class QuestionCategoryTableCompanion
    extends UpdateCompanion<QuestionCategoryTableData> {
  final Value<int> id;
  final Value<String> label;
  final Value<String?> description;
  const QuestionCategoryTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.description = const Value.absent(),
  });
  QuestionCategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    this.description = const Value.absent(),
  }) : label = Value(label);
  static Insertable<QuestionCategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (description != null) 'description': description,
    });
  }

  QuestionCategoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<String?>? description,
  }) {
    return QuestionCategoryTableCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionCategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $LicenseQuestionCategoryTableTable extends LicenseQuestionCategoryTable
    with
        TableInfo<
          $LicenseQuestionCategoryTableTable,
          LicenseQuestionCategoryTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LicenseQuestionCategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _licenseIdMeta = const VerificationMeta(
    'licenseId',
  );
  @override
  late final GeneratedColumn<int> licenseId = GeneratedColumn<int>(
    'license_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES license_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _questionCategoryIdMeta =
      const VerificationMeta('questionCategoryId');
  @override
  late final GeneratedColumn<int> questionCategoryId = GeneratedColumn<int>(
    'question_category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES question_category_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [licenseId, questionCategoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'license_question_category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LicenseQuestionCategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('license_id')) {
      context.handle(
        _licenseIdMeta,
        licenseId.isAcceptableOrUnknown(data['license_id']!, _licenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseIdMeta);
    }
    if (data.containsKey('question_category_id')) {
      context.handle(
        _questionCategoryIdMeta,
        questionCategoryId.isAcceptableOrUnknown(
          data['question_category_id']!,
          _questionCategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionCategoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LicenseQuestionCategoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LicenseQuestionCategoryTableData(
      licenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}license_id'],
      )!,
      questionCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_category_id'],
      )!,
    );
  }

  @override
  $LicenseQuestionCategoryTableTable createAlias(String alias) {
    return $LicenseQuestionCategoryTableTable(attachedDatabase, alias);
  }
}

class LicenseQuestionCategoryTableData extends DataClass
    implements Insertable<LicenseQuestionCategoryTableData> {
  final int licenseId;
  final int questionCategoryId;
  const LicenseQuestionCategoryTableData({
    required this.licenseId,
    required this.questionCategoryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['license_id'] = Variable<int>(licenseId);
    map['question_category_id'] = Variable<int>(questionCategoryId);
    return map;
  }

  LicenseQuestionCategoryTableCompanion toCompanion(bool nullToAbsent) {
    return LicenseQuestionCategoryTableCompanion(
      licenseId: Value(licenseId),
      questionCategoryId: Value(questionCategoryId),
    );
  }

  factory LicenseQuestionCategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LicenseQuestionCategoryTableData(
      licenseId: serializer.fromJson<int>(json['licenseId']),
      questionCategoryId: serializer.fromJson<int>(json['questionCategoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'licenseId': serializer.toJson<int>(licenseId),
      'questionCategoryId': serializer.toJson<int>(questionCategoryId),
    };
  }

  LicenseQuestionCategoryTableData copyWith({
    int? licenseId,
    int? questionCategoryId,
  }) => LicenseQuestionCategoryTableData(
    licenseId: licenseId ?? this.licenseId,
    questionCategoryId: questionCategoryId ?? this.questionCategoryId,
  );
  LicenseQuestionCategoryTableData copyWithCompanion(
    LicenseQuestionCategoryTableCompanion data,
  ) {
    return LicenseQuestionCategoryTableData(
      licenseId: data.licenseId.present ? data.licenseId.value : this.licenseId,
      questionCategoryId: data.questionCategoryId.present
          ? data.questionCategoryId.value
          : this.questionCategoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LicenseQuestionCategoryTableData(')
          ..write('licenseId: $licenseId, ')
          ..write('questionCategoryId: $questionCategoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(licenseId, questionCategoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LicenseQuestionCategoryTableData &&
          other.licenseId == this.licenseId &&
          other.questionCategoryId == this.questionCategoryId);
}

class LicenseQuestionCategoryTableCompanion
    extends UpdateCompanion<LicenseQuestionCategoryTableData> {
  final Value<int> licenseId;
  final Value<int> questionCategoryId;
  final Value<int> rowid;
  const LicenseQuestionCategoryTableCompanion({
    this.licenseId = const Value.absent(),
    this.questionCategoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LicenseQuestionCategoryTableCompanion.insert({
    required int licenseId,
    required int questionCategoryId,
    this.rowid = const Value.absent(),
  }) : licenseId = Value(licenseId),
       questionCategoryId = Value(questionCategoryId);
  static Insertable<LicenseQuestionCategoryTableData> custom({
    Expression<int>? licenseId,
    Expression<int>? questionCategoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (licenseId != null) 'license_id': licenseId,
      if (questionCategoryId != null)
        'question_category_id': questionCategoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LicenseQuestionCategoryTableCompanion copyWith({
    Value<int>? licenseId,
    Value<int>? questionCategoryId,
    Value<int>? rowid,
  }) {
    return LicenseQuestionCategoryTableCompanion(
      licenseId: licenseId ?? this.licenseId,
      questionCategoryId: questionCategoryId ?? this.questionCategoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (licenseId.present) {
      map['license_id'] = Variable<int>(licenseId.value);
    }
    if (questionCategoryId.present) {
      map['question_category_id'] = Variable<int>(questionCategoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LicenseQuestionCategoryTableCompanion(')
          ..write('licenseId: $licenseId, ')
          ..write('questionCategoryId: $questionCategoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionTableTable extends QuestionTable
    with TableInfo<$QuestionTableTable, QuestionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _imageIdMeta = const VerificationMeta(
    'imageId',
  );
  @override
  late final GeneratedColumn<String> imageId = GeneratedColumn<String>(
    'image_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCriticalMeta = const VerificationMeta(
    'isCritical',
  );
  @override
  late final GeneratedColumn<bool> isCritical = GeneratedColumn<bool>(
    'is_critical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_critical" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES question_category_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageId,
    content,
    explanation,
    isCritical,
    categoryId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(
        _imageIdMeta,
        imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('is_critical')) {
      context.handle(
        _isCriticalMeta,
        isCritical.isAcceptableOrUnknown(data['is_critical']!, _isCriticalMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_id'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      isCritical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_critical'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $QuestionTableTable createAlias(String alias) {
    return $QuestionTableTable(attachedDatabase, alias);
  }
}

class QuestionTableData extends DataClass
    implements Insertable<QuestionTableData> {
  final int id;
  final String? imageId;
  final String content;
  final String? explanation;
  final bool isCritical;
  final int categoryId;
  const QuestionTableData({
    required this.id,
    this.imageId,
    required this.content,
    this.explanation,
    required this.isCritical,
    required this.categoryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['is_critical'] = Variable<bool>(isCritical);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  QuestionTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionTableCompanion(
      id: Value(id),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      content: Value(content),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      isCritical: Value(isCritical),
      categoryId: Value(categoryId),
    );
  }

  factory QuestionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionTableData(
      id: serializer.fromJson<int>(json['id']),
      imageId: serializer.fromJson<String?>(json['imageId']),
      content: serializer.fromJson<String>(json['content']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      isCritical: serializer.fromJson<bool>(json['isCritical']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageId': serializer.toJson<String?>(imageId),
      'content': serializer.toJson<String>(content),
      'explanation': serializer.toJson<String?>(explanation),
      'isCritical': serializer.toJson<bool>(isCritical),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  QuestionTableData copyWith({
    int? id,
    Value<String?> imageId = const Value.absent(),
    String? content,
    Value<String?> explanation = const Value.absent(),
    bool? isCritical,
    int? categoryId,
  }) => QuestionTableData(
    id: id ?? this.id,
    imageId: imageId.present ? imageId.value : this.imageId,
    content: content ?? this.content,
    explanation: explanation.present ? explanation.value : this.explanation,
    isCritical: isCritical ?? this.isCritical,
    categoryId: categoryId ?? this.categoryId,
  );
  QuestionTableData copyWithCompanion(QuestionTableCompanion data) {
    return QuestionTableData(
      id: data.id.present ? data.id.value : this.id,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      content: data.content.present ? data.content.value : this.content,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      isCritical: data.isCritical.present
          ? data.isCritical.value
          : this.isCritical,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTableData(')
          ..write('id: $id, ')
          ..write('imageId: $imageId, ')
          ..write('content: $content, ')
          ..write('explanation: $explanation, ')
          ..write('isCritical: $isCritical, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, imageId, content, explanation, isCritical, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionTableData &&
          other.id == this.id &&
          other.imageId == this.imageId &&
          other.content == this.content &&
          other.explanation == this.explanation &&
          other.isCritical == this.isCritical &&
          other.categoryId == this.categoryId);
}

class QuestionTableCompanion extends UpdateCompanion<QuestionTableData> {
  final Value<int> id;
  final Value<String?> imageId;
  final Value<String> content;
  final Value<String?> explanation;
  final Value<bool> isCritical;
  final Value<int> categoryId;
  const QuestionTableCompanion({
    this.id = const Value.absent(),
    this.imageId = const Value.absent(),
    this.content = const Value.absent(),
    this.explanation = const Value.absent(),
    this.isCritical = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  QuestionTableCompanion.insert({
    this.id = const Value.absent(),
    this.imageId = const Value.absent(),
    required String content,
    this.explanation = const Value.absent(),
    this.isCritical = const Value.absent(),
    required int categoryId,
  }) : content = Value(content),
       categoryId = Value(categoryId);
  static Insertable<QuestionTableData> custom({
    Expression<int>? id,
    Expression<String>? imageId,
    Expression<String>? content,
    Expression<String>? explanation,
    Expression<bool>? isCritical,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageId != null) 'image_id': imageId,
      if (content != null) 'content': content,
      if (explanation != null) 'explanation': explanation,
      if (isCritical != null) 'is_critical': isCritical,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  QuestionTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? imageId,
    Value<String>? content,
    Value<String?>? explanation,
    Value<bool>? isCritical,
    Value<int>? categoryId,
  }) {
    return QuestionTableCompanion(
      id: id ?? this.id,
      imageId: imageId ?? this.imageId,
      content: content ?? this.content,
      explanation: explanation ?? this.explanation,
      isCritical: isCritical ?? this.isCritical,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (isCritical.present) {
      map['is_critical'] = Variable<bool>(isCritical.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionTableCompanion(')
          ..write('id: $id, ')
          ..write('imageId: $imageId, ')
          ..write('content: $content, ')
          ..write('explanation: $explanation, ')
          ..write('isCritical: $isCritical, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $QuestionOptionTableTable extends QuestionOptionTable
    with TableInfo<$QuestionOptionTableTable, QuestionOptionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionOptionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES question_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, questionId, isCorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_option_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionOptionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionOptionTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionOptionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_id'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
    );
  }

  @override
  $QuestionOptionTableTable createAlias(String alias) {
    return $QuestionOptionTableTable(attachedDatabase, alias);
  }
}

class QuestionOptionTableData extends DataClass
    implements Insertable<QuestionOptionTableData> {
  final int id;
  final String content;
  final int questionId;
  final bool isCorrect;
  const QuestionOptionTableData({
    required this.id,
    required this.content,
    required this.questionId,
    required this.isCorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['question_id'] = Variable<int>(questionId);
    map['is_correct'] = Variable<bool>(isCorrect);
    return map;
  }

  QuestionOptionTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionOptionTableCompanion(
      id: Value(id),
      content: Value(content),
      questionId: Value(questionId),
      isCorrect: Value(isCorrect),
    );
  }

  factory QuestionOptionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionOptionTableData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      questionId: serializer.fromJson<int>(json['questionId']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'questionId': serializer.toJson<int>(questionId),
      'isCorrect': serializer.toJson<bool>(isCorrect),
    };
  }

  QuestionOptionTableData copyWith({
    int? id,
    String? content,
    int? questionId,
    bool? isCorrect,
  }) => QuestionOptionTableData(
    id: id ?? this.id,
    content: content ?? this.content,
    questionId: questionId ?? this.questionId,
    isCorrect: isCorrect ?? this.isCorrect,
  );
  QuestionOptionTableData copyWithCompanion(QuestionOptionTableCompanion data) {
    return QuestionOptionTableData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOptionTableData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, questionId, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionOptionTableData &&
          other.id == this.id &&
          other.content == this.content &&
          other.questionId == this.questionId &&
          other.isCorrect == this.isCorrect);
}

class QuestionOptionTableCompanion
    extends UpdateCompanion<QuestionOptionTableData> {
  final Value<int> id;
  final Value<String> content;
  final Value<int> questionId;
  final Value<bool> isCorrect;
  const QuestionOptionTableCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.questionId = const Value.absent(),
    this.isCorrect = const Value.absent(),
  });
  QuestionOptionTableCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required int questionId,
    this.isCorrect = const Value.absent(),
  }) : content = Value(content),
       questionId = Value(questionId);
  static Insertable<QuestionOptionTableData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<int>? questionId,
    Expression<bool>? isCorrect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (questionId != null) 'question_id': questionId,
      if (isCorrect != null) 'is_correct': isCorrect,
    });
  }

  QuestionOptionTableCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<int>? questionId,
    Value<bool>? isCorrect,
  }) {
    return QuestionOptionTableCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      questionId: questionId ?? this.questionId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOptionTableCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LicenseTableTable licenseTable = $LicenseTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $QuestionCategoryTableTable questionCategoryTable =
      $QuestionCategoryTableTable(this);
  late final $LicenseQuestionCategoryTableTable licenseQuestionCategoryTable =
      $LicenseQuestionCategoryTableTable(this);
  late final $QuestionTableTable questionTable = $QuestionTableTable(this);
  late final $QuestionOptionTableTable questionOptionTable =
      $QuestionOptionTableTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final LicenseDao licenseDao = LicenseDao(this as AppDatabase);
  late final QuestionCategoryDao questionCategoryDao = QuestionCategoryDao(
    this as AppDatabase,
  );
  late final QuestionDao questionDao = QuestionDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    licenseTable,
    userTable,
    questionCategoryTable,
    licenseQuestionCategoryTable,
    questionTable,
    questionOptionTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'license_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('license_question_category_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'question_category_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('license_question_category_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'question_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('question_option_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$LicenseTableTableCreateCompanionBuilder =
    LicenseTableCompanion Function({
      Value<int> id,
      required LicenseType code,
      required String description,
    });
typedef $$LicenseTableTableUpdateCompanionBuilder =
    LicenseTableCompanion Function({
      Value<int> id,
      Value<LicenseType> code,
      Value<String> description,
    });

final class $$LicenseTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $LicenseTableTable, LicenseTableData> {
  $$LicenseTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserTableTable, List<UserTableData>>
  _userTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userTable,
    aliasName: $_aliasNameGenerator(db.licenseTable.id, db.userTable.licenseId),
  );

  $$UserTableTableProcessedTableManager get userTableRefs {
    final manager = $$UserTableTableTableManager(
      $_db,
      $_db.userTable,
    ).filter((f) => f.licenseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LicenseQuestionCategoryTableTable,
    List<LicenseQuestionCategoryTableData>
  >
  _licenseQuestionCategoryTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.licenseQuestionCategoryTable,
        aliasName: $_aliasNameGenerator(
          db.licenseTable.id,
          db.licenseQuestionCategoryTable.licenseId,
        ),
      );

  $$LicenseQuestionCategoryTableTableProcessedTableManager
  get licenseQuestionCategoryTableRefs {
    final manager = $$LicenseQuestionCategoryTableTableTableManager(
      $_db,
      $_db.licenseQuestionCategoryTable,
    ).filter((f) => f.licenseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _licenseQuestionCategoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LicenseTableTableFilterComposer
    extends Composer<_$AppDatabase, $LicenseTableTable> {
  $$LicenseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LicenseType, LicenseType, String> get code =>
      $composableBuilder(
        column: $table.code,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userTableRefs(
    Expression<bool> Function($$UserTableTableFilterComposer f) f,
  ) {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.licenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableFilterComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> licenseQuestionCategoryTableRefs(
    Expression<bool> Function(
      $$LicenseQuestionCategoryTableTableFilterComposer f,
    )
    f,
  ) {
    final $$LicenseQuestionCategoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.licenseQuestionCategoryTable,
          getReferencedColumn: (t) => t.licenseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LicenseQuestionCategoryTableTableFilterComposer(
                $db: $db,
                $table: $db.licenseQuestionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LicenseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LicenseTableTable> {
  $$LicenseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LicenseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LicenseTableTable> {
  $$LicenseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LicenseType, String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> userTableRefs<T extends Object>(
    Expression<T> Function($$UserTableTableAnnotationComposer a) f,
  ) {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.licenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> licenseQuestionCategoryTableRefs<T extends Object>(
    Expression<T> Function(
      $$LicenseQuestionCategoryTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$LicenseQuestionCategoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.licenseQuestionCategoryTable,
          getReferencedColumn: (t) => t.licenseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LicenseQuestionCategoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.licenseQuestionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LicenseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LicenseTableTable,
          LicenseTableData,
          $$LicenseTableTableFilterComposer,
          $$LicenseTableTableOrderingComposer,
          $$LicenseTableTableAnnotationComposer,
          $$LicenseTableTableCreateCompanionBuilder,
          $$LicenseTableTableUpdateCompanionBuilder,
          (LicenseTableData, $$LicenseTableTableReferences),
          LicenseTableData,
          PrefetchHooks Function({
            bool userTableRefs,
            bool licenseQuestionCategoryTableRefs,
          })
        > {
  $$LicenseTableTableTableManager(_$AppDatabase db, $LicenseTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LicenseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LicenseTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LicenseTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<LicenseType> code = const Value.absent(),
                Value<String> description = const Value.absent(),
              }) => LicenseTableCompanion(
                id: id,
                code: code,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required LicenseType code,
                required String description,
              }) => LicenseTableCompanion.insert(
                id: id,
                code: code,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LicenseTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userTableRefs = false,
                licenseQuestionCategoryTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userTableRefs) db.userTable,
                    if (licenseQuestionCategoryTableRefs)
                      db.licenseQuestionCategoryTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userTableRefs)
                        await $_getPrefetchedData<
                          LicenseTableData,
                          $LicenseTableTable,
                          UserTableData
                        >(
                          currentTable: table,
                          referencedTable: $$LicenseTableTableReferences
                              ._userTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LicenseTableTableReferences(
                                db,
                                table,
                                p0,
                              ).userTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.licenseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (licenseQuestionCategoryTableRefs)
                        await $_getPrefetchedData<
                          LicenseTableData,
                          $LicenseTableTable,
                          LicenseQuestionCategoryTableData
                        >(
                          currentTable: table,
                          referencedTable: $$LicenseTableTableReferences
                              ._licenseQuestionCategoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LicenseTableTableReferences(
                                db,
                                table,
                                p0,
                              ).licenseQuestionCategoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.licenseId == item.id,
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

typedef $$LicenseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LicenseTableTable,
      LicenseTableData,
      $$LicenseTableTableFilterComposer,
      $$LicenseTableTableOrderingComposer,
      $$LicenseTableTableAnnotationComposer,
      $$LicenseTableTableCreateCompanionBuilder,
      $$LicenseTableTableUpdateCompanionBuilder,
      (LicenseTableData, $$LicenseTableTableReferences),
      LicenseTableData,
      PrefetchHooks Function({
        bool userTableRefs,
        bool licenseQuestionCategoryTableRefs,
      })
    >;
typedef $$UserTableTableCreateCompanionBuilder =
    UserTableCompanion Function({
      Value<int> id,
      required int licenseId,
      required String name,
      required int age,
      Value<int> gender,
      Value<String?> avatarPath,
      Value<String?> phoneNumber,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserTableTableUpdateCompanionBuilder =
    UserTableCompanion Function({
      Value<int> id,
      Value<int> licenseId,
      Value<String> name,
      Value<int> age,
      Value<int> gender,
      Value<String?> avatarPath,
      Value<String?> phoneNumber,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserTableTableReferences
    extends BaseReferences<_$AppDatabase, $UserTableTable, UserTableData> {
  $$UserTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LicenseTableTable _licenseIdTable(_$AppDatabase db) =>
      db.licenseTable.createAlias(
        $_aliasNameGenerator(db.userTable.licenseId, db.licenseTable.id),
      );

  $$LicenseTableTableProcessedTableManager get licenseId {
    final $_column = $_itemColumn<int>('license_id')!;

    final manager = $$LicenseTableTableTableManager(
      $_db,
      $_db.licenseTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_licenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
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

  $$LicenseTableTableFilterComposer get licenseId {
    final $$LicenseTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableFilterComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
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

  $$LicenseTableTableOrderingComposer get licenseId {
    final $$LicenseTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableOrderingComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<int> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LicenseTableTableAnnotationComposer get licenseId {
    final $$LicenseTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableAnnotationComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTableTable,
          UserTableData,
          $$UserTableTableFilterComposer,
          $$UserTableTableOrderingComposer,
          $$UserTableTableAnnotationComposer,
          $$UserTableTableCreateCompanionBuilder,
          $$UserTableTableUpdateCompanionBuilder,
          (UserTableData, $$UserTableTableReferences),
          UserTableData,
          PrefetchHooks Function({bool licenseId})
        > {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> licenseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<int> gender = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserTableCompanion(
                id: id,
                licenseId: licenseId,
                name: name,
                age: age,
                gender: gender,
                avatarPath: avatarPath,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int licenseId,
                required String name,
                required int age,
                Value<int> gender = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserTableCompanion.insert(
                id: id,
                licenseId: licenseId,
                name: name,
                age: age,
                gender: gender,
                avatarPath: avatarPath,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({licenseId = false}) {
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
                    if (licenseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.licenseId,
                                referencedTable: $$UserTableTableReferences
                                    ._licenseIdTable(db),
                                referencedColumn: $$UserTableTableReferences
                                    ._licenseIdTable(db)
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

typedef $$UserTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTableTable,
      UserTableData,
      $$UserTableTableFilterComposer,
      $$UserTableTableOrderingComposer,
      $$UserTableTableAnnotationComposer,
      $$UserTableTableCreateCompanionBuilder,
      $$UserTableTableUpdateCompanionBuilder,
      (UserTableData, $$UserTableTableReferences),
      UserTableData,
      PrefetchHooks Function({bool licenseId})
    >;
typedef $$QuestionCategoryTableTableCreateCompanionBuilder =
    QuestionCategoryTableCompanion Function({
      Value<int> id,
      required String label,
      Value<String?> description,
    });
typedef $$QuestionCategoryTableTableUpdateCompanionBuilder =
    QuestionCategoryTableCompanion Function({
      Value<int> id,
      Value<String> label,
      Value<String?> description,
    });

final class $$QuestionCategoryTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionCategoryTableTable,
          QuestionCategoryTableData
        > {
  $$QuestionCategoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $LicenseQuestionCategoryTableTable,
    List<LicenseQuestionCategoryTableData>
  >
  _licenseQuestionCategoryTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.licenseQuestionCategoryTable,
        aliasName: $_aliasNameGenerator(
          db.questionCategoryTable.id,
          db.licenseQuestionCategoryTable.questionCategoryId,
        ),
      );

  $$LicenseQuestionCategoryTableTableProcessedTableManager
  get licenseQuestionCategoryTableRefs {
    final manager =
        $$LicenseQuestionCategoryTableTableTableManager(
          $_db,
          $_db.licenseQuestionCategoryTable,
        ).filter(
          (f) => f.questionCategoryId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _licenseQuestionCategoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestionTableTable, List<QuestionTableData>>
  _questionTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questionTable,
    aliasName: $_aliasNameGenerator(
      db.questionCategoryTable.id,
      db.questionTable.categoryId,
    ),
  );

  $$QuestionTableTableProcessedTableManager get questionTableRefs {
    final manager = $$QuestionTableTableTableManager(
      $_db,
      $_db.questionTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionCategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionCategoryTableTable> {
  $$QuestionCategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> licenseQuestionCategoryTableRefs(
    Expression<bool> Function(
      $$LicenseQuestionCategoryTableTableFilterComposer f,
    )
    f,
  ) {
    final $$LicenseQuestionCategoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.licenseQuestionCategoryTable,
          getReferencedColumn: (t) => t.questionCategoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LicenseQuestionCategoryTableTableFilterComposer(
                $db: $db,
                $table: $db.licenseQuestionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> questionTableRefs(
    Expression<bool> Function($$QuestionTableTableFilterComposer f) f,
  ) {
    final $$QuestionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTableTableFilterComposer(
            $db: $db,
            $table: $db.questionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionCategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionCategoryTableTable> {
  $$QuestionCategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionCategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionCategoryTableTable> {
  $$QuestionCategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> licenseQuestionCategoryTableRefs<T extends Object>(
    Expression<T> Function(
      $$LicenseQuestionCategoryTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$LicenseQuestionCategoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.licenseQuestionCategoryTable,
          getReferencedColumn: (t) => t.questionCategoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LicenseQuestionCategoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.licenseQuestionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> questionTableRefs<T extends Object>(
    Expression<T> Function($$QuestionTableTableAnnotationComposer a) f,
  ) {
    final $$QuestionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.questionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionCategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionCategoryTableTable,
          QuestionCategoryTableData,
          $$QuestionCategoryTableTableFilterComposer,
          $$QuestionCategoryTableTableOrderingComposer,
          $$QuestionCategoryTableTableAnnotationComposer,
          $$QuestionCategoryTableTableCreateCompanionBuilder,
          $$QuestionCategoryTableTableUpdateCompanionBuilder,
          (QuestionCategoryTableData, $$QuestionCategoryTableTableReferences),
          QuestionCategoryTableData,
          PrefetchHooks Function({
            bool licenseQuestionCategoryTableRefs,
            bool questionTableRefs,
          })
        > {
  $$QuestionCategoryTableTableTableManager(
    _$AppDatabase db,
    $QuestionCategoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionCategoryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$QuestionCategoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuestionCategoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => QuestionCategoryTableCompanion(
                id: id,
                label: label,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                Value<String?> description = const Value.absent(),
              }) => QuestionCategoryTableCompanion.insert(
                id: id,
                label: label,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionCategoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                licenseQuestionCategoryTableRefs = false,
                questionTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (licenseQuestionCategoryTableRefs)
                      db.licenseQuestionCategoryTable,
                    if (questionTableRefs) db.questionTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (licenseQuestionCategoryTableRefs)
                        await $_getPrefetchedData<
                          QuestionCategoryTableData,
                          $QuestionCategoryTableTable,
                          LicenseQuestionCategoryTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$QuestionCategoryTableTableReferences
                                  ._licenseQuestionCategoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionCategoryTableTableReferences(
                                db,
                                table,
                                p0,
                              ).licenseQuestionCategoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionCategoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questionTableRefs)
                        await $_getPrefetchedData<
                          QuestionCategoryTableData,
                          $QuestionCategoryTableTable,
                          QuestionTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$QuestionCategoryTableTableReferences
                                  ._questionTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionCategoryTableTableReferences(
                                db,
                                table,
                                p0,
                              ).questionTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
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

typedef $$QuestionCategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionCategoryTableTable,
      QuestionCategoryTableData,
      $$QuestionCategoryTableTableFilterComposer,
      $$QuestionCategoryTableTableOrderingComposer,
      $$QuestionCategoryTableTableAnnotationComposer,
      $$QuestionCategoryTableTableCreateCompanionBuilder,
      $$QuestionCategoryTableTableUpdateCompanionBuilder,
      (QuestionCategoryTableData, $$QuestionCategoryTableTableReferences),
      QuestionCategoryTableData,
      PrefetchHooks Function({
        bool licenseQuestionCategoryTableRefs,
        bool questionTableRefs,
      })
    >;
typedef $$LicenseQuestionCategoryTableTableCreateCompanionBuilder =
    LicenseQuestionCategoryTableCompanion Function({
      required int licenseId,
      required int questionCategoryId,
      Value<int> rowid,
    });
typedef $$LicenseQuestionCategoryTableTableUpdateCompanionBuilder =
    LicenseQuestionCategoryTableCompanion Function({
      Value<int> licenseId,
      Value<int> questionCategoryId,
      Value<int> rowid,
    });

final class $$LicenseQuestionCategoryTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LicenseQuestionCategoryTableTable,
          LicenseQuestionCategoryTableData
        > {
  $$LicenseQuestionCategoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LicenseTableTable _licenseIdTable(_$AppDatabase db) =>
      db.licenseTable.createAlias(
        $_aliasNameGenerator(
          db.licenseQuestionCategoryTable.licenseId,
          db.licenseTable.id,
        ),
      );

  $$LicenseTableTableProcessedTableManager get licenseId {
    final $_column = $_itemColumn<int>('license_id')!;

    final manager = $$LicenseTableTableTableManager(
      $_db,
      $_db.licenseTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_licenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $QuestionCategoryTableTable _questionCategoryIdTable(
    _$AppDatabase db,
  ) => db.questionCategoryTable.createAlias(
    $_aliasNameGenerator(
      db.licenseQuestionCategoryTable.questionCategoryId,
      db.questionCategoryTable.id,
    ),
  );

  $$QuestionCategoryTableTableProcessedTableManager get questionCategoryId {
    final $_column = $_itemColumn<int>('question_category_id')!;

    final manager = $$QuestionCategoryTableTableTableManager(
      $_db,
      $_db.questionCategoryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LicenseQuestionCategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $LicenseQuestionCategoryTableTable> {
  $$LicenseQuestionCategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LicenseTableTableFilterComposer get licenseId {
    final $$LicenseTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableFilterComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionCategoryTableTableFilterComposer get questionCategoryId {
    final $$QuestionCategoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.questionCategoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableFilterComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LicenseQuestionCategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LicenseQuestionCategoryTableTable> {
  $$LicenseQuestionCategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LicenseTableTableOrderingComposer get licenseId {
    final $$LicenseTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableOrderingComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionCategoryTableTableOrderingComposer get questionCategoryId {
    final $$QuestionCategoryTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.questionCategoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableOrderingComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LicenseQuestionCategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LicenseQuestionCategoryTableTable> {
  $$LicenseQuestionCategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LicenseTableTableAnnotationComposer get licenseId {
    final $$LicenseTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.licenseId,
      referencedTable: $db.licenseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LicenseTableTableAnnotationComposer(
            $db: $db,
            $table: $db.licenseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuestionCategoryTableTableAnnotationComposer get questionCategoryId {
    final $$QuestionCategoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.questionCategoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LicenseQuestionCategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LicenseQuestionCategoryTableTable,
          LicenseQuestionCategoryTableData,
          $$LicenseQuestionCategoryTableTableFilterComposer,
          $$LicenseQuestionCategoryTableTableOrderingComposer,
          $$LicenseQuestionCategoryTableTableAnnotationComposer,
          $$LicenseQuestionCategoryTableTableCreateCompanionBuilder,
          $$LicenseQuestionCategoryTableTableUpdateCompanionBuilder,
          (
            LicenseQuestionCategoryTableData,
            $$LicenseQuestionCategoryTableTableReferences,
          ),
          LicenseQuestionCategoryTableData,
          PrefetchHooks Function({bool licenseId, bool questionCategoryId})
        > {
  $$LicenseQuestionCategoryTableTableTableManager(
    _$AppDatabase db,
    $LicenseQuestionCategoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LicenseQuestionCategoryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LicenseQuestionCategoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LicenseQuestionCategoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> licenseId = const Value.absent(),
                Value<int> questionCategoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LicenseQuestionCategoryTableCompanion(
                licenseId: licenseId,
                questionCategoryId: questionCategoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int licenseId,
                required int questionCategoryId,
                Value<int> rowid = const Value.absent(),
              }) => LicenseQuestionCategoryTableCompanion.insert(
                licenseId: licenseId,
                questionCategoryId: questionCategoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LicenseQuestionCategoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({licenseId = false, questionCategoryId = false}) {
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
                    if (licenseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.licenseId,
                                referencedTable:
                                    $$LicenseQuestionCategoryTableTableReferences
                                        ._licenseIdTable(db),
                                referencedColumn:
                                    $$LicenseQuestionCategoryTableTableReferences
                                        ._licenseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (questionCategoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionCategoryId,
                                referencedTable:
                                    $$LicenseQuestionCategoryTableTableReferences
                                        ._questionCategoryIdTable(db),
                                referencedColumn:
                                    $$LicenseQuestionCategoryTableTableReferences
                                        ._questionCategoryIdTable(db)
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

typedef $$LicenseQuestionCategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LicenseQuestionCategoryTableTable,
      LicenseQuestionCategoryTableData,
      $$LicenseQuestionCategoryTableTableFilterComposer,
      $$LicenseQuestionCategoryTableTableOrderingComposer,
      $$LicenseQuestionCategoryTableTableAnnotationComposer,
      $$LicenseQuestionCategoryTableTableCreateCompanionBuilder,
      $$LicenseQuestionCategoryTableTableUpdateCompanionBuilder,
      (
        LicenseQuestionCategoryTableData,
        $$LicenseQuestionCategoryTableTableReferences,
      ),
      LicenseQuestionCategoryTableData,
      PrefetchHooks Function({bool licenseId, bool questionCategoryId})
    >;
typedef $$QuestionTableTableCreateCompanionBuilder =
    QuestionTableCompanion Function({
      Value<int> id,
      Value<String?> imageId,
      required String content,
      Value<String?> explanation,
      Value<bool> isCritical,
      required int categoryId,
    });
typedef $$QuestionTableTableUpdateCompanionBuilder =
    QuestionTableCompanion Function({
      Value<int> id,
      Value<String?> imageId,
      Value<String> content,
      Value<String?> explanation,
      Value<bool> isCritical,
      Value<int> categoryId,
    });

final class $$QuestionTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuestionTableTable, QuestionTableData> {
  $$QuestionTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionCategoryTableTable _categoryIdTable(_$AppDatabase db) =>
      db.questionCategoryTable.createAlias(
        $_aliasNameGenerator(
          db.questionTable.categoryId,
          db.questionCategoryTable.id,
        ),
      );

  $$QuestionCategoryTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$QuestionCategoryTableTableTableManager(
      $_db,
      $_db.questionCategoryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $QuestionOptionTableTable,
    List<QuestionOptionTableData>
  >
  _questionOptionTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.questionOptionTable,
        aliasName: $_aliasNameGenerator(
          db.questionTable.id,
          db.questionOptionTable.questionId,
        ),
      );

  $$QuestionOptionTableTableProcessedTableManager get questionOptionTableRefs {
    final manager = $$QuestionOptionTableTableTableManager(
      $_db,
      $_db.questionOptionTable,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _questionOptionTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageId => $composableBuilder(
    column: $table.imageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionCategoryTableTableFilterComposer get categoryId {
    final $$QuestionCategoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableFilterComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> questionOptionTableRefs(
    Expression<bool> Function($$QuestionOptionTableTableFilterComposer f) f,
  ) {
    final $$QuestionOptionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questionOptionTable,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionOptionTableTableFilterComposer(
            $db: $db,
            $table: $db.questionOptionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageId => $composableBuilder(
    column: $table.imageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionCategoryTableTableOrderingComposer get categoryId {
    final $$QuestionCategoryTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableOrderingComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$QuestionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionTableTable> {
  $$QuestionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageId =>
      $composableBuilder(column: $table.imageId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => column,
  );

  $$QuestionCategoryTableTableAnnotationComposer get categoryId {
    final $$QuestionCategoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.questionCategoryTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionCategoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.questionCategoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> questionOptionTableRefs<T extends Object>(
    Expression<T> Function($$QuestionOptionTableTableAnnotationComposer a) f,
  ) {
    final $$QuestionOptionTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.questionOptionTable,
          getReferencedColumn: (t) => t.questionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$QuestionOptionTableTableAnnotationComposer(
                $db: $db,
                $table: $db.questionOptionTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$QuestionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionTableTable,
          QuestionTableData,
          $$QuestionTableTableFilterComposer,
          $$QuestionTableTableOrderingComposer,
          $$QuestionTableTableAnnotationComposer,
          $$QuestionTableTableCreateCompanionBuilder,
          $$QuestionTableTableUpdateCompanionBuilder,
          (QuestionTableData, $$QuestionTableTableReferences),
          QuestionTableData,
          PrefetchHooks Function({
            bool categoryId,
            bool questionOptionTableRefs,
          })
        > {
  $$QuestionTableTableTableManager(_$AppDatabase db, $QuestionTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> imageId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<bool> isCritical = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
              }) => QuestionTableCompanion(
                id: id,
                imageId: imageId,
                content: content,
                explanation: explanation,
                isCritical: isCritical,
                categoryId: categoryId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> imageId = const Value.absent(),
                required String content,
                Value<String?> explanation = const Value.absent(),
                Value<bool> isCritical = const Value.absent(),
                required int categoryId,
              }) => QuestionTableCompanion.insert(
                id: id,
                imageId: imageId,
                content: content,
                explanation: explanation,
                isCritical: isCritical,
                categoryId: categoryId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, questionOptionTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionOptionTableRefs) db.questionOptionTable,
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
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$QuestionTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$QuestionTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionOptionTableRefs)
                        await $_getPrefetchedData<
                          QuestionTableData,
                          $QuestionTableTable,
                          QuestionOptionTableData
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionTableTableReferences
                              ._questionOptionTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionTableTableReferences(
                                db,
                                table,
                                p0,
                              ).questionOptionTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
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

typedef $$QuestionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionTableTable,
      QuestionTableData,
      $$QuestionTableTableFilterComposer,
      $$QuestionTableTableOrderingComposer,
      $$QuestionTableTableAnnotationComposer,
      $$QuestionTableTableCreateCompanionBuilder,
      $$QuestionTableTableUpdateCompanionBuilder,
      (QuestionTableData, $$QuestionTableTableReferences),
      QuestionTableData,
      PrefetchHooks Function({bool categoryId, bool questionOptionTableRefs})
    >;
typedef $$QuestionOptionTableTableCreateCompanionBuilder =
    QuestionOptionTableCompanion Function({
      Value<int> id,
      required String content,
      required int questionId,
      Value<bool> isCorrect,
    });
typedef $$QuestionOptionTableTableUpdateCompanionBuilder =
    QuestionOptionTableCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<int> questionId,
      Value<bool> isCorrect,
    });

final class $$QuestionOptionTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $QuestionOptionTableTable,
          QuestionOptionTableData
        > {
  $$QuestionOptionTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuestionTableTable _questionIdTable(_$AppDatabase db) =>
      db.questionTable.createAlias(
        $_aliasNameGenerator(
          db.questionOptionTable.questionId,
          db.questionTable.id,
        ),
      );

  $$QuestionTableTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionTableTableTableManager(
      $_db,
      $_db.questionTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestionOptionTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionOptionTableTable> {
  $$QuestionOptionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionTableTableFilterComposer get questionId {
    final $$QuestionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTableTableFilterComposer(
            $db: $db,
            $table: $db.questionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionOptionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionOptionTableTable> {
  $$QuestionOptionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionTableTableOrderingComposer get questionId {
    final $$QuestionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTableTableOrderingComposer(
            $db: $db,
            $table: $db.questionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionOptionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionOptionTableTable> {
  $$QuestionOptionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  $$QuestionTableTableAnnotationComposer get questionId {
    final $$QuestionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.questionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionOptionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionOptionTableTable,
          QuestionOptionTableData,
          $$QuestionOptionTableTableFilterComposer,
          $$QuestionOptionTableTableOrderingComposer,
          $$QuestionOptionTableTableAnnotationComposer,
          $$QuestionOptionTableTableCreateCompanionBuilder,
          $$QuestionOptionTableTableUpdateCompanionBuilder,
          (QuestionOptionTableData, $$QuestionOptionTableTableReferences),
          QuestionOptionTableData,
          PrefetchHooks Function({bool questionId})
        > {
  $$QuestionOptionTableTableTableManager(
    _$AppDatabase db,
    $QuestionOptionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionOptionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionOptionTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuestionOptionTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> questionId = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
              }) => QuestionOptionTableCompanion(
                id: id,
                content: content,
                questionId: questionId,
                isCorrect: isCorrect,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                required int questionId,
                Value<bool> isCorrect = const Value.absent(),
              }) => QuestionOptionTableCompanion.insert(
                id: id,
                content: content,
                questionId: questionId,
                isCorrect: isCorrect,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionOptionTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
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
                    if (questionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionId,
                                referencedTable:
                                    $$QuestionOptionTableTableReferences
                                        ._questionIdTable(db),
                                referencedColumn:
                                    $$QuestionOptionTableTableReferences
                                        ._questionIdTable(db)
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

typedef $$QuestionOptionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionOptionTableTable,
      QuestionOptionTableData,
      $$QuestionOptionTableTableFilterComposer,
      $$QuestionOptionTableTableOrderingComposer,
      $$QuestionOptionTableTableAnnotationComposer,
      $$QuestionOptionTableTableCreateCompanionBuilder,
      $$QuestionOptionTableTableUpdateCompanionBuilder,
      (QuestionOptionTableData, $$QuestionOptionTableTableReferences),
      QuestionOptionTableData,
      PrefetchHooks Function({bool questionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LicenseTableTableTableManager get licenseTable =>
      $$LicenseTableTableTableManager(_db, _db.licenseTable);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$QuestionCategoryTableTableTableManager get questionCategoryTable =>
      $$QuestionCategoryTableTableTableManager(_db, _db.questionCategoryTable);
  $$LicenseQuestionCategoryTableTableTableManager
  get licenseQuestionCategoryTable =>
      $$LicenseQuestionCategoryTableTableTableManager(
        _db,
        _db.licenseQuestionCategoryTable,
      );
  $$QuestionTableTableTableManager get questionTable =>
      $$QuestionTableTableTableManager(_db, _db.questionTable);
  $$QuestionOptionTableTableTableManager get questionOptionTable =>
      $$QuestionOptionTableTableTableManager(_db, _db.questionOptionTable);
}
