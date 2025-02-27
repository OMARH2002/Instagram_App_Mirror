import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_duplicate_app/DATA/shopping_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/SHOPPING/state.dart';


class ShoppingCubit extends Cubit<ShoppingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ShoppingCubit() : super(ShoppingInitial()) {
    loadItems();
  }

  Future<void> loadItems() async {
    emit(ShoppingLoading());
    try {
      _firestore
          .collection('items')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        final items = snapshot.docs
            .map((doc) => ShoppingItem.fromFirestore(doc.data(), doc.id))
            .toList();
        emit(ShoppingLoaded(items));
      });
    } catch (e) {
      emit(ShoppingError('Failed to load items: $e'));
    }
  }

  Future<void> addItem({
    required XFile image,
    required String title,
    required String description,
    required double price,
    required String location,
  }) async {
    emit(UploadingItem());
    try {
      // Upload image
      final storageRef = _storage.ref().child('items/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await storageRef.putFile(File(image.path));
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Create item
      final docRef = _firestore.collection('items').doc();
      await docRef.set({
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'userId': _auth.currentUser!.uid,
        'location': location,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(ItemUploaded());
    } catch (e) {
      emit(ShoppingError('Failed to upload item: $e'));
    }
  }

  Future<void> deleteItem(String itemId, String imageUrl) async {
    try {
      // Delete from Firestore
      await _firestore.collection('items').doc(itemId).delete();

      // Delete image from Storage
      await _storage.refFromURL(imageUrl).delete();

      loadItems();
    } catch (e) {
      emit(ShoppingError('Failed to delete item: $e'));
    }
  }
}