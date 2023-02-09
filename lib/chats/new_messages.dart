import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_chart/main.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _enteredMessege = '';
  final TextEditingController _controller = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessege,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
    });
    _controller.clear();
  }


  //   void showNotification() {
  //   setState(() {
  //     _enteredMessege;
  //   });
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Count $_enteredMessege",
  //       "How you doin ?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(channel.id, channel.name,
  //               channelDescription: channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD1B1FF),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Send Message',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessege = value;
              });
            },
          ),
        ),
        IconButton(
            onPressed: _enteredMessege.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send))
      ]),
    );
  }
}
