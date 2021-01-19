import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/CartModel/cart_model.dart';

abstract class CartScreenState extends Equatable{
  @override
  List<Object> get props=>[];
}
class CartInitialState extends CartScreenState{}
class CartInsertedState extends CartScreenState{}
class CartEditState extends CartScreenState{
  final String msg;
  CartEditState({
    @required this.msg
  }):assert(msg!=null);
  @override
  List<Object> get props=>[msg];
}
class CartDeletedState extends CartScreenState{
  final String successMsg;
  CartDeletedState({
    @required this.successMsg
}):assert(successMsg!=null);
  @override
  List<Object> get props=>[successMsg];
}
class CartLoadingState extends CartScreenState{}
class CartLoadState extends CartScreenState{
  final CartModel cartModel;
  CartLoadState({
    @required this.cartModel
}):assert(cartModel!=null);
  @override
  List<Object> get props=>[cartModel];
}
class CartEmptyState extends CartScreenState{}
class CartErrorState extends CartScreenState{
  final String errorMsg;
  CartErrorState({
    @required this.errorMsg
}):assert(errorMsg!=null);
  @override
  List<Object> get props=>[errorMsg];
}