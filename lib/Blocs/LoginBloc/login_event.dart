

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class LoginButtonPressed extends LoginEvents{
  final String email;
  final String password;
  LoginButtonPressed({
    @required this.email,
    @required this.password
   }):assert(email!=null && password!=null);

  @override
  List<Object> get props =>[email,password];
}
class ResetPasswordEvent extends LoginEvents{
  final String access_token;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  ResetPasswordEvent({
    @required this.access_token,
    @required this.oldPassword,
    @required this.newPassword,
    @required this.confirmPassword,
 }):assert(access_token!=null && oldPassword!=null && newPassword!=null && confirmPassword!=null);
  @override
  List<Object> get props =>[access_token,oldPassword,newPassword,confirmPassword];
}
