import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/OrdersModel/orderdetails_model.dart';

abstract class OrderDetailsState extends Equatable{
  @override
  List<Object> get props=>[];
}
class OrderDetailsInitialState extends OrderDetailsState{}
class OrderDetailsLoadingState extends OrderDetailsState{}
class OrderDetailsLoadState extends OrderDetailsState{
  final OrderDetailModel orderDetailModel;
  OrderDetailsLoadState({
    @required this.orderDetailModel
}):assert(orderDetailModel!=null);
  @override
  List<Object> get props=>[orderDetailModel];
}
class OrderDetailsLoadFailedState extends OrderDetailsState{
  final String errorMsg;
  OrderDetailsLoadFailedState({
    @required this.errorMsg
}):assert(errorMsg!=null);
  @override
  List<Object> get props=>[errorMsg];
}