import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/DATA/ChatModels/chat_Model.dart';
import 'package:instagram_duplicate_app/UI/Messages/chat_Screen.dart';


class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/profile.jpg'),
      ),
      title: Text(chat.username),
      subtitle: Text(chat.lastMessage),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              chatId: chat.id,
              otherUserId: chat.userId2,
              otherUsername: chat.username,
            ),
          ),
        );
      },
    );
  }
}