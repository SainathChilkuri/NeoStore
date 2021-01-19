import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderListEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class OrderPlaceEvent extends OrderListEvents{
  final String address;
  OrderPlaceEvent({
    @required this.address,
}):assert(address!=null);
  @override
  List<Object> get props=>[address];
}
class FetchOrderList extends OrderListEvents{
  @override
  List<Object> get props=>[];
}