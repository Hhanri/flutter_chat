import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("chats").orderBy("createdAt", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final texts = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return Text(texts[index].data()["text"]);
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
