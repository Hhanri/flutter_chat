import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final bool isMe;
  const MessageBubbleWidget({Key? key, required this.message, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey.shade300 : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 12 : 0),
              bottomLeft: const Radius.circular(12),
              topRight: Radius.circular(isMe ? 0 : 12),
              bottomRight: const Radius.circular(12),

            )
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(message, style: TextStyle(color: isMe ? Colors.black87 : Theme.of(context).colorScheme.onSecondary),),
        ),
      ],
    );
  }
}
