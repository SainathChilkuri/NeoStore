import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class InitAuthProcess extends AuthEvents{
}