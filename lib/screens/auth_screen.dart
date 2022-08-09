import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  void _submitAuthForm({required String email, required String password, required String username, required bool isLogin}) async {
    try {
      late UserCredential userData;
      if (isLogin) {
        userData = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (error) {
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
      body: AuthFormWidget(submitAuth: _submitAuthForm,)
    );
  }
}
