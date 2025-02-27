import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:instagram_duplicate_app/LOGIC/REELS/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/REELS/state.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/videoplayer.dart';
import 'package:instagram_duplicate_app/UI/reels_screens/upload_reel.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<ReelCubit>().fetchReels();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels'),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: BlocBuilder<ReelCubit, ReelState>(
        builder: (context, state) {
          if (state is ReelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReelsLoaded) {
            final reels = state.reels;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: reels.length,
              itemBuilder: (context, index) {
                return VideoPlayerWidget(videoUrl: reels[index].videoUrl);
              },
            );
          } else if (state is ReelsEmpty) {
            return const Center(child: Text('No reels available.'));
          } else if (state is ReelUploadFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadReelScreen(userId: userId),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please log in first')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

