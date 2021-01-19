import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotState extends Equatable{
  @override
  List<Object> get props =>[];
}
class ForgotInitialState extends ForgotState{}
class ForgotSuccessfullState extends ForgotState{
  final String successResponse;
  ForgotSuccessfullState({
    @required this.successResponse
}):assert(successResponse!=null);
  @override
  List<Object> get props =>[successResponse];
}
class ForgotFailedState extends ForgotState{
  final String errorResponse;
  ForgotFailedState({
    @required this.errorResponse
  }):assert(errorResponse!=null);
  @override
  List<Object> get props =>[errorResponse];
}