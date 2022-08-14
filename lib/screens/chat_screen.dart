import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_input_widget.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert, color: Colors.white,),
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: "Log out",
                child: Row(
                  children: const [Icon(Icons.exit_to_app, color: Colors.black,), SizedBox(width: 8,), Text("Log out")],
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
      body: Column(
        children: const [
          Expanded(
            child: MessagesWidget()
          ),
          MessageInputWidget()
        ],
      ),
    );
  }
}
