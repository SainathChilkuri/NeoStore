import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DetailsEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class LoadProductDetails extends DetailsEvent{
  final int id;
  LoadProductDetails({
    @required this.id
}):assert(id!=null);
  @override
  List<Object> get props =>[id];
}
class SetRatingEvent extends DetailsEvent{
  final int rating;
  final int product_id;
  SetRatingEvent({
   @required this.rating,
   @required this.product_id
}):assert(rating!=null);
  @override
  List<Object> get props =>[rating];
}
