import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/ProductLoadBloc/product_bloc.dart';
import 'package:neostore/Blocs/ProductLoadBloc/product_events.dart';
import 'package:neostore/Blocs/ProductLoadBloc/product_states.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/Product%20Data/product_model.dart';
import 'package:sizer/sizer.dart';
class ScreenArguments{
  final Map<String,dynamic> product;
  final int id;
  final String name;
  ScreenArguments({
    this.name,
    this.product,
    this.id
});
}
class ProductListingScreen extends StatefulWidget {
  final Map<String,dynamic> product;
  ProductListingScreen({
    this.product
});
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(ProductLoadData(id: widget.product["id"]));
    return Scaffold(
      appBar: _appbar(widget.product["name"]),
      body: BlocBuilder<ProductBloc,ProductState>(
        // ignore: missing_return
        builder: (context,state){
          if(state is ProductInitialState){
            return Center(child: Text("No Data to Show"),);
          }
          if(state is ProductDataLoading){
            return Center(child: CircularProgressIndicator(backgroundColor: AppColor.primaryColor,),);
          }
          if(state is ProductLoadState){
            return _listOfProduct(state.data.data,widget.product);
          }
          if(state is ProductLoadFailedState){
            return Center(child: Text("Failed"),);
          }
        },
      ),
    );
  }

  Widget _appbar(String s) {
    return AppBar(
      title: Text(s,style:
      TextStyle(
          color: AppColor.whiteText,
          fontSize: 20.0.sp,
        fontWeight: FontWeight.bold
      ),),
      centerTitle: true,
    );

  }

  Widget _listOfProduct(List<Data> data, Map<String, dynamic > product) {
    return ListView.builder(
      itemCount: data.length,
        itemBuilder: (context,index){
        return _productDetails(data[index],product);
        });
  }

  Widget _productDetails(Data data, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: (){
          Navigator.pushNamed(context, "/productdetailsScreen",arguments: ScreenArguments(product: product,id: data.id,name: data.name))
              .then((value) {
            setState(() {

            });
          });
      },
      child: Container(
        child: Column(
            children:[
                 Container(
                  margin: EdgeInsets.only(left: 3.0.w,right: 3.0.w,top: 3.0.w,bottom: 3.0.w),
                   child: Row(
                    children: [
                      _imageOfProduct(data.productImages),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _title(data.name),
                                _produces(data.producer),
                                Container(
                                  margin: EdgeInsets.only(top: 1.5.h),
                                  child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _price(data.cost),
                                      _rating(data.rating)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
            Divider(thickness: 0.2.h,color: Colors.grey,)],
        ),
      ),
    );
  }

  _imageOfProduct(String productImages) {
    return Container(
      height: 10.0.h,
      width: 25.0.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(productImages),
          fit: BoxFit.cover
        )
      ),
    );
  }

  _title(String name) {
    return  Container(
             child: Text(
                name,
               style: TextStyle(
               fontSize: 16.0.sp, color: AppColor.black,
              fontWeight: FontWeight.bold
            ),
            ),
    );
  }

  _produces(String producer) {
    return  Container(
      child: Text(
        producer,style: TextStyle(
          fontSize: 10.0.sp,
          color: AppColor.black,
      ),
      ),
    );
  }

  _price(int cost) {
    return  Container(
      alignment: Alignment.topRight,
      child: Text(
        "Rs ${cost}",style: TextStyle(
        fontSize: 20.0.sp,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
      ),
    );
  }

  _rating(int rating) {
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
    /*return  Container(
      alignment: Alignment.topRight,
      child: Text(
        "${rating}",style: TextStyle(
        fontSize: 10.0.sp,
        color: AppColor.black,
      ),
      ),
    );
  }*/
}
