import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chart/chats/chat.dart';
import 'package:my_chart/chats/new_messages.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purple,
        title: const Text("My Chat",
            style: TextStyle(fontSize: 25, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: DropdownButton(
                icon: const Icon(Icons.menu_rounded,color: Colors.white),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(Icons.access_alarm_rounded),
                        Text("Logout"),
                      ],
                    ),
                  )
                ],
                onChanged: (items) {
                  if (items == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                }),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: ChatMainScreen()),
          NewMessages(),
        ],
      ),
    );
  }
}
