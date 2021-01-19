import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UpdateEvents extends Equatable {
  @override
  List<Object> get props =>[];
}
class AccountDetailUpdateEvent extends UpdateEvents{
  final String accessToken,firstName,lastName,email,phoneNo,dob,profilePic;
  AccountDetailUpdateEvent({
    @required this.accessToken,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phoneNo,
    @required this.dob,
    this.profilePic
}):assert(firstName!=null
      && lastName!=null
      &&email!=null
      && phoneNo!=null
      && dob!=null && accessToken!=null);
  @override
  List<Object> get props =>[accessToken,firstName,lastName,email,phoneNo,dob,profilePic];
}