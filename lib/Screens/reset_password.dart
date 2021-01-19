import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/LoginBloc/login_bloc.dart';
import 'package:neostore/Blocs/LoginBloc/login_event.dart';
import 'package:neostore/Blocs/LoginBloc/login_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Constants/constants.dart';
import 'package:sizer/sizer.dart';
class ResetPasswordScreen extends StatefulWidget {
  final String token;
  ResetPasswordScreen({
    this.token
});
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _oldPasswordText = TextEditingController();
  TextEditingController _newPasswordText = TextEditingController();
  TextEditingController _confirmPasswordText = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(
      listener: (context,state){
        if(state is ResetPasswordSuccesfull){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(state.msg)));
        }
        if(state is ResetPasswordFailed){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text(state.msg)));
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
            appBar: _appBar("Reset Password"),
            body: Wrap(
              children: [
                Stack(
                  children: [
                    _backgroundImage(),
                    Container(
                      margin: EdgeInsets.only(top: 6.0.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _neostoreTitle(),
                            _oldpassword(),
                            _newPassword(),
                            _confirmPassword(),
                            _changepassword()
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
    );
  }
  Widget _appBar(String s) {
    return AppBar(
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
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover
          )
      ),
    );
  }

  Widget _neostoreTitle() {
      return Container(
        margin: EdgeInsets.only(top: 9.0.h,left: 10.0.w,right: 5.0.w),
        child: Text(Constants.neoSoftTitle,
          style: TextStyle(
              color: AppColor.whiteText,
              fontSize: 40.0.sp,
              fontWeight: FontWeight.bold
          ),),
      );
    }

  Widget _oldpassword() {
    return Container(
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 7.0.w,right: 7.0.w),
      child: TextFormField(
        controller: _oldPasswordText,
        validator: (String value){
          if(value.isEmpty){
            return "Old Pssword is required";
          }
        },
        decoration:inputDecortaion("Old Password","assets/icons/password_icon.png"),
      ),
    );
  }

  Widget _newPassword() {
    return Container(
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 7.0.w,right: 7.0.w),
      child: TextFormField(
        controller: _newPasswordText,
        validator: (String value){
          if(value.isEmpty){
            return "New Pssword is required";
          }
        },
        decoration:inputDecortaion("New Password","assets/icons/cpassword_icon.png"),
      )
    );
  }

  Widget _confirmPassword() {
    return Container(
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 7.0.w,right: 7.0.w),
      child: TextFormField(
        controller: _confirmPasswordText,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Confirm Pssword is required";
          }
          if(value != _newPasswordText.text){
            return "Password Not Matched";
          }
        },
        decoration:inputDecortaion("Confirm Pssword","assets/icons/password_icon.png"),
      ),
    );
  }

  InputDecoration inputDecortaion(String name, String imagePath) {
    return  InputDecoration(
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.whiteText),
      ),
      errorStyle: TextStyle(
        color: AppColor.whiteText,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.whiteText),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.whiteText),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.whiteText),
      ),
      labelText: name,
      labelStyle: TextStyle(
          color: AppColor.whiteText,
          fontWeight: FontWeight.bold,
          fontSize: 16.0.sp
      ),
      //focusColor: AppColor.whiteText,
      prefixIcon: Image.asset(imagePath),
    );
  }
  Widget _changepassword() {
    return GestureDetector(
      onTap: (){
        _validate();
      },
      child: Container(
        alignment: Alignment.center,
        height: 7.0.h,
        margin: EdgeInsets.only(left:8.0.w,right: 8.0.w,top: 3.0.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                1.0.h
            ),
            color: AppColor.whiteText
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

  void _validate() {
    if(_formKey.currentState.validate()){
        BlocProvider.of<LoginBloc>(context).add(ResetPasswordEvent(
            access_token: widget.token,
            oldPassword: _oldPasswordText.text,
            newPassword: _newPasswordText.text,
            confirmPassword: _confirmPasswordText.text));
    }
  }
}
