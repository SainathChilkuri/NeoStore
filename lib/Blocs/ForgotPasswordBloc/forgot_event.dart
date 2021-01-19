import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class ForgotPassword extends ForgotEvent{
  final String email;
  ForgotPassword({
    @required this.email
  }):assert(email!=null);
  @override
  List<Object> get props=>[email];
}