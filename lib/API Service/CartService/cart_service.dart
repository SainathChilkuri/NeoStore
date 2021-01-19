import 'package:dio/dio.dart';
import 'package:neostore/API%20Service/interceptors.dart';
import 'package:neostore/Session/user_session.dart';

class CartService{
  Dio dio;
  CartService(){
    dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }
  Future<dynamic> addToCart(int product_id,int qty)async{
    var accessToken = await UserSession().getSessionDetails();
    print("Add To Cart: AccessToken- $accessToken");
    final URL = "http://staging.php-dev.in:8844/trainingapp/api/addToCart";
    Dio _dio = await addInterceptos(dio);
    FormData data = FormData.fromMap({
      "product_id":product_id,
      "quantity":qty
    });
    try{
      Response response = await _dio.post(URL,data: data,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        return response;
      }
    }on DioError catch(e){
      return e.response;
    }

  }
  Future<dynamic> getCartList(String accessToken)async{
    print("Get Cart List: AccessToken- $accessToken");
    final URL = "http://staging.php-dev.in:8844/trainingapp/api/cart";
    Dio _dio = await addInterceptos(dio);
    try{
      Response response = await _dio.get(URL,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        return response;
      }
    }on DioError catch(e){
      return e.response;
    }

  }
  Future<dynamic> deleteCartList(String accessToken,int product_id)async{
    print("Delete Cart List: AccessToken- $accessToken");
    final URL = "http://staging.php-dev.in:8844/trainingapp/api/deleteCart";
    Dio _dio = await addInterceptos(dio);
    FormData data = FormData.fromMap({
      "product_id":product_id
    });
    try{
      Response response = await _dio.post(URL,data:data,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        return response;
      }
    }on DioError catch(e){
      return e.response;
    }

  }
  Future<dynamic> editCartList(String accessToken,int product_id,int quantity)async{
    print("Edit Cart List: AccessToken- $accessToken");
    final URL = "http://staging.php-dev.in:8844/trainingapp/api/editCart";
    Dio _dio = await addInterceptos(dio);
    FormData data = FormData.fromMap({
      "product_id":product_id,
      "quantity":quantity
    });
    try{
      Response response = await _dio.post(URL,data:data,options: Options(
          headers: {
            "access_token":accessToken
          }
      ));
      if(response.statusCode==200){
        return response;
      }
    }on DioError catch(e){
      return e.response;
    }

  }
}



Future<Dio> addInterceptos(Dio dio)async {
  return dio..interceptors.add(Intercept());
}