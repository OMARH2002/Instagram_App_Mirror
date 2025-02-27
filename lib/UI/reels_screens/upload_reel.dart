import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:instagram_duplicate_app/LOGIC/REELS/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/REELS/state.dart';

class UploadReelScreen extends StatefulWidget {
  final String userId;

  const UploadReelScreen({super.key, required this.userId});

  @override
  _UploadReelScreenState createState() => _UploadReelScreenState();
}

class _UploadReelScreenState extends State<UploadReelScreen> {
  File? _selectedVideo;
  final TextEditingController _captionController = TextEditingController();

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedVideo = File(pickedFile.path));
    }
  }

  void _uploadReel() {
    if (_selectedVideo != null) {
      context.read<ReelCubit>().uploadReel(
        _selectedVideo!,
        widget.userId,
        _captionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Reel')),
      body: BlocConsumer<ReelCubit, ReelState>(
        listener: (context, state) {
          if (state is ReelUploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reel uploaded successfully!')),
            );
            Navigator.pop(context);
          } else if (state is ReelUploadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedVideo != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: const Icon(Icons.video_library, size: 50),
                  ),
                const SizedBox(height: 16),
                TextField(
                  controller: _captionController,
                  decoration: InputDecoration(
                    labelText: 'Caption',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (state is ReelUploading)
                  const Center(child: CircularProgressIndicator()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickVideo,
                      icon: const Icon(Icons.video_library),
                      label: const Text('Pick Video'),
                    ),
                    ElevatedButton.icon(
                      onPressed: state is ReelUploading ? null : _uploadReel,
                      icon: const Icon(Icons.upload),
                      label: const Text('Upload'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}