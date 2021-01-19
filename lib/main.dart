import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/ForgotPasswordBloc/forgot_bloc.dart';
import 'package:neostore/Blocs/HomeScreenBloc/home_bloc.dart';
import 'package:neostore/Blocs/LoginBloc/login_bloc.dart';
import 'package:neostore/Blocs/Orders/OrderListBloc/orderlist_bloc.dart';
import 'package:neostore/Blocs/ProductDetailsBloc/details_bloc.dart';
import 'package:neostore/Blocs/UserDetailUpdateBloc/update_bloc.dart';
import 'package:neostore/Colors/color.dart';
import 'package:neostore/Database/database.dart';
import 'package:neostore/Routes/routes.dart';
import 'package:neostore/Screens/my_account_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Blocs/AddressBloc/address_bloc.dart';
import 'Blocs/AuthBloc/auth_bloc.dart';
import 'Blocs/CartBloc/cart_bloc.dart';
import 'Blocs/Orders/OrderDetails/orderdetails_bloc.dart';
import 'Blocs/ProductLoadBloc/product_bloc.dart';
import 'Blocs/SignUpBloc/signup_bloc.dart';

void main(){
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => HomeBloc(UpdateBloc())),
        BlocProvider(
            create: (_) => ForgotBloc()),
        BlocProvider(
            create: (_) => LoginBloc()),
        BlocProvider(
            create: (_) => SignUpBloc()),
        BlocProvider(
            create: (_) => AuthBloc()),
        BlocProvider(
            create: (_) => UpdateBloc()),
        BlocProvider(
            create: (_) =>ProductBloc()),
        BlocProvider(
            create: (_) =>DetailsBloc()),
        BlocProvider(
            create: (_) =>OrderListBloc()),
        BlocProvider(
            create: (_) =>OrderDetailsBloc()),
        BlocProvider(
            create: (_) =>CartBloc()),
        BlocProvider(
            create: (_) =>AddressBloc()),

      ],
      child: Provider<AddressTableDao>(
         create: (_)=>NeoStoreDB().addressTableDao,
          child: App())));
}
class App extends StatelessWidget {
  ThemeData base = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return OrientationBuilder(
          builder: (context,orientation){
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: _appTheme(base),
              initialRoute: RoutingConstants.gatewayScreen,
              onGenerateRoute: RouterPage.ongenerateRoute,
            );
          },

        );
      },

    );
  }

 ThemeData _appTheme(ThemeData base) {
    return base.copyWith(
      primaryColor: AppColor.primaryColor,
      canvasColor: AppColor.drawerBGColor
    );
 }
}
