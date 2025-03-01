import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileImages extends StatefulWidget {
  const UserProfileImages({super.key});

  @override
  State<UserProfileImages> createState() => _UserProfileImagesState();
}

class _UserProfileImagesState extends State<UserProfileImages> {
  List<String> _imageUrl = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserImages();
  }

  Future<void> _fetchUserImages() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      final imageUrl = snapshot.docs
          .map((doc) => doc['imageUrl'] as String)
          .toList();

      setState(() {
        _imageUrl = imageUrl;
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

    if (_imageUrl.isEmpty) {
      return const Center(child: Text('No images available'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 images per row
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _imageUrl.length,
      itemBuilder: (context, index) {
        return Image.network(
          _imageUrl[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}