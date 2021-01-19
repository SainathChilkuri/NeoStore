import 'package:flutter/material.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:sizer/sizer.dart';
class MyAccount extends StatefulWidget {
  final UserData user;
  MyAccount({
    this.user
});
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  UserData user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.firstName);
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
       user  = widget.user;
    });

    return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _appBar("My Account"),
           /* bottomNavigationBar: BottomAppBar(
              child:_resetPassword()
            ),*/
            body: Stack(
            children: [
              _backgroundImage(),
              Wrap(
                children: [Container(
                  margin: EdgeInsets.only(top:13.0.h),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _userImage(user.firstName,user.profilePic),
                      _firstname(user.firstName),
                      _lastname(user.lastName),
                      _mail(user.email),
                      _mobile(user.phoneNo),
                      _dob(user.dob),
                      _submitButton(),
                      _resetPassword()
                    ],
                  ),
                ),]
              )
            ],
            )
          );
  }

  _appBar(String s) {
    return  AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(s,
        style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20.0.sp
        ),),
      centerTitle: true,
    );
  }
  Widget _backgroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover
          )
      ),
    );
  }

 Widget  _userImage(String firstName,String profilePic) {
    return Container(
        margin: EdgeInsets.only(bottom: 3.0.h),
        child: RotatedBox(
          quarterTurns: -1,
          child: CircleAvatar(
            radius: 20.0.w,
            child: profilePic!=null?
                 CircleAvatar(
                     radius: 20.0.w,
                   backgroundImage: NetworkImage(
                     profilePic
                   )
                 ):Text(firstName[0].toUpperCase())
          ),
        ),
    );
  }

  Widget _firstname(String firstName) {
    return Container(
      height: 7.0.h,
      padding: EdgeInsets.only(left: 3.0.w),
      margin: EdgeInsets.only(left: 4.0.w,right: 4.0.w),
      decoration: BoxDecoration(
      border: Border.all(color: AppColor.whiteText)
      ),
      child: Row(
        children: [
          Container(
            height: 7.0.h,
            width: 7.0.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/username_icon.png")
                )
            ),),
          SizedBox(width: 3.0.w),
          Text(firstName,style:
          TextStyle(
              color: AppColor.whiteText,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold
          ),),
        ],
      )
      /*ListTile(
        leading: Image.asset("assets/icons/username_icon.png"),
        title: Text("Sagar",style:
          TextStyle(
            color: AppColor.whiteText,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),),
      ),*/
    );
  }

 Widget _lastname(String lastName) {
    return Container(
        height: 7.0.h,
        padding: EdgeInsets.only(left: 3.0.w),
        margin: EdgeInsets.only(top:1.5.h,left: 4.0.w,right: 4.0.w),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.whiteText)
        ),
        child: Row(
          children: [
            Container(
              height: 7.0.h,
              width: 7.0.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/username_icon.png")
                  )
              ),),
            SizedBox(width: 3.0.w),
            Text(lastName,style:
            TextStyle(
                color: AppColor.whiteText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold
            ),),
          ],
        )
      /*ListTile(
        leading: Image.asset("assets/icons/username_icon.png"),
        title: Text("Sagar",style:
          TextStyle(
            color: AppColor.whiteText,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),),
      ),*/
    );
  }

 Widget _mail(String email) {
    return Container(
        height: 7.0.h,
        padding: EdgeInsets.only(left: 3.0.w),
        margin: EdgeInsets.only(top:1.5.h,left: 4.0.w,right: 4.0.w),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.whiteText)
        ),
        child: Row(
          children: [
            Container(
              height: 7.0.h,
              width: 7.0.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/email_icon.png")
                )
              ),),
            SizedBox(width: 3.0.w),
            Text(email,style:
            TextStyle(
                color: AppColor.whiteText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold
            ),),
          ],
        )
      /*ListTile(
        leading: Image.asset("assets/icons/username_icon.png"),
        title: Text("Sagar",style:
          TextStyle(
            color: AppColor.whiteText,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),),
      ),*/
    );
  }

 Widget _mobile(String phone_no) {
    return Container(
        height: 7.0.h,
        padding: EdgeInsets.only(left: 3.0.w),
        margin: EdgeInsets.only(top:1.5.h,left: 4.0.w,right: 4.0.w),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.whiteText)
        ),
        child: Row(
          children: [
            Container(
              height: 7.0.h,
              width: 7.0.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/cellphone.png")
                  )
              ),),
            SizedBox(width: 3.0.w),
            Text(phone_no,style:
            TextStyle(
                color: AppColor.whiteText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold
            ),),
          ],
        )
      /*ListTile(
        leading: Image.asset("assets/icons/username_icon.png"),
        title: Text("Sagar",style:
          TextStyle(
            color: AppColor.whiteText,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),),
      ),*/
    );
  }

  _dob(String dob) {
    return Container(
        height: 7.0.h,
        padding: EdgeInsets.only(left: 3.0.w),
        margin: EdgeInsets.only(top:1.5.h,left: 4.0.w,right: 4.0.w),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.whiteText)
        ),
        child: Row(
          children: [
            Container(
              height: 7.0.h,
              width: 7.0.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/dob_icon.png")
                  )
              ),),
            SizedBox(width: 3.0.w),
            dob!=null?Text(dob,style:
            TextStyle(
                color: AppColor.whiteText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold
            ),):Text("Not Mentioned",style:
            TextStyle(
                color: AppColor.whiteText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold
            ),),
          ],
        )
      /*ListTile(
        leading: Image.asset("assets/icons/username_icon.png"),
        title: Text("Sagar",style:
          TextStyle(
            color: AppColor.whiteText,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold
          ),),
      ),*/
    );
  }
  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context, "/editprofileScreen",arguments: user);
      },
      child: Container(
        alignment: Alignment.center,
        height: 7.0.h,
        margin: EdgeInsets.only(top:2.0.h,left: 4.0.w,right: 4.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                1.0.h
            ),
            color: AppColor.whiteText
        ),
        child: Text("EDIT PROFILE",
          style: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.bold,
              fontSize: 15.0.sp
          ),),
      ),
    );
  }

  _resetPassword() {
    return  GestureDetector(
      onTap: (){
       // print("Reset");
        Navigator.pushNamed(context, "/resetpasswordScreen",arguments: user.accessToken);
      },
      child:  Container(
            margin: EdgeInsets.only(top: 2.0.h,left: 4.0.w,right: 4.0.w),
            height: 7.0.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                    1.0.h
                     ),
              color: AppColor.whiteText,
            ),

            child: Text("RESET PASSWORD",
              style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0.sp
              ),),
          ),
    );
  }
}
