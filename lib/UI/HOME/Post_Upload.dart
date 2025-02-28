import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/cubit.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  XFile? _image;
  final _captionController = TextEditingController();

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _image = image);
  }

  void _uploadPost() {
    if (_image != null) {
      context.read<HomeCubit>().uploadPost(
         File(_image!.path),
        _captionController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _uploadPost,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _image != null
                ? Image.file(File(_image!.path), fit: BoxFit.cover)
                : Center(child: TextButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: 'Write a caption...',
                border: InputBorder.none,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}