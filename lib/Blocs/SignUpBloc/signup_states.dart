import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignUpStates extends Equatable{
  @override
  List<Object> get props=>[];
}
class SignUpInitialState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
  final String msg;
  SignUpSuccessState({
    @required this.msg
}):assert(msg!=null);
  @override
  List<Object> get props=>[msg];
}
class SignUpFailedState extends SignUpStates{
  final String msg;
  SignUpFailedState({
    @required this.msg
  }):assert(msg!=null);
  @override
  List<Object> get props=>[msg];
}
