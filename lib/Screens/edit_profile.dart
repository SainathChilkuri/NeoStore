import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_events.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_bloc.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_events.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_states.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
class EditProfileScreen extends StatefulWidget {
  final UserData userData;
  EditProfileScreen({
    this.userData
  });
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  var mentionedDate;
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool profilePicUpdated = false;
  UserData user;
  File imgfile;
  String profile;
  String currProfile;
 TextEditingController firstname,lastname,email,phoneNo,dob;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

     user = widget.userData;
    mentionedDate = user.dob;
     currProfile = user.profilePic;
     firstname = TextEditingController(text: user.firstName);
     lastname = TextEditingController(text: user.lastName);
     email = TextEditingController(text: user.email);
     phoneNo = TextEditingController(text: user.phoneNo);
     /*dob = TextEditingController(text: user.dob??"Not mentioned");*/

 }
  @override
  Widget build(BuildContext context) {

    return BlocListener<UpdateBloc,UpdateStates>(
      listener: (context,state){
        if(state is UpdateSuccesfully){
          BlocProvider.of<HomeBloc>(context).add(AccountUpdateEvent());
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Data Updated Succesfully")));
        }
        if(state is UpdateFailed){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Data Update Failed")));
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
            appBar: _appBar("Edit Profile"),
            body: Wrap(
                children: [
                  Stack(
                      children: [
                         _backgroundImage(),
                           Container(
                              margin: EdgeInsets.only(top:6.0.h),
                              child: Form(
                                key: _formKey,
                                child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       _userImage(user.profilePic),
                                      _usernameField(),
                                      _lastnameField(),
                                      _emailField(),
                                      _numberField(),
                                      _dobField(),
                                      _submitButton(),
                                      _loading()
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
 Widget _userImage(String profilePic) {
    return GestureDetector(
      onTap:(){
        openDialog();
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 3.0.h),
          child: !profilePicUpdated?
              Container(
                child: profilePic == null?
                CircleAvatar(
                    radius: 20.0.w,
                    child:
                    Text(firstname.text[0].toUpperCase())
                ):
                RotatedBox(
                  quarterTurns: -1,
                  child: CircleAvatar(
                    radius: 20.0.w,
                    backgroundImage: NetworkImage(
                        profilePic
                    ),
                  ),
                ),
              ): RotatedBox(
                quarterTurns: -1,
                child: CircleAvatar(
                  radius: 20.0.w,
                     backgroundImage: Image.file(
                     imgfile
                    ).image,
          ),
              )

          ),
    );
  }
  Widget _usernameField() {
    return Container(
      height: 7.0.h,
      margin: EdgeInsets.only(top: 1.0.h,left: 3.0.w,right: 3.0.w),
      child: TextFormField(
        controller: firstname,
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
     height: 7.0.h,
     margin: EdgeInsets.only(top: 1.0.h,left: 3.0.w,right: 3.0.w),
     child: TextFormField(
       controller: lastname,
       // ignore: missing_return
       validator: (String value){
         if(value.isEmpty){
           return "LastName is required";
         }
       },
       decoration:inputDecortaion("Lastname","assets/icons/username_icon.png"),
     ),
   );
 }

 Widget _emailField() {
   return Container(
     height: 7.0.h,
     margin: EdgeInsets.only(top: 1.0.h,left: 3.0.w,right: 3.0.w),
     child: TextFormField(
       controller:email,
       // ignore: missing_return
       validator: (String value){
         if(value.isEmpty){
           return "Email is required";
         }
       },
       decoration:inputDecortaion("Email","assets/icons/email_icon.png"),
     ),
   );
 }

 Widget _numberField() {
   return Container(
     height: 7.0.h,
     margin: EdgeInsets.only(top: 1.0.h,left: 3.0.w,right: 3.0.w),
     child: TextFormField(
       controller:phoneNo,
       // ignore: missing_return
       validator: (String value){
         if(value.isEmpty){
           return "Number is required";
         }
       },
       decoration:inputDecortaion("Phone Number","assets/icons/cellphone.png"),
     ),
   );
 }

  Widget _dobField() {
    return GestureDetector(
      onTap: ()async {
        var date = await _showDatePicker();
        if (date != null && date != _selectedDate) {
          setState(() {
            print(mentionedDate);
            var formattedDate = "${date.day}-${date.month}-${date.year}";
            mentionedDate = formattedDate;
            print(mentionedDate);

          });
        }
      },
      child: Container(
        height: 7.0.h,
          margin: EdgeInsets.only(top: 1.0.h,left: 3.0.w,right: 3.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0.w),
                border: Border.all(color: AppColor.whiteText)
            ),
            child: Row(
              children: [
                Container(
                  height: 9.0.h,
                  width: 9.0.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/dob_icon.png")
                      )
                  ),),
                SizedBox(width: 3.0.w),
                mentionedDate!=null?Text(mentionedDate,style:
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
        )
    );
  }
  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        _validate();
      },
      child: Container(
        alignment: Alignment.center,
        height: 7.0.h,
        margin: EdgeInsets.only(top: 2.0.h,left: 3.0.w,right: 3.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                1.0.h
            ),
            color: AppColor.whiteText
        ),
        child: Text("SUBMIT",
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
      BlocProvider.of<UpdateBloc>(context).add(AccountDetailUpdateEvent(
        accessToken: user.accessToken,
        firstName: firstname.text,
        lastName:lastname.text,
        email: email.text,
        phoneNo: phoneNo.text,
        dob: mentionedDate,
        profilePic: profile??""
      ));
   }
  }

  void openDialog() {
    showDialog(
        context: context,
    builder: (context){
          return AlertDialog(
            title: Text("Open With"),
            content: Container(
              height: 17.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                       IconButton(
                        iconSize: 20.0.w,
                        icon: Icon(Icons.camera_alt),
                        onPressed: ()async{
                               print("Opening Camera");
                             checkCameraPermission();
                         }),
                      Text("Camera"),
                    ],
                  ),
              SizedBox(width: 3.0.w,),
                  Column(
                    children: [
                      IconButton(
                        color: Colors.blueAccent,
                          iconSize: 20.0.w,
                          icon: Icon(Icons.photo),
                          onPressed: ()async{
                            print("Opening gallery");
                            checkGalleryPermission();
                            //PickedFile imagefile = await ImagePicker().getImage(source: ImageSource.gallery);
                          }),
                      Text("Gallery"),
                    ],
                  )

                ],
              ),
            ),
          );
    });
  }

  void checkCameraPermission() async {
   var status = await Permission.camera.status;
    if(status.isGranted){
      print("Granted");
      pickImage("camera");
    }else{
      if(await Permission.camera.request().isGranted){
        print("Granting");
        pickImage("camera");
      }else{
        print("Not Granted");
      }

    }
  }

  void pickImage(String source) async{
   if(source == "camera"){
     PickedFile imagefile = await ImagePicker().getImage(source: ImageSource.camera);
      File file = File(imagefile.path);
      if(file!=null){
        setState(() {
          imgfile = file;
          profilePicUpdated =true;
          profile = "data:image/jpg;base64,${base64Encode(file.readAsBytesSync())}";
          print(profile);
        });
        Navigator.of(context).pop();
      }
   }else{
     PickedFile imagefile = await ImagePicker().getImage(source: ImageSource.gallery);
     print(imagefile);
     File file = File(imagefile.path);
     if(file!=null){
       profilePicUpdated =true;
       imgfile = file;
       //print(base64Encode(file.readAsBytesSync()));
       setState(() {
         profile = "data:image/jpg;base64,${base64Encode(file.readAsBytesSync())}";
         print(profile);
       });
       Navigator.of(context).pop();
     }
   }

  }

  void checkGalleryPermission() async{
    var status = await Permission.mediaLibrary.status;
    if(status.isGranted){
      print("Granted");
      pickImage("gallery");
    }else{
      if(await Permission.camera.request().isGranted){
        print("Granting");
        pickImage("gallery");
      }else{
        print("Not Granted");
      }

    }
  }

 Widget _loading() {
   return BlocBuilder<UpdateBloc,UpdateStates>(
     // ignore: missing_return
     builder: (context,state){
        if(state is InitialData){
          return Container();
        }

        if(state is UpdateSuccesfully){
          return Container();
        }

        if(state is UpdateFailed){
          return Container();
        }

        if(state is UpdateLoading){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 1.0.h),
            child: LinearProgressIndicator(),
          );
        }
     },
   );
 }

  Future<DateTime> _showDatePicker()async {
   return await showDatePicker(
     context: context,
     initialDate: _selectedDate,
     firstDate: DateTime(1950),
     lastDate: DateTime(2050),
     initialEntryMode: DatePickerEntryMode.input,
     initialDatePickerMode: DatePickerMode.year,
     helpText: "Select Birth Date",
     cancelText: "Dismiss",
     confirmText: "Select",
     errorFormatText: 'Enter valid date',
     errorInvalidText: 'Enter date in valid range',
   );
   }
}
