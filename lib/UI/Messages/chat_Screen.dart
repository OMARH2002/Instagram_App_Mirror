import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:instagram_duplicate_app/DATA/ChatModels/chat_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/Chat/state.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  ChatScreen({required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _receiverName;
  String? _receiverImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchReceiverDetails();
  }

  Future<void> _fetchReceiverDetails() async {
    final receiverDoc = await FirebaseFirestore.instance.collection('UserData').doc(widget.receiverId).get();
    if (receiverDoc.exists) {
      setState(() {
        _receiverName = receiverDoc['name'];
        _receiverImageUrl = receiverDoc['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (_receiverImageUrl != null)
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(_receiverImageUrl!),
                radius: 18,
              ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _receiverName ?? 'Loading...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

              ],
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatError) {
                    return Center(child: Text(state.error));
                  }
                  return StreamBuilder<List<ChatModel>>(
                    stream: context.read<ChatCubit>().getMessages(widget.receiverId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No messages yet', style: TextStyle(color: Colors.grey)));
                      }
                      final messages = snapshot.data!;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });

                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.senderId == FirebaseAuth.instance.currentUser!.uid;
                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              padding: EdgeInsets.all(12),
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.blueAccent : Colors.grey[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.message,
                                    style: TextStyle(color: isMe ? Colors.white : Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    DateFormat('h:mm a').format(message.timestamp), // Corrected line
                                    style: TextStyle(fontSize: 12, color: isMe ? Colors.white70 : Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        context.read<ChatCubit>().sendMessage(widget.receiverId, message);
                        _messageController.clear();
                        Future.delayed(Duration(milliseconds: 300), () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 24,
                      child: Icon(Icons.send, color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}