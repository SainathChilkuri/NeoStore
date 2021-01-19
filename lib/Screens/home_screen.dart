import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_events.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_state.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_bloc.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_state.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_bloc.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_states.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Constants/constants.dart';
import 'package:neostore/Model/Product%20Data/product.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:sizer/sizer.dart';

import 'Widgets/custom_drawer.dart';
class HomeScreen extends StatefulWidget {
  final String accessToken;
  HomeScreen({
    this.accessToken
});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("HomeScreen");

  }
  @override
  Widget build(BuildContext context) {
    String mAccessToken = widget.accessToken;
    //BlocProvider.of<HomeBloc>(context).add(FetchUserDetails(accessToken: mAccessToken));
    return BlocBuilder<HomeBloc,HomeStates>(
        // ignore: missing_return
        builder: (context,state){
          if(state is HomeInitialState){
            BlocProvider.of<HomeBloc>(context).add(FetchUserDetails(accessToken: mAccessToken));
            return Scaffold(
              body: Center(child: CircularProgressIndicator(backgroundColor: AppColor.primaryColor,),
            ));
          }
          if(state is FetchUserState){
            var data = state.user.data;
            return _homeScreen(data);
          }
          if(state is FetchIncompleteState){
            return Scaffold(
                body: Center(child: Text("Failed To Load"),
                ));
          }
        });
  }
  Widget _homeScreen(Data data) {
    print(data.userData.accessToken);
    return Scaffold(
      appBar: _appBar(),
      drawer: CustomDrawer(data: data),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _carousel(),
                _productCategories(Product.product_categories)
              ],
            ),
          )
      ),
    );
  }

  Widget _carousel() {
    return Container(
      alignment: Alignment.topCenter,
      height: 35.0.h,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        images: [
          AssetImage("assets/carousel/slider_img1.jpg"),
          AssetImage("assets/carousel/slider_img2.jpg"),
          AssetImage("assets/carousel/slider_img3.jpg"),
          AssetImage("assets/carousel/slider_img4.jpg"),
        ],
        dotSize: 1.5.w,
        dotSpacing: 3.5.w,
        dotColor: AppColor.primaryColor,
        dotIncreasedColor: AppColor.black,
        dotBgColor: Colors.transparent,
      ),
    );
  }

 Widget _productCategories(List<Map<String,dynamic>> products) {
    return Container(
      margin: EdgeInsets.only(left: 2.0.w,right: 2.0.w,top: 2.0.h,bottom: 2.0.h),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemBuilder: (context,index){
            return productTiles(products[index],index);
          }),
    );
 }

  Widget productTiles(Map<String,dynamic> product,int index) {
    if(index%2 == 0){
      return GestureDetector(
        onTap: (){
         Navigator.pushNamed(context, "/productlistingScreen",arguments: product);
        },
        child: Container(
          margin: EdgeInsets.only(left:1.0.w,right: 1.0.w,top: 1.0.h),
          height: 15.0.h,
          width: 15.0.w,
          decoration: BoxDecoration(
              color: index == 0?AppColor.primaryColor:AppColor.darkRed
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 2.0.h,right: 2.0.w),
                child: Text(product["name"],
                  style: TextStyle(
                      color: AppColor.whiteText,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.0.h,right: 9.0.w),
                alignment: Alignment.bottomLeft,
                height: 12.0.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: _image(product["name"])
                    )
                ),
              )
            ],
          ),
        ),
      );
    }
    else{
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, "/productlistingScreen",arguments: product);
        },
        child: Container(
          margin: EdgeInsets.only(left:1.0.w,right: 1.0.w,top: 1.0.h),
          height: 15.0.h,
          width: 15.0.w,
          decoration: BoxDecoration(
              color: index == 3?AppColor.primaryColor:AppColor.darkRed
          ),
          child: Column(
            children: [
              Container(
                height: 12.0.h,
                margin: EdgeInsets.only(left: 10.0.w,top: 2.0.h),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: _image(product["name"])
                    )
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 1.0.h,left: 2.0.w),
                child: Text(product["name"],
                  style: TextStyle(
                      color: AppColor.whiteText,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold
                  ),),
              ),

            ],
          ),
        ),
      );
    }
  }

  _image(String name) {
    if(name =="Tables"){
      return AssetImage("assets/icons/table.png");
    }
    if(name =="Chairs"){
      return AssetImage("assets/icons/chair.png");
    }
    if(name =="Sofa"){
      return AssetImage("assets/icons/sofa.png");
    }
    if(name =="Cupboard"){
      return AssetImage("assets/icons/cupboard.png");
    }
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        Constants.neoSoftTitle,
        style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20.0.sp
        ),
      ),
      centerTitle: true,
    );
  }


}
