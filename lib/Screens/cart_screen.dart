import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neostore/Blocs/CartBloc/cart_bloc.dart';
import 'package:neostore/Blocs/CartBloc/cart_events.dart';
import 'package:neostore/Blocs/CartBloc/cart_states.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_events.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/CartModel/cart_model.dart';
import 'package:sizer/sizer.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return BlocListener<CartBloc,CartScreenState>(
      listener: (context,state){
        if(state is CartInsertedState){
          BlocProvider.of<CartBloc>(context).add(CartFetchData());
        }
        if(state is CartDeletedState){
          BlocProvider.of<CartBloc>(context).add(CartFetchData());
          _showSnackBar(state.successMsg);
        }
        if(state is CartEditState){
          BlocProvider.of<CartBloc>(context).add(CartFetchData());
          _showSnackBar(state.msg);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar("My Cart"),
        body: BlocBuilder<CartBloc,CartScreenState>(
          // ignore: missing_return
          builder: (context,state){
            if(state is CartInitialState){
              print("Initial State");
              BlocProvider.of<CartBloc>(context).add(CartFetchData());
              return Center(
                child: Text("My Carts"),
              );
            }
            if(state is CartLoadingState){
              return Center(
                child: CircularProgressIndicator(backgroundColor: AppColor.primaryColor,),
              );
            }
            if(state is CartLoadState){
              print("Cart Loaded State");
              return _showCartItems(state.cartModel);
            }
            if(state is CartEmptyState){
              return _emptyState();
            }
            if(state is CartInsertedState){
              return Container();
            }
            if(state is CartDeletedState){
              return Container();
            }
            if(state is CartEditState){
              return Container();
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

  Widget _emptyState() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
           height:30.0.h,
           decoration: BoxDecoration(
               image: DecorationImage(
               image: AssetImage("assets/icons/emptycart.png"),
                fit: BoxFit.fill
               )
            ),
        ),
          Container(
            child: Text("Nothing in the Cart",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0.sp
            ),),
          )
        ],
      ),
    );
  }

  Widget _showCartItems(CartModel cartModel) {
    return ListView(
        children: [
          _carts(cartModel),
          _totalPrice(cartModel),
          Divider(color: AppColor.lightGreyColor,thickness: 1.0,),
          _orderButton(),
          _blankContainer()
        ],
    );

  }
  Widget _carts(CartModel cartModel) {
    return  ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
        itemCount: cartModel.data.length,
        itemBuilder: (context,index){
          return _cartItems(cartModel.data[index],cartModel.total);
        });
  }
  Widget _totalPrice(CartModel cartModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0.w,vertical: 2.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 18.0.sp,
            fontWeight: FontWeight.bold
          ),),
          Text("${cartModel.total}.00",
            style: TextStyle(
                color: AppColor.black,
                fontSize: 15.0.sp,
                fontWeight: FontWeight.bold
            ),),
        ],
      ),
    );
  }
  Widget _blankContainer() {
    return Container(
      height: 20.0.h,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _cartItems(OrderData data,int total,) {
    return  Column(
        children: [
          Container(
            child: Slidable(
             closeOnScroll: true,
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h),
                  width: MediaQuery.of(context).size.width,
                  //height: 18.0.h,
                  child: Row(
                    children: [
                      _itemImage(data.product.productImages),
                      _remainingContent(data,total),
                    ],
                  ),
                ),
            secondaryActions: [
              IconSlideAction(
                color: AppColor.whiteText,
                iconWidget: Container(
                  height: 18.0.h,
                  width: 16.0.w,
                  child: Image.asset("assets/icons/delete.png",fit: BoxFit.contain,),
                ),
                onTap: (){
                  print("Delete Item");
                  showDialog(
                      context: context,
                  builder: (context){
                        return AlertDialog(
                          content: Text("Want to Delete ${data.product.name}"),
                          actions: [
                            FlatButton(
                                onPressed: (){

                                  Navigator.pop(context);
                                },
                                child: Text("No")),
                            FlatButton(
                                onPressed: (){
                                  BlocProvider.of<CartBloc>(context).add(CartDeleteData(product_id: data.productId));
                                  BlocProvider.of<CartBloc>(context).add(CartFetchData());
                                  BlocProvider.of<HomeBloc>(context).add(AccountUpdateEvent());
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"))
                          ],
                        );
                  });

                },
              ),
            ],
        ),
          ),
          Divider(color: AppColor.lightGreyColor,thickness: 1.0,)
        ],
    );
  }

  Widget _itemImage(String productImages) {
    print(productImages);
    return Container(
      width: 20.0.w,
      height:12.0.h,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  productImages
              ),
              fit: BoxFit.fill
          )
      ),
    );
  }

  Widget _title(String name) {
    return Container(
      child: Text(name,
      style: TextStyle(
        color: AppColor.black,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.bold
      ),),
    );
  }

  Widget _category(String productCategory) {
    return Container(
      child: Text("($productCategory)",
        style: TextStyle(
            color: AppColor.black,
            fontSize: 10.0.sp,
        ),),
    );
  }

  Widget _remainingContent(OrderData data,int total) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(left: 3.0.w,top: 2.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(data.product.name),
            _category(data.product.productCategory),
            _priceRow(data.productId,data.quantity,data.product.cost)
          ],
        ),
      ),
    );
  }

  Widget _priceRow(int product_id,int quantity, int cost) {
    return  Container(
      margin: EdgeInsets.only(top: 1.0.h),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dropDown(product_id,quantity),
                _price(cost)
              ],
      ),
    );
  }

  Widget _dropDown(int product_id,int quantity,) {
    return  Container(
      width: 15.0.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0.w),
            color: AppColor.lightGreyColor
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            dropdownColor: AppColor.lightGreyColor,
            icon: Icon(Icons.keyboard_arrow_down),
            value: quantity,
            onChanged: (value){
              quantity = value;
              BlocProvider.of<CartBloc>(context).add(CartEditData(product_id: product_id, qty: quantity));
             /* setState(() {

              });*/
            },
            items: List.generate(8, (index){
              return DropdownMenuItem(
                   value: index+1,
                  child: Center(child: Text("${index+1}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0.sp
                  ),)) );
            }),
        ),
      ),
    );
  }

  Widget _price(int cost) {
    return Text("$cost.00",
    style: TextStyle(
      fontSize: 13.0.sp,
      fontWeight: FontWeight.bold
    ),);
  }

 Widget _orderButton() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/addresslistScreen");
      },
      child: Container(
        height: 8.0.h,
        margin: EdgeInsets.only(left: 3.0.w,right: 3.0.w,top: 3.0.h),
        alignment: Alignment.center,
        child: Text("ORDER NOW",
        style: TextStyle(
          color: AppColor.whiteText,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.bold
        ),),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(2.0.w)
        ),
      ),
    );
 }

  @override
  void dispose() {
    super.dispose();
    CartBloc().close();
  }

  void _showSnackBar(String successMsg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(successMsg)));
  }
}
