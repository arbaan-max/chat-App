import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_code.dart';

class AuthMainScreen extends StatefulWidget {
  const AuthMainScreen({super.key});

  @override
  State<AuthMainScreen> createState() => Auth_MainScreenState();
}

// ignore: camel_case_types
class Auth_MainScreenState extends State<AuthMainScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _onSubmitData(
      bool isLogin, String email,
      //  String userName,
        String password) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
            // 'username':userName,
        'password': password,
        'email': email,
      });
    } catch (error) {
     String errorMessage='hello';
  print(error);
  setState(() {
    isLoading = false;
    errorMessage = error.toString();
  });
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    ),
  );
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_onSubmitData, isLoading),
    );
  }
}
