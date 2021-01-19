import 'package:flutter/material.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/Product%20Data/product.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:neostore/Session/user_session.dart';
import 'package:sizer/sizer.dart';
class CustomDrawer extends StatefulWidget {
  final Data data;
  CustomDrawer({
    this.data
});
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    Data data = widget.data;
    return Drawer(
      child: ListView(
        children: [
          _accountHeader(data.userData),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/cartScreen");
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Icon(Icons.add_shopping_cart,color: AppColor.whiteText,size: 4.0.h,),
            ),
            title: Text("My Cart",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
            trailing: CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              child: Text("${data.totalCarts}"),
            ),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/productlistingScreen",arguments: Product.product_categories[0]);
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Image.asset("assets/icons/table.png"),
            ),
            title: Text("Tables",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/productlistingScreen",arguments: Product.product_categories[2]);
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Image.asset("assets/icons/sofa.png"),
            ),
            title: Text("Sofas",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/productlistingScreen",arguments: Product.product_categories[1]);
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Image.asset("assets/icons/chair.png"),
            ),
            title: Text("Chairs",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/productlistingScreen",arguments: Product.product_categories[3]);
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Image.asset("assets/icons/cupboard.png"),
            ),
            title: Text("Cupboard",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/myaccountScreen", arguments: data.userData).then((value) {
                setState(() {

                });
              });
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Icon(Icons.account_circle,color: AppColor.whiteText,size: 4.0.h,),
            ),
            title: Text("My Account",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/storelocatorScreen");
            },
            leading: Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Icon(Icons.location_on_outlined,color: AppColor.whiteText,size: 4.0.h,)
            ),
            title: Text("Store Locator",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/ordersScreen");
            },
            leading: Container(
                height: 8.0.h,
                width: 8.0.w,
                child: Icon(Icons.today_outlined,color: AppColor.whiteText,size: 4.0.h,),
            ),
            title: Text("My Orders",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
          ListTile(
            onTap: (){
              _logoutUser();

            },
            leading:Container(
              height: 8.0.h,
              width: 8.0.w,
              child: Icon(Icons.logout,color: AppColor.whiteText,size: 4.0.h,),
              ),
            title: Text("Logout",
              style: TextStyle(
                  color: AppColor.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
              ),),
          ),
          Divider(color: AppColor.black,),
        ],
      ),
    );
  }

  Widget _username(UserData user) {
    return Text(user.firstName + " " + user.lastName,style: TextStyle(
        color: AppColor.whiteText,
        fontWeight: FontWeight.bold,
        fontSize: 16.0.sp
    ),);
  }

 Widget  _gmail(UserData user) {
    return Text(user.email,style: TextStyle(
        color: AppColor.whiteText,
        fontSize: 10.0.sp
    ),);
  }

  Widget _userpicture(UserData user) {
    return GestureDetector(
      onTap: (){
        _showUserImageDialog(user.profilePic,user.firstName);
      },
        child: Container(
          margin: EdgeInsets.only(top: 1.0.h,bottom: 0.5.h),
          child: RotatedBox(
            quarterTurns: -1,
            child: CircleAvatar(
              radius: 7.0.h,
              child: user.profilePic==null?
                  Text(user.firstName[0].toUpperCase()):
                  CircleAvatar(
                    radius: 7.0.h,
                    backgroundImage: NetworkImage(
                      user.profilePic
                    ),
                  ),
            ),
          ),
        ),
    );
  }

  Widget _accountHeader(UserData user) {
    return  Container(
            //height: 40.0.h,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  _userpicture(user),
                  _username(user),
                  _gmail(user)
                ]
            ),

    );
  }

  void _logoutUser() {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppColor.primaryColor,
            content: Text("Are you Sure",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp
            ),),
            actions: [
              Row(
                children: [
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("No",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0.sp
                        ),)),
                  FlatButton(
                      onPressed: (){
                        UserSession().clearData();
                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context,"/loginScreen");
                      },
                      child: Text("Yes",
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0.sp
                        ),))
                ],
              )

            ],
          );
        }
          );
  }

  void _showUserImageDialog(String profilePic,String firstname) {
    showDialog(
        context: context,
    builder: (context){
          return AlertDialog(
            shape: CircleBorder(),
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              child: RotatedBox(
                quarterTurns: -1,
                child: CircleAvatar(
                  radius: 17.0.h,
                  child: profilePic==null?
                  Text(firstname[0].toUpperCase()):
                  CircleAvatar(
                    radius: 17.0.h,
                    backgroundImage: NetworkImage(
                        profilePic
                    ),
                  ),
                ),
              ),
            )
          );
    });
  }

}
