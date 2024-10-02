// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<File?> pichImage(BuildContext context) async {
  File? image;

  try {
    final pickerdImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerdImage != null) {
      image = File(pickerdImage.path);
    }
  } catch (e) {
    snackBar(context, e.toString());
  }

  return image;
}
