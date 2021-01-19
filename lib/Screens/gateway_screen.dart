import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/AuthBloc/auth_bloc.dart';
import 'package:neostore/Blocs/AuthBloc/auth_event.dart';
import 'package:neostore/Blocs/AuthBloc/auth_state.dart';
import 'package:neostore/Model/UserModel/user.dart';
class GatewayScreen extends StatefulWidget {
  @override
  _GatewayScreenState createState() => _GatewayScreenState();
}

class _GatewayScreenState extends State<GatewayScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(InitAuthProcess());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context,state){
        if(state is AuthInitialState){
          print("initial state");
        }
        if(state is AuthenticatedState){
          return _navigate(state.acessToken);
        }
        if(state is UnAuthenticatedState){
          return _navigatetoLogin();
         /* Navigator.pushReplacementNamed(context, "/loginScreen");*/
        }
      },
      child: Scaffold(
        body: Center(child: Container(
        ))
      ),
    );
  }

   _navigate(String accessToken) {
     Navigator.pushReplacementNamed(context, "/homeScreen", arguments: accessToken);
   }

   _navigatetoLogin() {
     Navigator.pushReplacementNamed(context, "/loginScreen");
   }
}
