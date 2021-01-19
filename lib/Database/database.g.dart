// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AddressTableData extends DataClass
    implements Insertable<AddressTableData> {
  final int id;
  final String accessToken;
  final String addressLine;
  final String city;
  final String state;
  final int zipcode;
  final String country;
  final String landmark;
  AddressTableData(
      {@required this.id,
      @required this.accessToken,
      @required this.addressLine,
      @required this.city,
      @required this.state,
      @required this.zipcode,
      @required this.country,
      @required this.landmark});
  factory AddressTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AddressTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      accessToken: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}access_token']),
      addressLine: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}address_line']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      state:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}state']),
      zipcode:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}zipcode']),
      country:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}country']),
      landmark: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}landmark']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || accessToken != null) {
      map['access_token'] = Variable<String>(accessToken);
    }
    if (!nullToAbsent || addressLine != null) {
      map['address_line'] = Variable<String>(addressLine);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || zipcode != null) {
      map['zipcode'] = Variable<int>(zipcode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || landmark != null) {
      map['landmark'] = Variable<String>(landmark);
    }
    return map;
  }

  AddressTableCompanion toCompanion(bool nullToAbsent) {
    return AddressTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      accessToken: accessToken == null && nullToAbsent
          ? const Value.absent()
          : Value(accessToken),
      addressLine: addressLine == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state:
          state == null && nullToAbsent ? const Value.absent() : Value(state),
      zipcode: zipcode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipcode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      landmark: landmark == null && nullToAbsent
          ? const Value.absent()
          : Value(landmark),
    );
  }

  factory AddressTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AddressTableData(
      id: serializer.fromJson<int>(json['id']),
      accessToken: serializer.fromJson<String>(json['accessToken']),
      addressLine: serializer.fromJson<String>(json['addressLine']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      zipcode: serializer.fromJson<int>(json['zipcode']),
      country: serializer.fromJson<String>(json['country']),
      landmark: serializer.fromJson<String>(json['landmark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accessToken': serializer.toJson<String>(accessToken),
      'addressLine': serializer.toJson<String>(addressLine),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'zipcode': serializer.toJson<int>(zipcode),
      'country': serializer.toJson<String>(country),
      'landmark': serializer.toJson<String>(landmark),
    };
  }

  AddressTableData copyWith(
          {int id,
          String accessToken,
          String addressLine,
          String city,
          String state,
          int zipcode,
          String country,
          String landmark}) =>
      AddressTableData(
        id: id ?? this.id,
        accessToken: accessToken ?? this.accessToken,
        addressLine: addressLine ?? this.addressLine,
        city: city ?? this.city,
        state: state ?? this.state,
        zipcode: zipcode ?? this.zipcode,
        country: country ?? this.country,
        landmark: landmark ?? this.landmark,
      );
  @override
  String toString() {
    return (StringBuffer('AddressTableData(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipcode: $zipcode, ')
          ..write('country: $country, ')
          ..write('landmark: $landmark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          accessToken.hashCode,
          $mrjc(
              addressLine.hashCode,
              $mrjc(
                  city.hashCode,
                  $mrjc(
                      state.hashCode,
                      $mrjc(zipcode.hashCode,
                          $mrjc(country.hashCode, landmark.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AddressTableData &&
          other.id == this.id &&
          other.accessToken == this.accessToken &&
          other.addressLine == this.addressLine &&
          other.city == this.city &&
          other.state == this.state &&
          other.zipcode == this.zipcode &&
          other.country == this.country &&
          other.landmark == this.landmark);
}

class AddressTableCompanion extends UpdateCompanion<AddressTableData> {
  final Value<int> id;
  final Value<String> accessToken;
  final Value<String> addressLine;
  final Value<String> city;
  final Value<String> state;
  final Value<int> zipcode;
  final Value<String> country;
  final Value<String> landmark;
  const AddressTableCompanion({
    this.id = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.addressLine = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipcode = const Value.absent(),
    this.country = const Value.absent(),
    this.landmark = const Value.absent(),
  });
  AddressTableCompanion.insert({
    this.id = const Value.absent(),
    @required String accessToken,
    @required String addressLine,
    @required String city,
    @required String state,
    @required int zipcode,
    @required String country,
    @required String landmark,
  })  : accessToken = Value(accessToken),
        addressLine = Value(addressLine),
        city = Value(city),
        state = Value(state),
        zipcode = Value(zipcode),
        country = Value(country),
        landmark = Value(landmark);
  static Insertable<AddressTableData> custom({
    Expression<int> id,
    Expression<String> accessToken,
    Expression<String> addressLine,
    Expression<String> city,
    Expression<String> state,
    Expression<int> zipcode,
    Expression<String> country,
    Expression<String> landmark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accessToken != null) 'access_token': accessToken,
      if (addressLine != null) 'address_line': addressLine,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (zipcode != null) 'zipcode': zipcode,
      if (country != null) 'country': country,
      if (landmark != null) 'landmark': landmark,
    });
  }

  AddressTableCompanion copyWith(
      {Value<int> id,
      Value<String> accessToken,
      Value<String> addressLine,
      Value<String> city,
      Value<String> state,
      Value<int> zipcode,
      Value<String> country,
      Value<String> landmark}) {
    return AddressTableCompanion(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      state: state ?? this.state,
      zipcode: zipcode ?? this.zipcode,
      country: country ?? this.country,
      landmark: landmark ?? this.landmark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (addressLine.present) {
      map['address_line'] = Variable<String>(addressLine.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (zipcode.present) {
      map['zipcode'] = Variable<int>(zipcode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (landmark.present) {
      map['landmark'] = Variable<String>(landmark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressTableCompanion(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipcode: $zipcode, ')
          ..write('country: $country, ')
          ..write('landmark: $landmark')
          ..write(')'))
        .toString();
  }
}

class $AddressTableTable extends AddressTable
    with TableInfo<$AddressTableTable, AddressTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AddressTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  GeneratedTextColumn _accessToken;
  @override
  GeneratedTextColumn get accessToken =>
      _accessToken ??= _constructAccessToken();
  GeneratedTextColumn _constructAccessToken() {
    return GeneratedTextColumn(
      'access_token',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addressLineMeta =
      const VerificationMeta('addressLine');
  GeneratedTextColumn _addressLine;
  @override
  GeneratedTextColumn get addressLine =>
      _addressLine ??= _constructAddressLine();
  GeneratedTextColumn _constructAddressLine() {
    return GeneratedTextColumn(
      'address_line',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      false,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  GeneratedTextColumn _state;
  @override
  GeneratedTextColumn get state => _state ??= _constructState();
  GeneratedTextColumn _constructState() {
    return GeneratedTextColumn(
      'state',
      $tableName,
      false,
    );
  }

  final VerificationMeta _zipcodeMeta = const VerificationMeta('zipcode');
  GeneratedIntColumn _zipcode;
  @override
  GeneratedIntColumn get zipcode => _zipcode ??= _constructZipcode();
  GeneratedIntColumn _constructZipcode() {
    return GeneratedIntColumn(
      'zipcode',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countryMeta = const VerificationMeta('country');
  GeneratedTextColumn _country;
  @override
  GeneratedTextColumn get country => _country ??= _constructCountry();
  GeneratedTextColumn _constructCountry() {
    return GeneratedTextColumn(
      'country',
      $tableName,
      false,
    );
  }

  final VerificationMeta _landmarkMeta = const VerificationMeta('landmark');
  GeneratedTextColumn _landmark;
  @override
  GeneratedTextColumn get landmark => _landmark ??= _constructLandmark();
  GeneratedTextColumn _constructLandmark() {
    return GeneratedTextColumn(
      'landmark',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, accessToken, addressLine, city, state, zipcode, country, landmark];
  @override
  $AddressTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'address_table';
  @override
  final String actualTableName = 'address_table';
  @override
  VerificationContext validateIntegrity(Insertable<AddressTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token'], _accessTokenMeta));
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    if (data.containsKey('address_line')) {
      context.handle(
          _addressLineMeta,
          addressLine.isAcceptableOrUnknown(
              data['address_line'], _addressLineMeta));
    } else if (isInserting) {
      context.missing(_addressLineMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city'], _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state'], _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('zipcode')) {
      context.handle(_zipcodeMeta,
          zipcode.isAcceptableOrUnknown(data['zipcode'], _zipcodeMeta));
    } else if (isInserting) {
      context.missing(_zipcodeMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country'], _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('landmark')) {
      context.handle(_landmarkMeta,
          landmark.isAcceptableOrUnknown(data['landmark'], _landmarkMeta));
    } else if (isInserting) {
      context.missing(_landmarkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AddressTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AddressTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AddressTableTable createAlias(String alias) {
    return $AddressTableTable(_db, alias);
  }
}

abstract class _$NeoStoreDB extends GeneratedDatabase {
  _$NeoStoreDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AddressTableTable _addressTable;
  $AddressTableTable get addressTable =>
      _addressTable ??= $AddressTableTable(this);
  AddressTableDao _addressTableDao;
  AddressTableDao get addressTableDao =>
      _addressTableDao ??= AddressTableDao(this as NeoStoreDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [addressTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$AddressTableDaoMixin on DatabaseAccessor<NeoStoreDB> {
  $AddressTableTable get addressTable => attachedDatabase.addressTable;
}
