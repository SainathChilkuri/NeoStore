import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/UserModel/user.dart';

abstract class AuthState extends Equatable{
  @override
  List<Object> get props=>[];
}
class AuthInitialState extends AuthState{}
class AuthenticatedState extends AuthState{
  final String acessToken;
  AuthenticatedState({
    @required this.acessToken
   }):assert(acessToken!=null);
  @override
  List<Object> get props=>[acessToken];
}
class UnAuthenticatedState extends AuthState{}