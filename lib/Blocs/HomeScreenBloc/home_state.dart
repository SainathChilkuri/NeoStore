import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:neostore/Model/UserModel/user.dart';

abstract class HomeStates extends Equatable{
  @override
  List<Object> get props =>[];
}
class HomeInitialState extends HomeStates{}
class FetchUserState extends HomeStates{
  final User user;
  FetchUserState({
    @required this.user
  }):assert(user!=null);
  @override
  List<Object> get props =>[user];
}
class FetchIncompleteState extends HomeStates{
}