import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvents extends Equatable{
  @override
  List<Object> get props =>[];
}
class FetchUserDetails extends HomeEvents{
  final String accessToken;
  FetchUserDetails({
    @required this.accessToken
  }):assert(accessToken!=null);
  @override
  List<Object> get props =>[accessToken];
}
class AccountUpdateEvent extends HomeEvents{}