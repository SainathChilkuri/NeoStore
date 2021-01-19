import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/AuthBloc/auth_event.dart';
import 'package:neostore/Blocs/AuthBloc/auth_state.dart';
import 'package:neostore/Model/UserModel/user.dart';
import 'package:neostore/Session/user_session.dart';

class AuthBloc extends Bloc<AuthEvents,AuthState>{
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async*{
   if(event is InitAuthProcess){
     print("Initial State");
       String accessToken = await UserSession().getSessionDetails();
       if(accessToken!=null){
         print("GOT ACCESSTOKEN");
         yield AuthenticatedState(acessToken: accessToken);
       }else{
         yield UnAuthenticatedState();
         print("No User Found");
       }
   }
  }

}