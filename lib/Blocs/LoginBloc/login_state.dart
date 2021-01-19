import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/UserModel/user.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object> get props =>[];
}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccesfullState extends LoginState{
  final String accessToken;
  LoginSuccesfullState({
    @required this.accessToken
}):assert(accessToken!=null);
  @override
  List<Object> get props=>[accessToken];
}
class LoginFailedState extends LoginState{
  final String errorMsg;
  LoginFailedState({
    @required this.errorMsg
   }) :assert(errorMsg!=null);

  @override
  List<Object> get props=>[errorMsg];
}
class ResetPasswordSuccesfull extends LoginState{
  final String msg;
  ResetPasswordSuccesfull({
    @required this.msg
}):assert(msg!=null);
  List<Object> get props=>[msg];
}
class ResetPasswordFailed extends LoginState{
  final String msg,error;
  ResetPasswordFailed({
    @required this.msg,
    @required this.error
  }):assert(msg!=null);
  List<Object> get props=>[msg,error];
}