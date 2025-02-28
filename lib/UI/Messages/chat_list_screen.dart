import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:instagram_duplicate_app/DATA/user%20chat/usermodel.dart';
import 'package:instagram_duplicate_app/UI/Messages/chat_Screen.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('UserData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found', style: TextStyle(fontSize: 16)));
          }

          final users = snapshot.data!.docs
              .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: users.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final user = users[index];
              if (user.uid == FirebaseAuth.instance.currentUser!.uid) {
                return SizedBox.shrink(); // Skip the current user
              }
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(user.avatar),
                ),
                title: Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(user.username, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                trailing: Icon(Icons.chat_bubble_outline, color: Colors.blueAccent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
