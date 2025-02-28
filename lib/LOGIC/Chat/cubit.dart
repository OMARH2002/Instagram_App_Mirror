import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_duplicate_app/DATA/ChatModels/chat_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/state.dart';

class ChatCubit extends Cubit<ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatCubit() : super(ChatInitial());

  // Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    emit(ChatLoading());

    try {
      final String senderId = _auth.currentUser!.uid;
      final Timestamp timestamp = Timestamp.now();

      ChatModel chat = ChatModel(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp.toDate(),
      );

      // Generate a consistent chat document ID
      final String chatDocId = _getChatDocId(senderId, receiverId);

      // Debug log
      print('Sending message: $message from $senderId to $receiverId');
      print('Chat document ID: $chatDocId');

      await _firestore
          .collection('chats')
          .doc(chatDocId)
          .collection('messages')
          .add(chat.toMap());

      // Debug log
      print('Message sent successfully');

      emit(ChatMessageSent());
    } catch (e) {
      // Debug log
      print('Error sending message: $e');
      emit(ChatError(e.toString()));
    }
  }

  // Get Messages
  Stream<List<ChatModel>> getMessages(String receiverId) {
    final String senderId = _auth.currentUser!.uid;

    // Generate a consistent chat document ID
    final String chatDocId = _getChatDocId(senderId, receiverId);

    return _firestore
        .collection('chats')
        .doc(chatDocId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      // Debug log
      print('Retrieved ${snapshot.docs.length} messages');
      return snapshot.docs
          .map((doc) {
        // Debug log
        print('Message data: ${doc.data()}');
        return ChatModel.fromMap(doc.data());
      })
          .toList();
    });
  }

  // Helper method to generate consistent chat document ID
  String _getChatDocId(String senderId, String receiverId) {
    // Sort the IDs to ensure consistency
    final List<String> ids = [senderId, receiverId]..sort();
    return '${ids[0]}-${ids[1]}';
  }
}

