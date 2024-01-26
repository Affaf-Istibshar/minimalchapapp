import 'package:flutter/material.dart';
class ChatPage extends StatelessWidget {
  final String receiveEmail;
  const ChatPage({super.key,
  required this.receiveEmail
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(receiveEmail),
      ),
    );
  }
}
