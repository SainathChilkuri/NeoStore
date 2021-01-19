import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/API%20Service/AuthService/auth_service.dart';
import 'package:neostore/Blocs/LoginBloc/login_event.dart';
import 'package:neostore/Blocs/LoginBloc/login_state.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:neostore/Session/user_session.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
   if(event is LoginButtonPressed){
     print("LOGIN BUTTON PRESSED: ${event.email}");
     yield LoginLoadingState();
     Response response = await AuthService().loginUser(event.email, event.password);
     var data = json.decode(response.data);
     if(response.statusCode == 200){
       print("Access Token_---------------->");
       var accessToken = data["data"]["access_token"];
       print(accessToken);
       print("<----------------------");
          /*Response response = await AuthService().fetchUser(accessToken);*/
          /*if(response.statusCode == 200){
            var userResponse = json.decode(response.data);
            print("_-----------------------------------------------");
            print(userResponse["data"]);
            print("_-----------------------------------------------");
            Data data  = Data.fromJson(userResponse["data"]);
            print("User Data---------------->");
            print(data.userData.firstName);
            print("<----------------------");*/
            await UserSession().storeSession(accessToken);
            yield LoginSuccesfullState(accessToken: accessToken);
          /*}else{
            yield LoginFailedState(errorMsg: "Invalid Access Token");
          }*/
     }else{
       print(data["user_msg"]);
       yield LoginFailedState(errorMsg: data["user_msg"]);
       print("Sorry");
     }
   }
   if(event is ResetPasswordEvent){
     Response response = await AuthService().changePassword(event.access_token, event.oldPassword, event.newPassword, event.confirmPassword);
     print("---/////--------");
     //print(response.data);
     var data = json.decode(response.data);
     //print(data);
     if(response.statusCode == 200){
       var data = json.decode(response.data);
       yield ResetPasswordSuccesfull(msg: data["message"]);
     }else{
       var data = json.decode(response.data);
       yield ResetPasswordFailed(msg: data["message"], error: data["message"]);
     }
   }
  }

}