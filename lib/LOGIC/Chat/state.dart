import 'package:instagram_duplicate_app/DATA/ChatModels/chat_Model.dart';
import 'package:instagram_duplicate_app/DATA/ChatModels/message_Mdel.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;
  final List<Message> messages;

  ChatLoaded(this.chats, this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}