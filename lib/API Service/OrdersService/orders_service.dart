import 'package:dio/dio.dart';
import 'package:neostore/Session/user_session.dart';

import '../interceptors.dart';

class OrdersService{
  Dio dio;
  OrdersService(){
    dio =Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }

  Future<dynamic> getOrdersList(String accessToken)async {
    final URL="http://staging.php-dev.in:8844/trainingapp/api/orderList";
    Dio _dio = await addInterceptors(dio);
    try{
      Response response = await _dio.get(URL,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        print(response.data);
        return response;
      }else{
        print(response.data);
        return response;
      }
    }on DioError catch(e){
      print(e.response);
      return e.response;
    }

  }
  Future<dynamic> getOrdersDetails(String accessToken,int order_id)async {
    final URL="http://staging.php-dev.in:8844/trainingapp/api/orderDetail";
    Dio _dio = await addInterceptors(dio);
    try{
      Response response = await _dio.get(URL,queryParameters: {
        "order_id":order_id
      },options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        print(response.data);
        return response;
      }else{
        print(response.data);
        return response;
      }
    }on DioError catch(e){
      print(e.response);
      return e.response;
    }

  }
  Future<dynamic> placeOrders(String address,String accessToken)async {
    print("PLACE ORDERS: ACCESS TOKEN - $accessToken");
    final URL="http://staging.php-dev.in:8844/trainingapp/api/order";
    Dio _dio = await addInterceptors(dio);
    FormData data = FormData.fromMap({
      "address":address
    });
    try{
      Response response = await _dio.post(URL,data:data,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        print(response.data);
        return response;
      }else{
        print(response.data);
        return response;
      }
    }on DioError catch(e){
      print(e.response);
      return e.response;
    }

  }
  Future<Dio> addInterceptors(Dio dio) async {
    return dio..interceptors.add(Intercept());
  }
}