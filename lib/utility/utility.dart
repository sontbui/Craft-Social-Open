import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackbar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Future<File?> pickImage(
    {required BuildContext context, required bool fromCamera}) async {
  File? fileImage;
  if (fromCamera) {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        fileImage = File(pickedImage.path);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  } else {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        fileImage = File(pickedImage.path);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
  return fileImage;
}
