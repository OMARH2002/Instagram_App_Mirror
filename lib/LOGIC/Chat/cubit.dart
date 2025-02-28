import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/ChatModels/chat_Model.dart';
import 'package:instagram_duplicate_app/DATA/ChatModels/message_Mdel.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/state.dart';


class ChatCubit extends Cubit<ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatCubit() : super(ChatInitial()) {
    _init();
  }

  void _init() async {
    emit(ChatLoading());
    try {
      final userId = _auth.currentUser!.uid;

      // Load chats
      _firestore
          .collection('chats')
          .where('userId1', isEqualTo: userId)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .listen((chatsSnapshot) {
        final chats = chatsSnapshot.docs
            .map((doc) => Chat.fromFirestore(doc.data(), doc.id))
            .toList();

        if (chats.isNotEmpty) {
          // Load messages for the first chat
          _firestore
              .collection('chats/${chats.first.id}/messages')
              .orderBy('timestamp', descending: true)
              .snapshots()
              .listen((messagesSnapshot) {
            final messages = messagesSnapshot.docs
                .map((doc) => Message.fromFirestore(doc.data(), doc.id))
                .toList();

            emit(ChatLoaded(chats, messages));
          });
        } else {
          emit(ChatLoaded(chats, [])); // Emit empty messages list
        }
      });
    } catch (e) {
      emit(ChatError('Failed to load chats: $e'));
    }
  }

  Future<String?> createChat(String userId2, String username) async {
    try {
      final userId1 = _auth.currentUser!.uid;

      // Check if chat already exists
      final existingChat = await _firestore
          .collection('chats')
          .where('userId1', isEqualTo: userId1)
          .where('userId2', isEqualTo: userId2)
          .get();

      if (existingChat.docs.isEmpty) {
        final chatRef = await _firestore.collection('chats').add({
          'userId1': userId1,
          'userId2': userId2,
          'username': username,
          'lastMessage': '',
          'lastMessageTime': Timestamp.fromDate(DateTime.now()),
        });
        return chatRef.id; // Return the chat ID
      } else {
        return existingChat.docs.first.id; // Return existing chat ID
      }
    } catch (e) {
      emit(ChatError('Failed to create chat: $e'));
      return null;
    }
  }

  Future<void> sendMessage(String chatId, String text) async {
    try {
      final userId = _auth.currentUser!.uid;
      final message = Message(
        id: '', // Firestore will auto-generate ID
        senderId: userId,
        receiverId: chatId,
        text: text,
        timestamp: DateTime.now(),
      );

      await _firestore.collection('chats/$chatId/messages').add(message.toMap());

      // Update last message in chat
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': text,
        'lastMessageTime': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      emit(ChatError('Failed to send message: $e'));
    }
  }
}