import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Create_user_profile_MODEL.dart';
import 'package:instagram_duplicate_app/LOGIC/CREEATE_USER_PROFILE/state.dart';

class CreateuserprofileCubit extends Cubit<CreateuserprofileStates> {
  CreateuserprofileCubit() : super(CreateuserprofileInitialState());

  Future<void> createProfile(CreateUserProfileModel createUser) async {
    emit(CreateuserprofileLoadingState());
    try {
      // Get the currently authenticated user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid; // Get the user's UID

        // Add the UID to the user profile model before storing in Firestore
        createUser.userID = uid;

        // Save to Firestore using UID as the document ID
        await FirebaseFirestore.instance.collection("UserData").doc(uid).set(createUser.toJson());

        emit(CreateuserprofileSuccesState());
      } else {
        emit(CreateuserprofileErrorState("User is not authenticated"));
      }
    } catch (e) {
      emit(CreateuserprofileErrorState(e.toString()));
    }
  }
}