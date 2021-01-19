import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/API%20Service/OrdersService/orders_service.dart';
import 'package:neostore/Blocs/Orders/OrderDetails/orderdetails_events.dart';
import 'package:neostore/Blocs/Orders/OrderDetails/ordersdetails_states.dart';
import 'package:neostore/Model/OrdersModel/orderdetails_model.dart';
import 'package:neostore/Session/user_session.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent,OrderDetailsState>{
  OrderDetailsBloc() : super(OrderDetailsInitialState());

  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvent event)async* {
   if(event is OrderDetailsFetch){
     yield OrderDetailsLoadingState();
     var accesToken = await UserSession().getSessionDetails();
     print("Order Details of ${event.orderId} : Access Token : $accesToken");
     Response response = await OrdersService().getOrdersDetails(accesToken,event.orderId );
     if(response.statusCode == 200){
       var orderDetails= OrderDetailModel.fromJson(json.decode(response.data));
       yield OrderDetailsLoadState(orderDetailModel: orderDetails);
     }else{
       var errorResponse = json.decode(response.data);
       yield OrderDetailsLoadFailedState(errorMsg: errorResponse["user_msg"]);
     }
   }
  }
}