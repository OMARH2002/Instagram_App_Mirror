import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/auth.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/mymesssage.dart';


class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final authService = AuthService();

  final controller = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user ;

  @override
  void initState() {
    user = _auth.currentUser!;
  }

  void logout() {
    authService.logout();
  }

  void addMessage(){
    if (controller.text.isEmpty) return;

    _db.collection('chats').add({
      'userID': user?.uid,
      'message': controller.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text('Chat'),

      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _db.collection('chats').orderBy('timestamp').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(color: Colors.teal,));
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    var newMessage = messages[index];
                    bool isMe = newMessage['userID'] == user?.uid;
                    return MyMessage(message: newMessage['message'], isMe: isMe);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal))),
                  ),
                ),
                IconButton(onPressed: addMessage, icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
