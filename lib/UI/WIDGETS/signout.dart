import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/UI/WELCOME%20SCREENS/LOGIN_SCREEN.dart';

void showSignOutMenu(BuildContext context) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust position as needed
    items: [
      PopupMenuItem<String>(
        value: 'signOut',
        child: Text('Sign Out'),
      ),
    ],
  ).then((value) {
    if (value == 'signOut') {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      FirebaseAuth.instance.signOut();
    }
  });
}
