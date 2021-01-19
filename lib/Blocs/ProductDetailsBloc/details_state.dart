import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/Product%20Data/product_detail_model.dart';

abstract class DetailsState extends Equatable{
  @override
  List<Object> get props =>[];
}
class DetailsInitial extends DetailsState{}
class DetailsLoading extends DetailsState{}
class DetailsSuccessLoad extends DetailsState{
final ProductDetailModel productDetailModel;
DetailsSuccessLoad({
  @required this.productDetailModel
}):assert(productDetailModel!=null);
@override
List<Object> get props =>[productDetailModel];
}
class DetailsFailLoad extends DetailsState{
  final String errorMsg;
  DetailsFailLoad({
    @required this.errorMsg
}):assert(errorMsg!=null);
}
/*
class RatedSuccessful extends DetailsState{}
class RateingFailed extends DetailsState{}*/
