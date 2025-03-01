import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/videoplayer.dart';

class UserProfileVideo extends StatefulWidget {
  const UserProfileVideo({super.key});

  @override
  State<UserProfileVideo> createState() => _UserProfileVideoState();
}

class _UserProfileVideoState extends State<UserProfileVideo> {
  List<String> _videoUrl = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserVideo();
  }

  Future<void> _fetchUserVideo() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('reels')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      final videoUrl = snapshot.docs
          .map((doc) => doc['videoUrl'] as String)
          .toList();

      setState(() {
        _videoUrl = videoUrl;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_videoUrl.isEmpty) {
      return const Center(child: Text('No videos available'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // 3 images per row
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _videoUrl.length,
      itemBuilder: (context, index) {
        return VideoPlayerWidget(videoUrl:  _videoUrl[index],
        );
      },
    );
  }
}