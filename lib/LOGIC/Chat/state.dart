abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatMessageSent extends ChatState {}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}