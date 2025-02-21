import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Create_user_profile_MODEL.dart';
import 'package:instagram_duplicate_app/LOGIC/CREEATE_USER_PROFILE/state.dart';

class CreateuserprofileCubit extends Cubit<CreateuserprofileStates> {
  CreateuserprofileCubit() : super(CreateuserprofileInitialState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create or update user profile
  Future<void> createProfile(CreateUserProfileModel createUser) async {
    emit(CreateuserprofileLoadingState());
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;
        createUser.userID = uid;

        // Fetch existing user data from Firestore
        DocumentSnapshot existingDoc = await _firestore.collection("UserData").doc(uid).get();
        Map<String, dynamic>? existingData = existingDoc.data() as Map<String, dynamic>?;

        // Preserve existing avatar if available
        if (existingData != null && existingData.containsKey("avatar")) {
          createUser.avatar = existingData["avatar"];
        }

        // Save/update user profile in Firestore
        await _firestore.collection("UserData").doc(uid).set(createUser.toJson(), SetOptions(merge: true));

        emit(CreateuserprofileSuccesState());
      } else {
        emit(CreateuserprofileErrorState("User is not authenticated"));
      }
    } catch (e) {
      emit(CreateuserprofileErrorState(e.toString()));
    }
  }

  // Fetch user profile from Firestore
  Future<void> fetchUserProfile() async {
    try {
      String userId = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('UserData').doc(userId).get();

      if (userDoc.exists) {
        CreateUserProfileModel userProfile =
        CreateUserProfileModel.fromJson(userDoc.data() as Map<String, dynamic>);
        emit(CreateuserprofileLoadedState(userProfile));
      } else {
        emit(CreateuserprofileLoadedState(CreateUserProfileModel(
          userID: userId,
          name: '',
          username: '',
          website: '',
          bio: '',
          email: '',
          gender: '',
          phone: '',
          category: '',
        )));
      }
    } catch (e) {
      emit(CreateuserprofileErrorState(e.toString()));
    }
  }

  // Update avatar URL in Firestore
  Future<void> updateAvatar(String avatarUrl) async {
    try {
      String uid = _auth.currentUser!.uid;

      // Update only the 'avatar' field inside UserData collection
      await _firestore.collection("UserData").doc(uid).set(
        {'avatar': avatarUrl},
        SetOptions(merge: true), // Prevent overwriting other user data
      );

      emit(CreateuserprofileAvatarUpdatedState(avatarUrl));
    } catch (e) {
      emit(CreateuserprofileErrorState(e.toString()));
    }
  }
}
