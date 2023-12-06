import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final String formattedTimestamp;

  const ChatBubbleWidget(
      {super.key, required this.message, required this.mainAxisAlignment, required this.crossAxisAlignment, required this.formattedTimestamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            formattedTimestamp,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
