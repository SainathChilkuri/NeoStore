import 'package:equatable/equatable.dart';

abstract class UpdateStates extends Equatable {
  @override
  List<Object> get props =>[];
}
class InitialData extends UpdateStates{}
class UpdateLoading extends UpdateStates{}
class UpdateSuccesfully extends UpdateStates{
}
class UpdateFailed extends UpdateStates{}