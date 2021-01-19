import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Database/database.dart';

abstract class AddressScreenState extends Equatable{

  @override
  List<Object> get props =>[];
}
class AddressInitialState extends AddressScreenState{}
class AddressLoadingState extends AddressScreenState{}
class AddressInsertedState extends AddressScreenState{}
class AddressDeletedState extends AddressScreenState{}
class AddressLoadState extends AddressScreenState{
  final List<AddressTableData> addressTableData;
  AddressLoadState({
    @required this.addressTableData
}):assert(addressTableData!=null);
}
class AddressEmptyState extends AddressScreenState{}
class AddressFailedState extends AddressScreenState{}