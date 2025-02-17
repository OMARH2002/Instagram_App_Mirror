import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Create_user_profile_MODEL.dart';
import 'package:instagram_duplicate_app/LOGIC/CREEATE_USER_PROFILE/state.dart';

class CreateuserprofileCubit extends Cubit<CreateuserprofileStates> {
  CreateuserprofileCubit():super (CreateuserprofileInitialState());


  Future createProfile (CreateUserProfile createUser)async{
    emit(CreateuserprofileLoadingState());
    try{
      await FirebaseFirestore.instance.collection("User Data ").add(createUser.toJson());
    }
        catch(e){
      emit(CreateuserprofileErrorState(e.toString()));
        }
  }

}