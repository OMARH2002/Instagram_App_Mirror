import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String userId;
  final String username;
  final String avatar;
  final String imageUrl;
  final DateTime timestamp;

  Story({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatar,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Story.fromFirestore(Map<String, dynamic> data, String id) {
    return Story(
      id: id,
      userId: data['userId'],
      username: data['username'],
      avatar: data['avatar'],
      imageUrl: data['imageUrl'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}