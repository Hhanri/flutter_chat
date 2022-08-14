import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool isLoading = false;

  void _submitAuthForm({required String email,  required File image, required String password, required String username, required bool isLogin,}) async {
    try {
      setState(() {
        isLoading = true;
      });
      late UserCredential userData;
      if (isLogin) {
        userData = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);


        final ref = FirebaseStorage.instance.ref().child('user_image').child("${userData.user!.uid}.jpg");
        await ref.putFile(image).whenComplete(() => null);

        await FirebaseFirestore.instance
          .collection("users")
          .doc(userData.user!.uid)
          .set({
            "username": username,
            "uid": userData.user!.uid,
            "image": await ref.getDownloadURL()
          });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      String errorMessage = "An error occurred, please check your credentials ";
      if (error.message != null) errorMessage = error.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Theme.of(context).errorColor,),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(submitAuth: _submitAuthForm, isLoading: isLoading)
    );
  }
}
