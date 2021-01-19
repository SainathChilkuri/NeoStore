import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_bloc.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_event.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_state.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Constants/constants.dart';
import 'package:sizer/sizer.dart';
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotBloc,ForgotState>(
      listener: (context,state){
        if(state is ForgotSuccessfullState){
          showDialog(
              context: context,
          builder: (context){
                return _showDialog(state.successResponse);
          });
        }
        if(state is ForgotFailedState){
          _showSnackBar(state.errorResponse);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar("Forgot Password"),
        body: Wrap(
          children: [
            Stack(
              children: [
                _backgroundImage(),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _neoSoftTitleName(),
                        _usernameField(),
                        _submitButton(),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ],
        ),
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
        controller: _email,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Email is required";
          }else if(!value.contains("@gmail.com")){
            return "Enter valid Mail";
          }
        },
        decoration:inputDecortaion("Email","assets/icons/email_icon.png"),
      ),
    );
  }
  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        _validate();
      },
      child: Container(
        alignment: Alignment.center,
        width: 80.0.w,
        height: 7.0.h,
        margin: EdgeInsets.only(left:4.0.h,right: 3.0.h,top: 1.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                1.0.h
            ),
            color: AppColor.whiteText
        ),
        child: Text("Forgot Password",
          style: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.bold,
              fontSize: 15.0.sp
          ),),
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
    if( _formKey.currentState.validate()){
      BlocProvider.of<ForgotBloc>(context).add(ForgotPassword(email: _email.text));
      _formKey.currentState.reset();
    }

  }

  void _showSnackBar(String errorMsg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(errorMsg),));
  }

  Widget _showDialog(String successResponse) {
    return AlertDialog(
      content: Text(successResponse),
      actions: [
        FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, "/loginScreen");
            },
            child: Text("Login",
            style: TextStyle(
              color: AppColor.primaryColor,
              decoration: TextDecoration.underline
            ),))
      ],
    );
  }
}
