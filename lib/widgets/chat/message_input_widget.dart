import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget({Key? key}) : super(key: key);

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {

  late TextEditingController messageController;

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance.collection("chats").add({
      "text": messageController.text.trim(),
      "createdAt": Timestamp.now(),
      "uid": FirebaseAuth.instance.currentUser!.uid
    });
    messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    messageController.addListener(() { setState(() {

    }); });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: "Your message..."),
            )
          ),
          IconButton(
            onPressed: messageController.text.trim().isEmpty ? () {} : sendMessage,
            icon: const Icon(Icons.send),
            color: messageController.text.trim().isEmpty ? Colors.grey : Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
