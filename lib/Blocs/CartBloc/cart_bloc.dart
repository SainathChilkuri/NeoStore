import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/API%20Service/CartService/cart_service.dart';
import 'package:neostore/Blocs/CartBloc/cart_events.dart';
import 'package:neostore/Blocs/CartBloc/cart_states.dart';
import 'package:neostore/Model/CartModel/cart_model.dart';
import 'package:neostore/Session/user_session.dart';

class CartBloc extends Bloc<CartEvents,CartScreenState>{
  CartBloc() : super(CartInitialState());

  @override
  Stream<CartScreenState> mapEventToState(CartEvents event) async*{
    if(event is CartFetchData){
      yield CartLoadingState();
      var accessToken = await UserSession().getSessionDetails();
      print("CART SCREEN : AccessToken: $accessToken");
      Response response = await CartService().getCartList(accessToken);
      if(response.statusCode == 200){
       var details = json.decode(response.data);
        if(details["data"]!=null){
          var cartList = CartModel.fromJson(details);
          print("SUCCESS CART LIST: ${cartList.total} }");
          yield CartLoadState(cartModel: cartList);
        }else{
          yield CartEmptyState();
        }
      }else{
        var errorResponse = json.decode(response.data);
        print(errorResponse);
        yield CartErrorState(errorMsg: errorResponse["message"]);
      }
    }
    if(event is CartDeleteData){
      var accessToken = await UserSession().getSessionDetails();
      print("CART SCREEN DELETE EVENT: AccessToken: $accessToken");
      Response response = await CartService().deleteCartList(accessToken, event.product_id);
      if(response.statusCode == 200){
        var successResponse = json.decode(response.data);
        print(successResponse);
        yield CartDeletedState(successMsg: successResponse["user_msg"]);
      }else{
        var errorResponse = json.decode(response.data);
        print(errorResponse);
        CartDeletedState(successMsg: errorResponse["user_msg"]);
      }
    }
    if(event is CartEditData){
      var accessToken = await UserSession().getSessionDetails();
      print("CART SCREEN DELETE EVENT: AccessToken: $accessToken");
      Response response = await CartService().editCartList(accessToken, event.product_id, event.qty);
      if(response.statusCode == 200){
        var successResponse = json.decode(response.data);
        print(successResponse);
       yield CartEditState(msg: successResponse["user_msg"]);
      }else{
        var errorResponse = json.decode(response.data);
        print(errorResponse);
        yield CartEditState(msg: errorResponse["user_msg"]);
      }
    }
  }
}