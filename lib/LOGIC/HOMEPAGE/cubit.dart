import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/Post_Model.dart';
import 'package:instagram_duplicate_app/DATA/story_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/state.dart';


class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? _postsSubscription;
  StreamSubscription? _storiesSubscription;

  HomeCubit() : super(HomeInitial()) {
    _init();
  }

  void _init() async {
    emit(HomeLoading());

    _postsSubscription = _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((postsSnapshot) {
      final posts = postsSnapshot.docs
          .map((doc) => Post.fromFirestore(doc.data(), doc.id))
          .toList();

      _storiesSubscription = _firestore
          .collection('stories')
          .where('timestamp', isGreaterThan: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 24))))
          .snapshots()
          .listen((storiesSnapshot) {
        final stories = storiesSnapshot.docs
            .map((doc) => Story.fromFirestore(doc.data(), doc.id))
            .toList();

        emit(HomeLoaded(posts, stories));
      });
    });
  }

  Future<void> uploadPost(File image, String caption) async {
    try {
      final storageRef = _storage.ref().child('posts/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(image);
      final imageUrl = await storageRef.getDownloadURL();

      final user = _auth.currentUser!;
      final userDoc = await _firestore.collection('UserData').doc(user.uid).get();

      await _firestore.collection('posts').add({
        'userId': user.uid,
        'username': userDoc['username'],
        'avatar': userDoc['avatar'],
        'imageUrl': imageUrl,
        'caption': caption,
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
        'comments': [],
      });
    } catch (e) {
      emit(HomeError('Post upload failed: $e'));
    }
  }

  Future<void> uploadStory(File image) async {
    try {
      final storageRef = _storage.ref().child('stories/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(image);
      final imageUrl = await storageRef.getDownloadURL();

      final user = _auth.currentUser!;
      final userDoc = await _firestore.collection('UserData').doc(user.uid).get();

      await _firestore.collection('stories').add({
        'userId': user.uid,
        'username': userDoc['username'],
        'avatar': userDoc['avatar'],
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      emit(HomeError('Story upload failed: $e'));
    }
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    _storiesSubscription?.cancel();
    return super.close();
  }
}