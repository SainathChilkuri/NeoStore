import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/Blocs/AddressBloc/address_events.dart';
import 'package:neostore/Blocs/AddressBloc/address_states.dart';
import 'package:neostore/Database/database.dart';
import 'package:neostore/Session/user_session.dart';
import 'package:provider/provider.dart';

class AddressBloc extends Bloc<AddressEvents,AddressScreenState>{
  AddressBloc() : super(AddressInitialState());

  @override
  Stream<AddressScreenState> mapEventToState(AddressEvents event) async* {
   if(event is AddressFetchEvent){
     var accessToken = await UserSession().getSessionDetails();
     print("ADDRESS SCREEN : AccessToken:$accessToken");
     try{
       List<AddressTableData> addressTableData = await event.addressTableDao.getAllTasks(accessToken);
       print("Address Details Fetched");
       print(addressTableData);
       if(addressTableData.isNotEmpty){
         yield AddressLoadState(addressTableData: addressTableData);
       }else{
         yield AddressEmptyState();
       }
     }catch(e){
       yield AddressFailedState();
     }
   }
   if(event is AddressInsertEvent){
     try{
       print("Hello");
       var result = await event.addressTableDao.insertAddress(event.addressTableData);
       print(result);
       if(result!=0){
        yield AddressInsertedState();
       }else{
         print("Not Inserted");
         yield AddressFailedState();
       }
     }catch(e){
       print("////Error Occured");
       yield AddressFailedState();
     }
   }
   if(event is AddressDeleteEvent){
     try{
       var result = await NeoStoreDB().addressTableDao.deleteAddress(event.addressTableData);
       print(result);
       if(result!=0){
        yield AddressDeletedState();
       }else{
         yield AddressFailedState();
       }
     }catch(e){
       yield AddressFailedState();
     }
   }
  }
}