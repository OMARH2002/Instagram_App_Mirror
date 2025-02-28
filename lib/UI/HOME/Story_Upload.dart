import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/cubit.dart';


class StoryUploadScreen extends StatelessWidget {
  const StoryUploadScreen({super.key});

  Future<void> _uploadStory(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<HomeCubit>().uploadStory(File(image.path));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Story'),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.add_a_photo, size: 50),
          onPressed: () => _uploadStory(context),
        ),
      ),
    );
  }
}