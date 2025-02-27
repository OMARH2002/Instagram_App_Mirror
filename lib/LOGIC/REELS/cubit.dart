import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


import 'package:instagram_duplicate_app/DATA/REELS_MODEL.dart';
import 'package:instagram_duplicate_app/LOGIC/REELS/state.dart';

class ReelCubit extends Cubit<ReelState> {
  ReelCubit() : super(ReelInitial());

  Future<void> uploadReel(File videoFile, String userId, String caption) async {
    emit(ReelUploading());

    try {
      // Upload video to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('reels/${DateTime.now().millisecondsSinceEpoch}.mp4');
      await storageRef.putFile(videoFile);
      final videoUrl = await storageRef.getDownloadURL();

      // Save reel data to Firestore
      final reel = ReelModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        videoUrl: videoUrl,
        caption: caption,
        timestamp: DateTime.now(),
        likes: [],
      );

      await FirebaseFirestore.instance.collection('reels').doc(reel.id).set(reel.toMap());

      emit(ReelUploadSuccess());
      fetchReels(); // Fetch reels after successful upload
    } on FirebaseException catch (e) {
      emit(ReelUploadFailure('Firebase Error: ${e.message}'));
    } catch (e) {
      emit(ReelUploadFailure('Unexpected Error: $e'));
    }
  }

  void fetchReels() {
    emit(ReelsLoading());
    FirebaseFirestore.instance
        .collection('reels')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final reels = snapshot.docs.map((doc) => ReelModel.fromMap(doc.data())).toList();
      if (reels.isEmpty) {
        emit(ReelsEmpty());
      } else {
        emit(ReelsLoaded(reels));
      }
    }, onError: (error) {
      emit(ReelUploadFailure('Error fetching reels: $error'));
    });
  }
}