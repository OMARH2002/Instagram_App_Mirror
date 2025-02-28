import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final String userId1;
  final String userId2;
  final String username; // Added username
  final DateTime lastMessageTime;
  final String lastMessage;

  Chat({
    required this.id,
    required this.userId1,
    required this.userId2,
    required this.username,
    required this.lastMessageTime,
    required this.lastMessage,
  });

  factory Chat.fromFirestore(Map<String, dynamic> data, String id) {
    return Chat(
      id: id,
      userId1: data['userId1'],
      userId2: data['userId2'],
      username: data['username'],
      lastMessageTime: (data['lastMessageTime'] as Timestamp).toDate(),
      lastMessage: data['lastMessage'],
    );
  }
}