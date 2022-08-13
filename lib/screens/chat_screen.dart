import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          DropdownButton(
            icon: const  Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                value: "Log out",
                child: Row(
                  children: const [Icon(Icons.exit_to_app), SizedBox(width: 8,), Text("Log out")],
                ),
              )
            ], 
            onChanged: (value) async {
              if (value == "Log out") {
                await FirebaseAuth.instance.signOut();
              }
            }
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("chats").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final texts = snapshot.data!.docs;
            return ListView.builder(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("chats").add({"text": "new msg"});
        },
      ),
    );
  }
}
