import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_duplicate_app/DATA/Comment_Model.dart';



class Post {
  final String id;
  final String userId;
  final String username;
  final String avatar;
  final String imageUrl;
  final String caption;
  final DateTime timestamp;
  final List<String> likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatar,
    required this.imageUrl,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  factory Post.fromFirestore(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      userId: data['userId'],
      username: data['username'],
      avatar: data['avatar'],
      imageUrl: data['imageUrl'],
      caption: data['caption'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      likes: List<String>.from(data['likes'] ?? []),
      comments: (data['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromMap(comment))
          .toList() ?? [],
    );
  }


}