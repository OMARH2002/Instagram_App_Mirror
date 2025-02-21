import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';

class UserPageCubit extends Cubit<UserPageStates>{
  UserPageCubit():super(UserPageInitialState());

  Future fetchUserProfile() async {
    emit(UserPageLoadingState());

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid; // ✅ Get current user ID


      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("UserData")
          .doc(uid)
          .get();

      if (userDoc.exists) {
        String name = userDoc['name']; // ✅ Extract  name
        String username = userDoc['username']; // ✅ Extract username
        String bio = userDoc['bio']; // ✅ Extract bio
        String category = userDoc['category']; // ✅ Extract category
        String website = userDoc['website']; // ✅ Extract website

        emit(UserPageSuccessState(
          name: name,
          username: username,
          website: website,
          bio: bio,
          category: category,
        )); // ✅ Emit user name state
      } else {

        emit(UserPageErrorState("User not found"));
      }
    } catch (e) {
      emit(UserPageErrorState(e.toString()));
    }

  }
}