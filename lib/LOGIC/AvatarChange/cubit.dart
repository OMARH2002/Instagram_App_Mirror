import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_duplicate_app/LOGIC/AvatarChange/state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit() : super(AvatarInitial());

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);
        emit(AvatarPicked(file));
        await uploadImage(file);
      }
    } catch (e) {
      emit(AvatarError("Error picking image: ${e.toString()}"));
    }
  }

  // Upload image to Firebase Storage & store the URL in Firestore
  Future<void> uploadImage(File file) async {
    try {
      emit(AvatarUploading());

      String uid = _auth.currentUser!.uid;
      String filePath = 'avatars/$uid.jpg';
      Reference ref = _storage.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the new avatar
      await _firestore.collection('UserData').doc(uid).set(
        {'avatar': imageUrl},
        SetOptions(merge: true), // Preserve other user data
      );

      emit(AvatarUploaded(imageUrl));

      // Ensure UI updates correctly by reloading avatar
      await loadAvatar();
    } catch (e) {
      emit(AvatarError("Error uploading image: ${e.toString()}"));
    }
  }

  // Load the existing avatar from Firestore
  Future<void> loadAvatar() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('UserData').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        if (userData.containsKey('avatar') && userData['avatar'] != null) {
          emit(AvatarUploaded(userData['avatar']));
        } else {
          emit(AvatarInitial()); // No avatar found
        }
      } else {
        emit(AvatarInitial()); // No user document found
      }
    } catch (e) {
      emit(AvatarError("Error loading avatar: ${e.toString()}"));
    }
  }
}
