import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Database/database.dart';
import 'package:provider/provider.dart';

abstract class AddressEvents extends Equatable{

  @override
  List<Object> get props =>[];
}
class AddressFetchEvent extends AddressEvents{
  final AddressTableDao addressTableDao;
  AddressFetchEvent({
    @required this.addressTableDao,
  }):assert(addressTableDao!=null);
}
class AddressInsertEvent extends AddressEvents{
  final AddressTableDao addressTableDao;
  final AddressTableData addressTableData;
  AddressInsertEvent({
    @required this.addressTableDao,
    @required this.addressTableData
  }):assert(addressTableData!=null,addressTableData!=null);
}
class AddressDeleteEvent extends AddressEvents{
  final AddressTableDao addressTableDao;
  final AddressTableData addressTableData;
  AddressDeleteEvent({
    @required this.addressTableDao,
    @required this.addressTableData
  }):assert(addressTableData!=null,addressTableData!=null);
}