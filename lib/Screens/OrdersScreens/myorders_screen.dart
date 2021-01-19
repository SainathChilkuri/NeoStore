import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_events.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/OrdersModel/orders_model.dart';
import 'package:neostore/Session/user_session.dart';
import 'package:neostore/main.dart';
import 'package:sizer/sizer.dart';
class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderListBloc,OrderListState>(
      listener: (context,state){
        if(state is OrderPlacedSuccessfullyState){
          BlocProvider.of<OrderListBloc>(context).add(FetchOrderList());
        }
      },

      child: Scaffold(
        appBar: _appBar("My Orders"),
        body: BlocBuilder<OrderListBloc,OrderListState>(
          // ignore: missing_return
          builder: (context,state){
            if(state is InitialOrderListState){
              BlocProvider.of<OrderListBloc>(context).add(FetchOrderList());
              return Center(
                child: Text("No Data to Show Currently"),
              );
            }
            if(state is OrderListLoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is OrderListEmpty){
              return _emptyScreen();
            }
            if(state is OrderPlacedSuccessfullyState){
              return Container();
            }
            if(state is OrderPlacedFailedState){
              return Container();
            }
            if(state is LoadOrderList){
              return _showOrderList(state.orderList);
            }
            if(state is OrderListFailed){
              return Center(
                child: Text("Failed to Load State")
              );
            }
          },
        ),
      ),
    );
  }

 Widget _appBar(String s) {
   return AppBar(
     title: Text(
       s,
       style: TextStyle(
           color: AppColor.whiteText,
           fontWeight: FontWeight.bold,
           fontSize: 20.0.sp
       ),
     ),
     centerTitle: true,
   );
 }

  Widget _emptyScreen() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 35.0.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/empty_orders.png"),
              fit: BoxFit.fill
            )
          ),
        ),
        Text("Orders Are Empty...",
        style: TextStyle(
          color: AppColor.black,
          fontSize: 12.0.sp,
          fontWeight: FontWeight.bold
        ),),
        GestureDetector(
          onTap: () async {
            var accessToken= await UserSession().getSessionDetails();
            Navigator.pushReplacementNamed(context, "/homeScreen", arguments:accessToken);

          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 4.0.h),
            width: 30.0.w,
            height: 6.0.h,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(2.0.w)
                ),
            child: Text("SHOP NOW",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold
              ),),
            ),
        ),
      ],
    ),
  );
  }

  Widget _showOrderList(OrdersList orderList) {
    return
        ListView.builder(
            itemCount: orderList.data.length,
            itemBuilder: (context,index){
              return _showOrders(orderList.data[index]);
            });

  }

  Widget _showOrders(OrdersData data) {
    return GestureDetector(
      onTap: (){
       Navigator.pushNamed(context, "/orderdetailsScreen",arguments: data.id);
      },
      child: Container(
        height: 15.0.h,
        child: Column(
          children: [
            Container(
            padding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _orderData(data),
                _price(data.cost)
              ],
          ),
            ),
            Divider(color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  Widget _orderData(OrdersData data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Order ID : ${data.id}",
          style: TextStyle(
          color: AppColor.black,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
        ),),
        Text("Ordered Date : ${data.created}",
          style: TextStyle(
              color: AppColor.greyColor,
              fontSize: 10.0.sp,
              fontWeight: FontWeight.bold
          ),)
      ],
    );
  }

  Widget _price(int cost) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w,vertical: 3.0.h),
      child: Text("Rs ${cost}.00",
        style: TextStyle(
            color: AppColor.black,
            fontSize: 18.0.sp,
            fontWeight: FontWeight.bold
        ),)
    );
  }
}
