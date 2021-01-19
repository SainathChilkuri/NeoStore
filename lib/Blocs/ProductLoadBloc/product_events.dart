import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductEvents extends Equatable{
  @override
  List<Object> get props =>[];
}
class ProductLoadData extends ProductEvents{
  final int id;
  ProductLoadData({
    @required this.id
}):assert(id!=null);
  @override
  List<Object> get props =>[id];
}