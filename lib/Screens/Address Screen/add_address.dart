import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/AddressBloc/address_bloc.dart';
import 'package:neostore/Blocs/AddressBloc/address_events.dart';
import 'package:neostore/Blocs/AddressBloc/address_states.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Database/database.dart';
import 'package:neostore/Session/user_session.dart';
import 'package:neostore/main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _addressLineText = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipcode = TextEditingController();
  TextEditingController _country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<AddressTableDao>(context);
    return BlocListener<AddressBloc,AddressScreenState>(
      listener: (context,state){
        if(state is AddressInsertedState){
          _showSnackBar("Successfully Added the Address");
        }
        if(state is AddressFailedState){
          _showSnackBar("Failed to Insert");
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.lightGreyColor,
        appBar: _appBar("Add Address"),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0.w,vertical: 4.0.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldName("ADDRESS"),
                  _addressLine1(),
                  _fieldName("LANDMARK"),
                  _landMark(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: _fieldName("CITY")),
                      SizedBox(width: 3.0.w,),
                      Expanded(
                        flex: 1,
                          child: _fieldName("STATE"))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: _cityField()),
                      SizedBox(width: 3.0.w,),
                      Expanded(
                          flex: 1,
                          child: _stateField())
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: _fieldName("ZIPCODE")),
                      SizedBox(width: 3.0.w,),
                      Expanded(
                          flex: 1,
                          child: _fieldName("COUNTRY"))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: _zipCodeField()),
                      SizedBox(width: 3.0.w,),
                      Expanded(
                          flex: 1,
                          child: _countryField())
                    ],
                  ),
                  _submitButton(dao)



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _appBar(String s) {
    return AppBar(
      title: Text(
        s,
        style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 20.0.sp
        ),
      ),
      centerTitle: true,
    );

  }

  _fieldName(String name) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.0.h),
      child: Text(name,
      style: _style(),),
    );
  }

  TextStyle _style() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0.sp,
      color: AppColor.black
    );
  }

  _addressLine1() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        controller: _addressLineText,
          // ignore: missing_return
          validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
          },
          minLines: 3,
          maxLines: 5,
          decoration: _inputDecoration(),
      ),
    );
  }
  InputDecoration _inputDecoration(){
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.whiteText
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.whiteText
            )
        ),
        fillColor: AppColor.whiteText,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.whiteText
            )
        )
    );
  }

  _landMark() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        controller: _landmark,
        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
        },
        decoration: _inputDecoration(),
      ),
    );
  }

  _cityField() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        controller: _city,
        validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
        },
        decoration: _inputDecoration(),
      ),
    );
  }

  _stateField() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        controller: _state,
        validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
        },
        decoration: _inputDecoration(),
      ),
    );
  }
  _zipCodeField() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _zipcode,
        validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
        },
        decoration: _inputDecoration(),
      ),
    );
  }
  _countryField() {
    return  Container(
      margin: EdgeInsets.only(bottom: 2.0.h),
      child: TextFormField(
        controller: _country,
        validator: (value){
          if(value.isEmpty){
            return "*Required";
          }
        },
        decoration: _inputDecoration(),
      ),
    );
  }

  _submitButton(AddressTableDao dao) {
    return GestureDetector(
      onTap: () async {
        if(_formKey.currentState.validate()) {
          var accessToken = await UserSession().getSessionDetails();
          print("Address Token; $accessToken");
          var addressTableEvent = AddressTableData(
              accessToken: accessToken,
              addressLine: _addressLineText.text,
              city: _city.text,
              state: _state.text,
              zipcode: int.parse(_zipcode.text),
              country: _country.text,
              landmark: _landmark.text);
          BlocProvider.of<AddressBloc>(context).add(AddressInsertEvent(addressTableData: addressTableEvent,addressTableDao: dao));
        }
      },
      child: Container(
        height: 8.0.h,
        margin: EdgeInsets.only(top: 1.0.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.w),
          color: AppColor.primaryColor
        ),
        child: Text(
          "SAVE ADDRESS",
          style: TextStyle(
            color: AppColor.whiteText,
            fontWeight: FontWeight.bold,
            fontSize: 15.0.sp
          ),
        ),
      ),
    );
  }

   _showSnackBar(String msg) {
    _formKey.currentState.reset();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));

   }
}

