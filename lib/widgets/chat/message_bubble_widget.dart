import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  const MessageBubbleWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
        ),
        const Spacer()
      ],
    );
  }
}
