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

  // Pick an image
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(AvatarPicked(File(image.path)));
      uploadImage(File(image.path));
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

      await _firestore.collection('users').doc(uid).set({'avatar': imageUrl}, SetOptions(merge: true));

      emit(AvatarUploaded(imageUrl));
    } catch (e) {
      emit(AvatarError(e.toString()));
    }
  }

  // Load the existing avatar
  Future<void> loadAvatar() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists && userDoc['avatar'] != null) {
        emit(AvatarUploaded(userDoc['avatar']));
      } else {
        emit(AvatarInitial());
      }
    } catch (e) {
      emit(AvatarError(e.toString()));
    }
  }
}