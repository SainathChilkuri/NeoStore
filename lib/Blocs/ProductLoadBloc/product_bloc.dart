import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/API%20Service/ProductService/product_service.dart';
import 'package:neostore/Blocs/ProductLoadBloc/product_events.dart';
import 'package:neostore/Blocs/ProductLoadBloc/product_states.dart';
import 'package:neostore/Model/Product%20Data/product_model.dart';

class ProductBloc extends Bloc<ProductEvents,ProductState>{
  ProductBloc() : super(ProductInitialState());

  @override
  Stream<ProductState> mapEventToState(ProductEvents event) async* {
   if(event is ProductLoadData){
     yield ProductDataLoading();
     Response response =  await ProductService().getProducts(event.id);

     if(response.statusCode == 200){
       var data= json.decode(response.data);
       print("DATA:---------------------->");
       yield ProductLoadState(data: ProductModel.fromJson(data));
     }else{
       var data= json.decode(response.data);
       var msg = data["message"];
       yield ProductLoadFailedState(errorMsg: data["message"]);
     }

   }
  }

}