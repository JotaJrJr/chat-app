import 'package:chat_app/common/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final String receiverUserId;

  ChatViewModel({required this.receiverUserId});

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(messageController.text, receiverUserId);
      messageController.clear();
    } else {
      print('Empty message');
    }
    notifyListeners();
  }
}
