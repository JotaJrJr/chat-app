import 'package:chat_app/common/feature/chat/viewmodel/chat_view_model.dart';
import 'package:chat_app/common/feature/chat/widget/chat_bubble_widget.dart';
import 'package:chat_app/common/widgets/text_form_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ChatViewModel(receiverUserId: widget.receiverUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
          animation: _viewModel,
          builder: (_, __) {
            return Column(
              children: [
                Expanded(
                  child: _buildMessageList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildMessageInput(),
                ),
                const SizedBox(height: 18.0),
              ],
            );
          }),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _viewModel.chatService.getMessages(
          widget.receiverUserId,
          _viewModel.firebaseAuth.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    var alignment = (data['senderId'] == _viewModel.firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    Timestamp timestamp = data['timeStamp'] ?? Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    String formattedTimestamp = DateFormat('dd/MM - HH:mm').format(dateTime);

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _viewModel.firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _viewModel.firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            // Text(data['message']),
            // Text(formattedTimestamp),
            ChatBubbleWidget(
              message: data['message'],
              mainAxisAlignment: (data['senderId'] == _viewModel.firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: (data['senderId'] == _viewModel.firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              formattedTimestamp: formattedTimestamp,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormFieldWidget(
              controller: _viewModel.messageController,
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: IconButton(
              onPressed: () => _viewModel.sendMessage(),
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
