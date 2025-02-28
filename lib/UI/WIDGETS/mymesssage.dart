import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  MyMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isMe ? Colors.teal : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
