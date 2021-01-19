import 'package:dio/dio.dart';

class Intercept extends Interceptor{

  @override
  Future onError(DioError error) async {
    if(error.type == DioErrorType.CONNECT_TIMEOUT || error.type == DioErrorType.RESPONSE){
      print(error.response);
      print("CONNECTION TIMEOUT");
    }
    return error;
  }

  @override
  Future onResponse(Response response) async{
    if(response.statusCode == 200){
      print("RESPONSE--------->");
      print(response.data);
      print("<--------------------");
    }
    return response;
  }

  @override
  Future onRequest(RequestOptions request)async {
    print("REQUESTING--------->");
    print(request.headers);
    print("<--------------------");
    return request;
  }
}