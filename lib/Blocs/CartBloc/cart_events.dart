import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CartEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class CartFetchData extends CartEvents{}
class CartDeleteData extends CartEvents{
  final int product_id;
  CartDeleteData({
    @required this.product_id
}):assert(product_id!=null);
  @override
  List<Object> get props=>[product_id];
}
class CartEditData extends CartEvents{
  final int product_id;
  final int qty;
  CartEditData({
    @required this.product_id,
    @required this.qty
  }):assert(product_id!=null && qty!=null);
  @override
  List<Object> get props=>[product_id,qty];
}