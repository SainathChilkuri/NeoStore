import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/API%20Service/AuthService/auth_service.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_event.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent,ForgotState>{
  ForgotBloc() : super(ForgotInitialState());

  @override
  Stream<ForgotState> mapEventToState(ForgotEvent event) async* {
    if(event is ForgotPassword){
      Response response = await AuthService().forgotPassword(event.email);
      if(response.statusCode==200){
        var successResponse = json.decode(response.data);
        yield ForgotSuccessfullState(successResponse: successResponse["user_msg"]);
      }else{
        var errorResponse = json.decode(response.data);
        yield ForgotFailedState(errorResponse: errorResponse["user_msg"]);
      }
    }
  }

}