import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/state.dart';
import 'package:instagram_duplicate_app/UI/Messages/Search_dialog.dart';
import 'package:instagram_duplicate_app/UI/Messages/chat_Screen.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/chat_widgets/Chat_tile.dart';


class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          if (state is ChatLoaded) {
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return ChatTile(chat: chat);
              },
            );
          }
          return const Center(child: Text('No chats available'));
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SearchUserDialog(
        onUserSelected: (userId, username) {
          context.read<ChatCubit>().createChat(userId, username).then((chatId) {
            Navigator.pop(context); // Close the search dialog
            if (chatId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    chatId: chatId,
                    otherUserId: userId,
                    otherUsername: username,
                  ),
                ),
              );
            }
          });
        },
      ),
    );
  }
}