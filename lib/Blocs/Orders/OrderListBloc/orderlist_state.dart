import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/OrdersModel/orders_model.dart';

abstract class OrderListState extends Equatable{
  @override
  List<Object> get props=>[];
}
class InitialOrderListState extends OrderListState{}
class OrderListLoadingState extends OrderListState{}
class OrderPlacedSuccessfullyState extends OrderListState{
  final String successMsg;
  OrderPlacedSuccessfullyState({
    @required this.successMsg
  }):assert(successMsg!=null);
  @override
  List<Object> get props=>[successMsg];
}
class OrderPlacedFailedState extends OrderListState{
  final String errorMsg;
  OrderPlacedFailedState({
    @required this.errorMsg
  }):assert(errorMsg!=null);
  @override
  List<Object> get props=>[errorMsg];
}
class LoadOrderList extends OrderListState{
  final OrdersList orderList;
 LoadOrderList({
    @required this.orderList
}):assert(orderList!=null);
  @override
  List<Object> get props=>[orderList];
}
class OrderListEmpty extends OrderListState{}
class OrderListFailed extends OrderListState{}