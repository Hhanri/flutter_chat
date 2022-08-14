import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/pickers/user_image_picker.dart';

class AuthFormWidget extends StatefulWidget {

  final void Function({required String email, required String password, required String username, required bool isLogin, required File image}) submitAuth;
  final bool isLoading;

  const AuthFormWidget({Key? key, required this.submitAuth, required this.isLoading}) : super(key: key);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {

  bool isLogin = true;

  File? _userImage;

  String _email = "";
  String _password = "";
  String _username = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void trySubmit() {
    FocusScope.of(context).unfocus();
    if (_userImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please import an image as a profile picture")));
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.submitAuth(email: _email.trim(), password: _password, username: _username, isLogin: isLogin, image: _userImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) UserImagePicker(pickImage: (file) => _userImage = file,),
                  //email
                  TextFormField(
                    key: const ValueKey("email"),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) return "Please enter a valid email";
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address"
                    ),
                    onSaved: (value) => _email = value ?? "",
                  ),
                  //username
                  if (!isLogin)
                  TextFormField(
                    key: const ValueKey("username"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) return "Username must be at least 4 characters long";
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Username"
                    ),
                    onSaved: (value) => _username = value ?? "",
                  ),
                  //password
                  TextFormField(
                    key: const ValueKey("password"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) return "Password must be at least 6 characters long";
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password"
                    ),
                    onSaved: (value) => _password = value ?? "",
                  ),
                  const SizedBox(height: 12,),
                  if (widget.isLoading) const Center(child: CircularProgressIndicator(),),
                  if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: trySubmit,
                    child: Text(isLogin ? "Login" : "Signup")
                  ),
                  if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin ? "Create new account" : "Already have an account")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
