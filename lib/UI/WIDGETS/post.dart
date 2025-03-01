import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/DATA/Post_Model.dart';


class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(post.avatar),
          ),
          title: Text(post.username),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.network(post.imageUrl, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(post.caption),
              const SizedBox(height: 8),
              const Text('2 hours ago', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}