import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/LoginBloc/login_bloc.dart';
import 'package:neostore/Blocs/LoginBloc/login_event.dart';
import 'package:neostore/Blocs/LoginBloc/login_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Constants/constants.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:sizer/sizer.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return BlocListener<LoginBloc,LoginState>(
      listener: (context,state){
        if(state is LoginSuccesfullState){
          _navigateToHomeScreen(state.accessToken);
        }
      },
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: _floatingActionButton(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              _backgroundImage(),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                      children:[
                        _neoSoftTitleName(),
                        _usernameField(),
                        _passwordField(),
                        _submitButton(),
                        _forgotPassword(),
                        BlocBuilder<LoginBloc,LoginState>(
                          // ignore: missing_return
                          builder: (context,state){
                            if(state is LoginLoadingState){
                             return _indicator();
                            }
                            if(state is LoginInitialState){
                              return Container();
                            }
                            if(state is LoginSuccesfullState){
                              return Container();
                            }
                            if(state is LoginFailedState){
                              return Container(child: Text(
                                state.errorMsg
                              ),);
                            }
                            if(state is ResetPasswordSuccesfull){
                              return Container();
                            }
                            if(state is ResetPasswordFailed){
                              return Container();
                            }
                          },
                           )
                      ] ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 Widget _backgroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png")
        )
      ),
    );
 }

  Widget _neoSoftTitleName() {
    //print(queryData.size.height/15);
    return Container(

      margin: EdgeInsets.only(top: 22.0.h,left: 7.0.w,right: 5.0.w),
      child: Text(Constants.neoSoftTitle,
      style: TextStyle(
        color: AppColor.whiteText,
        fontSize: 40.0.sp,
        fontWeight: FontWeight.bold
      ),),
    );
  }

 Widget _usernameField() {
    return Container(
      width: 80.0.w,
      height: 10.0.h,
      margin: EdgeInsets.only(top: 6.0.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _username,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Username is required";
          }else if(!value.contains("@gmail.com")){
            return "Enter valid Mail";
          }
        },
        decoration:inputDecortaion("Username","assets/icons/username_icon.png"),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: 80.0.w,
      height: 10.0.h,
      margin: EdgeInsets.only(top: 2.0.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        obscureText: true,
        controller: _password,
        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return "Password is required";
          }else if(value.length < 7){
            return "Enter min 8 character";
          }
        },
        decoration: inputDecortaion("Password","assets/icons/password_icon.png"),
      ),
    );
  }

 Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          _validate();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 80.0.w,
        height: 7.0.h,
        margin: EdgeInsets.only(left:4.0.h,right: 3.0.h,top: 5.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            1.0.h
          ),
          color: AppColor.whiteText
        ),
        child: Text("Submit",
        style: TextStyle(
          color: AppColor.red,
          fontWeight: FontWeight.bold,
          fontSize: 15.0.sp
        ),),
      ),
    );
 }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/forgotpasswordScreen");
      },
      child: Container(
        margin: EdgeInsets.only(top: 2.0.h,left: 3.0.h,right: 3.0.h),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20.0.sp
          ),
        ),
      ),
    );
  }

 Widget _alreadyAccount() {
    return Container(
      margin: EdgeInsets.only(left: 4.0.h,right: 1.0.h),
      child: Text(
        "DONT HAVE AN ACCOUNT?",
        style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 14.0.sp
        ),
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

  void _validate() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(email: _username.text, password: _password.text));
    _formKey.currentState.reset();
  }

  Widget _indicator() {
    return Container(
      margin: EdgeInsets.only(left: 4.0.h,right: 3.0.h),
      child: LinearProgressIndicator(
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context,"/signUpScreen");
  }

  void _navigateToHomeScreen(String accessToken) {
    print("Navigating to HomeScreen: $accessToken" );
    Navigator.pushReplacementNamed(context, "/homeScreen",arguments: accessToken);
  }

  Widget _floatingActionButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _alreadyAccount(),
          FloatingActionButton(
            onPressed: (){
              _navigateToSignUp();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0.h),
            ),
            backgroundColor: AppColor.darkRed,
            child: Icon(Icons.add,color: AppColor.whiteText,),
          )
        ],
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
