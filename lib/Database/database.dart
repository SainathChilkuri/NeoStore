import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';
class AddressTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get accessToken => text()();
  TextColumn get addressLine => text()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  IntColumn get zipcode => integer()();
  TextColumn get country => text()();
  TextColumn get landmark => text()();

}
@UseMoor(tables: [AddressTable],daos: [AddressTableDao])
class NeoStoreDB extends _$NeoStoreDB{
  NeoStoreDB():super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite',logStatements: true));
  @override
  int get schemaVersion => 1;
  static NeoStoreDB _neoStoreDB;
  NeoStoreDB get neoStoreDB{
    if(_neoStoreDB == null){
      _neoStoreDB = NeoStoreDB();
    }
    return _neoStoreDB;
  }

}
@UseDao(tables: [AddressTable])
class AddressTableDao extends DatabaseAccessor<NeoStoreDB> with _$AddressTableDaoMixin{
  final NeoStoreDB neoStoreDB;
  AddressTableDao(
      this.neoStoreDB
      ):super(neoStoreDB);
  Future<List<AddressTableData>> getAllTasks(String access_token) => (select(addressTable)..where((tbl) => tbl.accessToken.equals(access_token))).get();
  Future<int> insertAddress(Insertable<AddressTableData> addressTableData) => into(addressTable).insert(addressTableData);
  Future<int> deleteAddress(Insertable<AddressTableData> addressTableData) =>  delete(addressTable).delete(addressTableData);
}