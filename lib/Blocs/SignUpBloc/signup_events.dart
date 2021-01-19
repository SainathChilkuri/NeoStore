
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/UserModel/user.dart';

abstract class SignUpEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class SignUpButtonPressed extends SignUpEvents{
  final firstname,lastname,email,gender,password,con_password,number;
  SignUpButtonPressed({
    @required this.firstname,
    @required this.lastname,
    @required this.email,
    @required this.gender,
    @required this.password,
    @required this.con_password,
    @required this.number,
  }):assert(firstname!=null
      && lastname!=null
      && email!=null
      &&gender!=null
      &&password!=null
      &&con_password!=null
      &&number!=null);
  @override
  List<Object> get props=>[firstname,lastname,email,gender,password,con_password,number];
}