import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore/API%20Service/CartService/cart_service.dart';
import 'package:neostore/API%20Service/OrdersService/orders_service.dart';
import 'package:neostore/API%20Service/ProductService/product_service.dart';
import 'package:neostore/Blocs/CartBloc/cart_bloc.dart';
import 'package:neostore/Blocs/CartBloc/cart_events.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_events.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_bloc.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_events.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/Product%20Data/product_detail_model.dart';
import 'package:neostore/Screens/Product%20Screen/product_listing_screen.dart';
import 'package:neostore/main.dart';
import 'package:sizer/sizer.dart';
class ProductDetailsScreen extends StatefulWidget {
  final ScreenArguments data;
  ProductDetailsScreen({
    this.data,
 });
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  TextEditingController _quantity = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _rating=3;
  var _selectedImage;
  var name;
  int id;
  Map<String,dynamic> product;
  @override
  Widget build(BuildContext context) {
    print(widget.data.id);
    name= widget.data.name;
    id = widget.data.id;
    BlocProvider.of<DetailsBloc>(context).add(LoadProductDetails(id: widget.data.id));
    product = widget.data.product;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffe0e0e0),
      appBar: _appBar(name),
      body: BlocBuilder<DetailsBloc,DetailsState>(
        // ignore: missing_return
        builder: (context,state){
          if(state is DetailsInitial){

            return Center(
              child: Text("Details Not There"),
            );
          }
          if(state is DetailsLoading){
            return Center(
              child: CircularProgressIndicator(backgroundColor: AppColor.primaryColor,),
            );
          }
          if(state is DetailsSuccessLoad){
            return _showDetails(state.productDetailModel);
          }
          if(state is DetailsFailLoad){
            return Center(child: Text(state.errorMsg),);
          }
        },

      ),
    );
  }

  Widget _appBar(String name) {
    return AppBar(
      title:  Text(name,style:
      TextStyle(
          color: AppColor.whiteText,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.bold
      ),),
      centerTitle: true,
    );

  }
 Widget _title(String name) {
    return Container(
      child: Text(
        name,
        style: TextStyle(
          color: AppColor.black,
          fontSize: 20.0.sp,
          fontWeight: FontWeight.bold
        ),
      ),
    );
 }

  Widget _category(product) {
    return Container(
      child: Text(
        "Category - $product",
        style: TextStyle(
            color: AppColor.greyColor,
            fontSize: 16.0.sp,
        ),
      ),
    );
  }

  _stars(int rating) {
      if(rating == 1){
        return Container(
          height: 2.0.h,
          width: 30.0.w,
          child: Row(
            children: [
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
            ],
          ),
        );
      }else if(rating == 2){
        return Container(
          height: 2.0.h,
          width: 30.0.w,
          child: Row(
            children: [
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
            ],
          ),
        );
      }
      else if(rating == 3){
        return Container(
          height: 2.0.h,
          width: 30.0.w,
          child: Row(
            children: [
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_unchek.png"),
              Image.asset("assets/icons/star_unchek.png"),
            ],
          ),
        );
      }
      else if(rating == 4){
        return Container(
          height: 2.0.h,
          width: 30.0.w,
          child: Row(
            children: [
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_unchek.png"),
            ],
          ),
        );
      }
      else if(rating == 5){
        return Container(
          height: 2.0.h,
          width: 5.0.w,
          child: Row(
            children: [
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
              Image.asset("assets/icons/star_check.png"),
            ],
          ),
        );
      }
  }

 Widget _upperContainer(Data data, Map<String,dynamic > product) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 3.0.w,right: 3.0.w,top: 1.5.h,bottom: 1.0.h),
      decoration: BoxDecoration(
          color: AppColor.whiteText
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(data.name),
          _category(product["name"]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.producer,
                style: TextStyle(
                    fontSize: 12.0.sp,
                    color: AppColor.greyColor
                ),
              ),
              _stars(data.rating)

            ],
          )
        ],
      ),
    );
  }

  Widget _middleCard(Data data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 4.0.h),
      height: data.productImages.length==0?30.0.h:58.0.h,
      decoration: BoxDecoration(
        color: AppColor.whiteText,
            borderRadius: BorderRadius.circular(1.5.w)
      ),
      child: Column(
        children: [
          _price(data.cost),
         _mainImage(data.productImages),
          _listviewImage(data.productImages),
          Divider(color: AppColor.greyColor,),
          Expanded(child: SingleChildScrollView(child: _description(data.description)))
         /* Row(
            children: _images(data.productImages)
          )*/
        ],
      ),
    );
  }

  Widget _price(int cost) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rs $cost",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20.0.sp
            ),

          ),
          Container(
            width: 6.0.w,
            height: 6.0.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/share.png"),
                fit: BoxFit.contain
              )
            ),
          )
        ],
      ),
    );
  }

 Widget _mainImage(List<ProductImages> productImages) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0.w),
      height: 25.0.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _selectImage(productImages)
        )
      ),
    );
 }

  Widget _showDetails(ProductDetailModel productDetailModel) {
      _selectedImage = 0;
    return Column(
      children: [
        _upperContainer(productDetailModel.data,product),
        _middleCard(productDetailModel.data),
        _bottomContainer(productDetailModel.data)
      ],
    );
  }

   _selectImage(List<ProductImages> productImages) {
    if(_selectedImage == 0){
      return NetworkImage(
        productImages[0].image
      );
    }
    if(_selectedImage == 1){
      return NetworkImage(
          productImages[1].image
      );
    }
    if(_selectedImage == 2){
      return NetworkImage(
          productImages[2].image
      );
    }
    if(_selectedImage == 3){
      return NetworkImage(
          productImages[3].image
      );
    }
  }
  Widget _listviewImage(List<ProductImages> productImages) {
    if(productImages.length >0){
      return Expanded(
        child: ListView.builder(
          //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productImages.length,
            itemBuilder: (context, index){
              return   GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedImage = index;
                    print(_selectedImage);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(1.0.w),
                  margin: EdgeInsets.symmetric(horizontal: 2.0.w,vertical: 3.0.h),
                  width: 22.0.w,
                  height: 5.0.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(1.0.w),
                      image: DecorationImage(
                          image: NetworkImage(
                              productImages[index].image
                          ),fit: BoxFit.contain
                      )
                  ),
                ),
              );
            }),
      );
    }else{
      return Container(
        child: Text("No More Images"),
      );
    }
  }

 Widget  _description(String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.0.h,left: 3.0.w,right: 3.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description",style:
            TextStyle(
              fontWeight:FontWeight.bold,
              color: AppColor.black,
              fontSize: 20.0.sp
            ),),
            SingleChildScrollView(
              child: Text(description,
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    color: AppColor.greyColor
                  ),
              ),
            ),
      ]
              ),
    );
 }

  Widget _bottomContainer(Data data) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 3.0.w,right: 3.0.w),
        height: 20.0.h,
        decoration: BoxDecoration(
          color: AppColor.whiteText
        ),
        alignment: FractionalOffset.center,
        child: Row(
          children: [
            _buyNow(data),
            SizedBox(width: 2.0.w,),
            _rateNow(data)
          ],
        ),
      ),
    );
  }

  _buyNow(Data data) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: ()async {
          var result = await showDialog(
              context: context,
              builder: (context){
                return _showBuyDialog(data);
              });
          _showSnackBar(result);
        },
        child: Container(
          height: 6.0.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(2.0.w)
          ),
          child: Text("BUY NOW",
            style: TextStyle(
                color: AppColor.whiteText,
                fontSize: 14.0.sp
            ),),),
      ),
    );
  }

  Widget _rateNow(Data data) {
    return Expanded(flex: 1,
      child: GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (context){
                return _showDialog(data);
              });
        },
        child: Container(
          height: 6.0.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2.0.w)
          ),
          child: Text("RATE",
            style: TextStyle(
                color: AppColor.greyColor,
                fontSize: 14.0.sp
            ),),),
      ),
    );
  }

 Widget _showDialog(Data data) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 4.0.h),
          child: Column(
            children: [
              _titleDialog(data.name),
              _imageDialog(data.productImages[0]),
              _ratingDialog(data.rating),
              _rateButtonDialog(product["id"]),

            ],
          ),
        ),
      ),
    );
 }

  _titleDialog(String name) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: Text(name,
      style: TextStyle(
        color: AppColor.black,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold
      ),),
    );
  }

  _imageDialog(ProductImages productImag) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      height: 25.0.h,
     decoration: BoxDecoration(
       image: DecorationImage(
         image: NetworkImage(
           productImag.image
         ),
         fit:BoxFit.contain
       )
     ),
    );
  }

  _ratingDialog(int rating) {
    return Container(
     // width: 60.0.w,
        margin: EdgeInsets.only(bottom: 2.0.h),
      child: RatingBar(
        itemSize: 35.0,
        minRating: 0,
        initialRating: rating.toDouble(),
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: Image.asset('assets/icons/star_check.png'),
          empty:Image.asset('assets/icons/star_unchek.png'),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        onRatingUpdate: (rating) {
          setState(() {
            _rating = rating.toInt();
            print(_rating);
          });
        },
      )
    );
  }

  _rateButtonDialog(int product) {
    return GestureDetector(
      onTap: () {
        print(_rating);
        BlocProvider.of<DetailsBloc>(context).add(SetRatingEvent(rating: _rating, product_id: product));
        Navigator.of(context).pop();
        setState(() {

        });
        print(product);
      },
      child: Container(
        alignment: Alignment.center,
        height: 5.0.h,
        child:  Text("RATE",
          style: TextStyle(
              color: AppColor.whiteText,
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold
          ),),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(1.0.w)
            )
        ),
    );
  }

 Widget _showBuyDialog(Data data) {
     return Dialog(
       elevation: 5.0,
       child: SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 4.0.h),
           child: Form(
             key: _formKey,
             child:  Column(
                 children: [
                   _titleDialog(data.name),
                   _imageDialog(data.productImages[0]),
                   Text("Enter Qty"),
                   _quantityBuyDialog(),
                   _buyButtonDialog(data.id),

                 ],
               ),
             ),
           ),
       ),
     );
 }

  _quantityBuyDialog() {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h),
      width: 30.0.w,
      height: 12.0.h,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: _quantity,
        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return "Enter Quantity";
          }
          if(int.parse(value)<1 || int.parse(value)>8){
            return "Qty 1-8";
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red
          ),
          focusColor: AppColor.primaryColor,
          border: OutlineInputBorder(
          )
        ),
      ),
    );
  }

  _buyButtonDialog(int product_id) {
    return GestureDetector(
      onTap: () async {
        if(_formKey.currentState.validate()){
          var qty = int.parse(_quantity.text);
            print(_quantity.text);
            Response response = await CartService().addToCart(product_id,qty);
            var data= json.decode(response.data);
            if(response.statusCode==200){
              BlocProvider.of<CartBloc>(context).add(CartFetchData());
              BlocProvider.of<HomeBloc>(context).add(AccountUpdateEvent());
              Navigator.pop(context,"Success");
            }else{
              Navigator.pop(context,"Failed");
            }


        }
      },
      child: Container(
          alignment: Alignment.center,
          height: 5.0.h,
          child:  Text("SUBMIT",
            style: TextStyle(
                color: AppColor.whiteText,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold
            ),),
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(1.0.w)
          )
      ),
    );
  }

  void _showSnackBar(String data) {
    if(data == "Success"){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Added to Cart"),
      action: SnackBarAction(
        textColor: AppColor.primaryColor,
        label: "Check Out",
        onPressed: (){
          Navigator.pushReplacementNamed(context, "/cartScreen");
        },
      ),));
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Failed to Add"),));
    }

  }



}
