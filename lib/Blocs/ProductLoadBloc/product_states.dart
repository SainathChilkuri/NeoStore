import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/Product%20Data/product_model.dart';

abstract class ProductState extends Equatable{
  @override
  List<Object> get props =>[];
}
class ProductInitialState extends ProductState{}
class ProductDataLoading extends ProductState{}
class ProductLoadState extends ProductState{
  final ProductModel data;
  ProductLoadState({
    @required this.data
}):assert(data!=null);
  @override
  List<Object> get props =>[data];
}
class ProductLoadFailedState extends ProductState{
  final String errorMsg;
  ProductLoadFailedState({
    @required this.errorMsg
}):assert(errorMsg!=null);
  @override
  List<Object> get props =>[errorMsg];
}