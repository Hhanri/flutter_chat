import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File?) pickImage;
  const UserImagePicker({Key? key, required this.pickImage}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File? image;

  void pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      setState(() {
        image = file;
      });
      widget.pickImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: image != null ? FileImage(image!) : null,
        ),
        TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.camera),
          label: const Text("Add image"),
          style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }
}
