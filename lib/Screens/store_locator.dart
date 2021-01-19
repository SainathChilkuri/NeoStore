import 'package:flutter/material.dart';
import 'package:neostore/Colors/color.dart';
import 'package:sizer/sizer.dart';
class StoreLocator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar("Store Locator"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/storelocator.png"),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }

 Widget _appBar(String s) {
    return AppBar(
      title: Text(s,style:
        TextStyle(
          color: AppColor.whiteText,
          fontWeight: FontWeight.bold,
          fontSize: 20.0.sp
        ),),
      centerTitle: true,
    );
 }
}
