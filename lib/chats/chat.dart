import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'messege_bubble.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD1B1FF),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final datas = snapshot.data?.docs;
          return ListView.builder(
            reverse: true,
            itemCount: datas!.length,
            itemBuilder: (context, index) {
              return MessegeBubble(
                message: datas[index]['text'],
                userId: datas[index]['userId'],
                isMe: datas[index]['userId'] == user?.uid,
                key: ValueKey(datas[index].id),
              );
            },
          );
        },
      ),
    );
  }
}
