import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neostore/API%20Service/interceptors.dart';

class AuthService{
static AuthService authService;
static Dio dio;
BaseOptions baseOptions = BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 5000,
);
AuthService(){
  print("dio creted");
  dio = Dio(baseOptions);
}
Future<dynamic> loginUser(String email,String password) async {
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/login";
  Dio _dio = await addinterceptors(dio);
  FormData formData = FormData.fromMap({
    "email":email,
    "password":password
  });
  try {
    Response response = await _dio.post(URL, data: formData);
    if (response.statusCode == 200) {
      return response;
    }
}on DioError catch(e){
  return e.response;
}
}
Future<dynamic> forgotPassword(String email) async {
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/forgot";
  Dio _dio = await addinterceptors(dio);
  FormData formData = FormData.fromMap({
    "email":email
  });
  try {
    Response response = await _dio.post(URL, data: formData);
    if (response.statusCode == 200) {
      return response;
    }
  }on DioError catch(e){
    return e.response;
  }
}

Future<dynamic> registerUser(String email,String password,String con_password,String firstname,String lastname, String gender,String number) async {
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/register";
  Dio _dio = await addinterceptors(dio);
  FormData formData = FormData.fromMap({
    "first_name": firstname,
    "last_name":lastname,
    "email":email,
    "password":password,
    "confirm_password":con_password,
    "gender":gender,
    "phone_no":number
  });
  try{
    Response response = await _dio.post(URL,data:formData);

    if(response.statusCode == 200){
      return response;
    }
  }on DioError catch(e){
    return e.response;
  }
}
Future<dynamic> updateUserInfo(String access_token,String firstname,String lastname,String email,String number,String dob,String profile_pic) async {
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/update";
  Dio _dio = await addinterceptors(dio);
  FormData formData = FormData.fromMap({
    "first_name": firstname,
    "last_name":lastname,
    "email":email,
    "phone_no":number,
    "dob":dob,
    "profile_pic":profile_pic
  });
  try{
    Response response = await _dio.post(URL,options:Options(
      headers: {
        "access_token":access_token
      }
    ),data:formData);
    if(response.statusCode == 200){
      return response;
    }
  }on DioError catch(e){
    return e.response;
  }
}

Future<dynamic> fetchUser(String accessToken) async {
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData";
  Dio _dio = await addinterceptors(dio);
  try{
    Response response = await _dio.get(URL,options: Options(
      headers: {
        "access_token": accessToken
      }
    ));
    if(response.statusCode == 200){
      return response;
    }
  }on DioError catch(e){
    return e.response;
  }
}
Future<dynamic> changePassword(String access_token,String oldpassword,String newPassword,String confirmPassword)async{
  final URL = "http://staging.php-dev.in:8844/trainingapp/api/users/change";
  Dio _dio = await addinterceptors(dio);
  FormData formData = FormData.fromMap({
    "old_password":oldpassword,
    "password":newPassword,
    "confirm_password":confirmPassword
  });
  try{
    Response response = await _dio.post(URL,options: Options(
        headers: {
          "access_token":access_token
        }
    ), data: formData);
    if(response.statusCode == 200){
      print(response.data);
      return response;
    }
  }on DioError catch(e){
    print(e.response);
    return e.response;
  }


}
  Future<Dio> addinterceptors(Dio dio) async {
  return dio..interceptors.add(Intercept());
  }
}