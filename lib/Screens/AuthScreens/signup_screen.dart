import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/SignUpBloc/signup_bloc.dart';
import 'package:neostore/Blocs/SignUpBloc/signup_events.dart';
import 'package:neostore/Blocs/SignUpBloc/signup_states.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Constants/constants.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:sizer/sizer.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var termsNcondition = false;
  var _genderValue ="M";
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc,SignUpStates>(
      listener: (context,state){
        if(state is SignUpSuccessState){
          showDialog(
            barrierDismissible: false,
              context: context,
               builder: (context){
                return AlertDialog(
                  content: Text(
                    state.msg
                  ),
                  actions: [
                    FlatButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, "/loginScreen");
                        },
                        child: Text("Login"))
                  ],
                );
               });
        }
        if(state is SignUpFailedState){
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text(
                      state.msg
                  ),
                  actions: [
                    FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Dismiss"))
                  ],
                );
              });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar("Register"),
       body: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Stack(
           children: [
             _backgroundImage(),
             Container(
               child: Form(
                 key: _formKey,
                 child: Column(
                   children: [
                     _neoSoftTitleName(),
                     _usernameField(),
                     _lastnameField(),
                     _emailField(),
                     _passwordField(),
                     _confirmPasswordField(),
                     _genderUser(),
                     _phoneNumberField(),
                     _termsNcondition(),
                     _submitButton()
                   ],
                 ),
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
      margin: EdgeInsets.only(top: 10.0.h,left: 10.0.w,right: 5.0.w),
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
      height: 7.0.h,
      margin: EdgeInsets.only(top: 4.0.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        controller: _firstname,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Firstname is required";
          }
        },
        decoration:inputDecortaion("Firstname","assets/icons/username_icon.png"),
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

  Widget _lastnameField() {
    return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        controller: _lastname,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Lastname is required";
          }
        },
        decoration:inputDecortaion("Lastname","assets/icons/username_icon.png"),
      ),
    );
  }

 Widget _emailField() {
   return Container(
     width: 80.0.w,
     height: 7.0.h,
     margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
     child: TextFormField(
       keyboardType: TextInputType.emailAddress,
       controller: _email,
       // ignore: missing_return
       validator: (String value){
         if(value.isEmpty){
           return "Lastname is required";
         }
         if(!value.contains("@gmail.com")){
           return "Enter Valid Gmail";
         }
       },
       decoration:inputDecortaion("Email","assets/icons/email_icon.png"),
     ),
   );
 }

  Widget _passwordField() {
    return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        controller: _password,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Password is required";
          }
        },
        decoration:inputDecortaion("Password","assets/icons/password_icon.png"),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        controller: _confirmPassword,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Confirm your Password";
          }
          if(_password.text != value){
            return "Password not Matched";
          }
        },
        decoration:inputDecortaion("Confirm Password","assets/icons/password_icon.png"),
      ),
    );
  }

  Widget _genderUser() {
    return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: Row(
        children: [
          Text("Gender",
          style:  TextStyle(
              color: AppColor.whiteText,
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp
          ),),
         SizedBox(width: 1.0.h),
         Row(
           children: [
             Radio(
             activeColor: AppColor.whiteText,
               value: "M",
               groupValue: _genderValue,
               onChanged: (value){
                 setState(() {
                   _genderValue=value;
                 });
               },
             ),
             Text("Male",
               style:  TextStyle(
                   color: AppColor.whiteText,
                   fontWeight: FontWeight.bold,
                   fontSize: 16.0.sp
               ),),
             Radio(
               activeColor: AppColor.whiteText,
               value: "F",
               groupValue: _genderValue,
               onChanged: (value){
                 setState(() {
                   _genderValue=value;
                 });
               },
             ),
             Text("Female",
               style:  TextStyle(
                   color: AppColor.whiteText,
                   fontWeight: FontWeight.bold,
                   fontSize: 16.0.sp
               ),),
           ],
         )
        ],
      ),
    );
  }

  Widget _phoneNumberField() {
    return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: TextFormField(
        controller: _phoneNumber,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return "Phone Number Required";
          }
        },
        decoration:inputDecortaion("Phone Number","assets/icons/cellphone.png"),
      ),
    );
  }

 Widget _termsNcondition() {
  return Container(
      width: 80.0.w,
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.5.h,left: 4.0.h,right: 3.0.h),
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColor.whiteText,
              value: termsNcondition,
              onChanged: (bool value){
                setState(() {
                  termsNcondition = value;
                  print(termsNcondition);
                  print(_genderValue);
                });
              }),
          SizedBox(width: 1.0.h),
          Text("I agree Terms & Conditions",
            style:  TextStyle(
                color: AppColor.whiteText,
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp
            ),)
        ],
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
        child: Text("REGISTER",
          style: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.bold,
              fontSize: 15.0.sp
          ),),
      ),
    );
  }

  void _validate() {
    if(!termsNcondition){
     showDialog(context: context,
     builder: (context){
       return AlertDialog(
         content: Text("Please Agree to terms & Condition"),
       );
     });
    }else{
      if(_formKey.currentState.validate() && termsNcondition){
        print("Submit");
       BlocProvider.of<SignUpBloc>(context).add(SignUpButtonPressed(firstname: _firstname.text,
           lastname: _lastname.text,
           email: _email.text,
           gender: _genderValue,
           password:_password.text,
           con_password: _confirmPassword.text,
           number: _phoneNumber.text));
        _formKey.currentState.reset();

      }
    }

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
      //backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

}
