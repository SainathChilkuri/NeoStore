import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderDetailsEvent extends Equatable{
  @override
  List<Object> get props=>[];
}
class OrderDetailsFetch extends OrderDetailsEvent{
  final int orderId;
  OrderDetailsFetch({
    @required this.orderId
}):assert(orderId!=null);
  @override
  List<Object> get props=>[orderId];
}