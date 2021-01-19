import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/AddressBloc/address_bloc.dart';
import 'package:neostore/Blocs/AddressBloc/address_events.dart';
import 'package:neostore/Blocs/AddressBloc/address_states.dart';
import 'package:neostore/Blocs/CartBloc/cart_bloc.dart';
import 'package:neostore/Blocs/CartBloc/cart_events.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_events.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_events.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Database/database.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _selectedAddress=null;
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<AddressTableDao>(context);
    return BlocListener<OrderListBloc,OrderListState>(
      listener: (context,state){
        if(state is OrderPlacedSuccessfullyState){
          _showSnackBar(state.successMsg);
          BlocProvider.of<OrderListBloc>(context).add(FetchOrderList());
          BlocProvider.of<CartBloc>(context).add(CartFetchData());
          BlocProvider.of<HomeBloc>(context).add(AccountUpdateEvent());

        }
        if(state is OrderPlacedFailedState){
          _showSnackBar(state.errorMsg);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.lightGreyColor,
        appBar: _appBar("Address List"),
        body: BlocConsumer<AddressBloc,AddressScreenState>(
          listener: (context,state){
            if(state is AddressDeletedState){
              BlocProvider.of<AddressBloc>(context).add(AddressFetchEvent(addressTableDao: dao));
            }
            if(state is AddressInsertedState){
              BlocProvider.of<AddressBloc>(context).add(AddressFetchEvent(addressTableDao: dao));
            }
            if(state is AddressFailedState){
              BlocProvider.of<AddressBloc>(context).add(AddressFetchEvent(addressTableDao: dao));
            }
          },
          // ignore: missing_return
          builder: (context,state){
            if(state is AddressInitialState){
              BlocProvider.of<AddressBloc>(context).add(AddressFetchEvent(addressTableDao: dao));
              return Container(
                child: Text("Loading...."),
              );
            }
            if(state is AddressLoadingState){
              return Center(
                child: CircularProgressIndicator(backgroundColor: AppColor.primaryColor,),
              );
            }
            if(state is AddressInsertedState){
              return Container();
            }
            if(state is AddressDeletedState){
              return Container();
            }
            if(state is AddressLoadState){
              return _showAddress(state.addressTableData,dao);
            }
            if(state is AddressEmptyState){
              return Center(
                child: Text("Add Your Address"),
              );
            }
            if(state is AddressFailedState){
              return Center(
                child: Text("Some Error Happend"),
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
      actions: [
        IconButton(
            icon: Icon(Icons.add,color: AppColor.whiteText,),
            onPressed: (){
              Navigator.pushNamed(context,"/addAddressScreen");
            })
      ],
      centerTitle: true,
    );
  }

  Widget _showAddress(List<AddressTableData> addressTableData, AddressTableDao dao) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0.w,top: 3.0.h,bottom: 1.0.h),
          child: Text("Shipping Address",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 15.0.sp
          ),),
        ),
        _listOfAddress(addressTableData,dao),
        _submitButton()
      ],
    );

  }

  String _generateAddress(AddressTableData addressTableData) {
    return "${addressTableData.addressLine}, ${addressTableData.landmark}, ${addressTableData.city}, ${addressTableData.state}- ${addressTableData.zipcode}. ${addressTableData.country}";
  }


  _listOfAddress(List<AddressTableData> addressTableData, AddressTableDao dao) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: addressTableData.length,
        itemBuilder: (context,index){
          return _address(dao,addressTableData[index]);
        });
  }

  Widget _address( AddressTableDao dao, AddressTableData addressTableData) {
    var address = _generateAddress(addressTableData);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
                value: address,
                groupValue: _selectedAddress,
              onChanged: (value){
                  setState(() {
                    _selectedAddress = value;
                    print(_selectedAddress);
                  });
              },
            ),
            Flexible(
              child: Stack(
                children: [
                 Container(
                    padding: EdgeInsets.symmetric(vertical: 1.0.h,horizontal: 2.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0.w),
                      border: Border.all(color: AppColor.greyColor),
                      color: AppColor.whiteText
                    ),
                    child: Column(
                      children:[
                        Container(
                          height: 2.0.h,
                        ),
                        Text(
                        address,style: TextStyle(
                        fontSize: 15.0.sp
                        ),
                       )
                      ],
                    ),
                  ),
                 GestureDetector(
                   onTap: (){
                     showDialog(
                         context: context,
                     builder: (context){
                           return _alertDialog(addressTableData,dao);
                     });
                   },
                   child: Align(
                     alignment: Alignment.topRight,
                     child: Container(
                       margin: EdgeInsets.only(right: 4.0.w),
                       height: 5.0.h,
                       width: 5.0.w,
                       child: Icon(Icons.highlight_remove_outlined,color: AppColor.primaryColor,),
                     ),
                   ),
                 )
                ],
              ),
            )
          ],
      ),
    );
  }

  Widget _alertDialog(AddressTableData addressTableData, AddressTableDao dao) {
    return AlertDialog(
      content: Text("Are you Sure?"),
      actions: [
        FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("No")),
        FlatButton(
            onPressed: (){
              BlocProvider.of<AddressBloc>(context).add(AddressDeleteEvent(addressTableDao: dao, addressTableData: addressTableData));
              Navigator.pop(context);
            },
            child: Text("Yes"))
      ],
    );
  }

 Widget _submitButton() {
   return GestureDetector(
     onTap: (){
     if(_selectedAddress!=null){
       BlocProvider.of<OrderListBloc>(context).add(OrderPlaceEvent(address: _selectedAddress));
     }else{
       _showSnackBar("Please Select a Address");
     }
     },
     child: Container(
       height: 8.0.h,
       margin: EdgeInsets.only(left: 3.0.w,right: 3.0.w,top: 3.0.h),
       alignment: Alignment.center,
       child: Text("PLACE ORDER",
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
  _showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

}
