import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final String uid;
  final String username;
  final bool isMe;
  final String userImage;
  const MessageBubbleWidget({Key? key, required this.message, required this.uid, required this.isMe, required this.username, required this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black87 : Theme.of(context).colorScheme.onSecondary
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.black87 : Theme.of(context).colorScheme.onSecondary),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 125,
          right: isMe ? 125 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
      ],
    );
  }
}
