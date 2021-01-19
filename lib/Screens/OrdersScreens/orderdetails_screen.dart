import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderDetails/orderdetails_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderDetails/orderdetails_events.dart';
import 'package:neostore/Blocs/Orders/OrderDetails/ordersdetails_states.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_events.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/OrdersModel/orderdetails_model.dart';
import 'package:sizer/sizer.dart';
class OrderDetailsScreen extends StatefulWidget {
  final int order_id;
  OrderDetailsScreen({
    this.order_id
});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderDetailsBloc>(context).add(OrderDetailsFetch(orderId: widget.order_id));
    return Scaffold(
      appBar: _appBar(widget.order_id),
      body: BlocBuilder<OrderDetailsBloc,OrderDetailsState>(
        // ignore: missing_return
        builder: (context,state){
          if(state is OrderDetailsInitialState){
            return Center(
              child: Container(
                child: Text("Initial State"),
              ),
            );
          }
          if(state is OrderDetailsLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is OrderDetailsLoadState){
            return _showOrderDetails(state.orderDetailModel);
          }
          if(state is OrderDetailsLoadFailedState){
            return Center(
              child: Text("Some Error Happened: ${state.errorMsg}"),
            );
          }
        },
      ),
    );
  }

  Widget _appBar(int orderId) {
    return AppBar(
      title: Text(
        "Order ID: ${orderId}",
        style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20.0.sp
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _showOrderDetails(OrderDetailModel orderDetailModel) {
    return Column(
      children: [
           ListView.builder(
             shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: orderDetailModel.data.orderDetails.length,
                itemBuilder: (context,index){
                    return _showDetails(orderDetailModel.data.orderDetails[index]);
                 }),
        _total(orderDetailModel.data.cost),
        Divider(color: AppColor.lightGreyColor),


      ],
    );
  }

  Widget _showDetails(OrderDetails orderDetail) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          _order(orderDetail),
          Divider(color: AppColor.lightGreyColor),
        ],

      ),
    );
  }

  _order(OrderDetails orderDetail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h),
      child: Row(
        children: [
          _image(orderDetail.prodImage),
          _remainingContent(orderDetail)
        ],
      ),
    );
  }

 Widget _image(String prodImage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0.w),
      height: 10.0.h,
      width: 15.0.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            prodImage
          ),
          fit: BoxFit.fill
        )
      )
    );
  }

 Widget _remainingContent(OrderDetails orderDetail) {
    return  Flexible(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(orderDetail.prodName),
            _category(orderDetail.prodCatName),
            _qtyNprice(orderDetail.quantity,orderDetail.total)
          ],
      ),
    );
 }

  _title(String prodName) {
    return Container(
      child: Text(
        prodName,
        style: TextStyle(
          color: AppColor.black,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  _category(String prodCatName) {
    return Container(
      child: Text(
        "($prodCatName)",
        style: TextStyle(
            color: AppColor.greyColor,
            fontSize: 10.0.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _qtyNprice(int quantity, int cost) {
    return Container(
        margin: EdgeInsets.only(top: 2.0.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("QTY: $quantity",
                style: TextStyle(
                    color: AppColor.greyColor,
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.bold
                ),),
              Text("Rs ${cost}",
                style: TextStyle(
                  fontSize: 13.0.sp,
                    color: AppColor.greyColor,
                    fontWeight: FontWeight.bold
                ),)
            ],
          ),
    );
  }

  Widget _total(int total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h),
      height: 6.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total",
            style: TextStyle(
                color: AppColor.black,
                fontSize: 13.0.sp,
                fontWeight: FontWeight.bold
            ),
          ),
          Text("Rs ${total}",
            style: TextStyle(
                color: AppColor.black,
                fontSize: 13.0.sp,
                fontWeight: FontWeight.bold
            ),)
        ],
      ),
    );
  }
}
