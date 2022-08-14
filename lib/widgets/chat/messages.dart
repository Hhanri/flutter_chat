import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_bubble_widget.dart';
import 'package:flutterfire_ui/firestore.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Map<String, dynamic>>(
        padding: const EdgeInsets.all(8),
        reverse: true,
        shrinkWrap: true,
        loadingBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        query: FirebaseFirestore.instance.collection("chats").orderBy("createdAt", descending: true),
        itemBuilder: (context, snapshot) {
          final Map<String, dynamic> doc = snapshot.data();
          return MessageBubbleWidget(
            key: ValueKey(snapshot.id),
            message: doc["text"]!, isMe: doc["uid"] == FirebaseAuth.instance.currentUser!.uid
          );
        }
    );
  }
}
