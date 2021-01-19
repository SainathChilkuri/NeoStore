import 'package:dio/dio.dart';
import 'package:neostore/API%20Service/interceptors.dart';

class ProductService{
  Dio dio;
   ProductService(){
    dio=Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000
    ));
  }

  Future<dynamic> getProducts(int category_id)async{
     final URL = "http://staging.php-dev.in:8844/trainingapp/api/products/getList";
     Dio _dio = await addInterceptors(dio);
     try{
       Response response =await _dio.get(URL,queryParameters: {
         "product_category_id": category_id
       });
       if(response.statusCode == 200){
        print(response.data);
        return response;
       }
     }on DioError catch(e){
       print(e.response.data);
       return e.response;
     }
   }
  Future<dynamic> getProductsDetails(int product_id)async{
    final URL = "http://staging.php-dev.in:8844/trainingapp/api/products/getDetail";
    Dio _dio = await addInterceptors(dio);
    try{
      Response response =await _dio.get(URL,queryParameters: {
        "product_id": product_id
      });
      if(response.statusCode == 200){
        print(response.data);
        return response;
      }
    }on DioError catch(e){
      print(e.response.data);
      return e.response;
    }

  }
  Future<dynamic> setRating(int rating,int product)async{

    final URL = "http://staging.php-dev.in:8844/trainingapp/api/products/setRating";
    Dio _dio = await addInterceptors(dio);
    FormData data = FormData.fromMap({
      "product_id": product,
      "rating":rating
    });
    try{
      Response response =await _dio.post(URL,data: data);
      if(response.statusCode == 200){
        print(response.data);
        return response;
      }
    }on DioError catch(e){
      print(e.response.data);
      return e.response;
    }

  }

 Future<Dio> addInterceptors(Dio dio) async{
     return dio..interceptors.add(Intercept());
 }

}