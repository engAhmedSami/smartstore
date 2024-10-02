import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/show_dialog.dart';
import 'package:storeapp/Core/Widget/custom_botton.dart';
import 'package:storeapp/Core/Widget/custom_text_field.dart';
import 'package:storeapp/Featuers/auth/user_info/data/user_info_model.dart';

class EditUserInfoView extends StatefulWidget {
  final String uid;
  final UserInfoModel userInfo;
  final VoidCallback onUserInfoUpdated;

  const EditUserInfoView({
    super.key,
    required this.uid,
    required this.userInfo,
    required this.onUserInfoUpdated,
  });

  @override
  EditUserInfoViewState createState() => EditUserInfoViewState();
}

class EditUserInfoViewState extends State<EditUserInfoView> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  XFile? profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userInfo.name);
    bioController = TextEditingController(text: widget.userInfo.bio);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    await ShowDialogClass.imagePickerDialog(
      context: context,
      cameraFCT: () {
        picker.pickImage(source: ImageSource.camera).then(
          (value) {
            setState(
              () {
                profileImage = value;
              },
            );
          },
        );
      },
      galleryFCT: () {
        picker.pickImage(source: ImageSource.gallery).then(
          (value) {
            setState(
              () {
                profileImage = value;
              },
            );
          },
        );
      },
      removeFCT: () {
        setState(
          () {
            profileImage = null;
          },
        );
      },
    );
  }

  Future<String?> _uploadImageToFirebase(String filePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final file = File(filePath);
      final fileName = file.uri.pathSegments.last;
      final imageRef = storageRef.child("profile_pics/$fileName");
      final uploadTask = imageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _updateUserInfo() async {
    String? profilePicUrl = widget.userInfo.profilePic;

    try {
      // Upload profile image if it was selected
      if (profileImage != null) {
        profilePicUrl = await _uploadImageToFirebase(profileImage!.path);
      }

      // Update Firestore user data
      final updatedUserInfo = {
        'name': nameController.text,
        'bio': bioController.text,
        'profilePic': profilePicUrl,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(updatedUserInfo);

      // Notify parent widget of the update
      widget.onUserInfoUpdated();

      // After updating, navigate or perform UI actions, check mounted here
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint("Error updating user info: $e");

      // Handle specific errors like unauthorized access
      if (e is FirebaseException && e.code == 'storage/unauthorized') {
        // Handle token regeneration or notify the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppNameAnimatedText(
          text: 'Edit Profile',
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImage != null
                      ? FileImage(
                          File(profileImage!.path),
                        )
                      : NetworkImage(widget.userInfo.profilePic ?? ''),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'Name',
                controller: nameController,
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                textInputType: TextInputType.name,
              ),
              // const SizedBox(height: 24.0),
              // CustomTextFormField(
              //   hintText: 'Bio',
              //   controller: bioController,
              //   prefixIcon: const Icon(Icons.person, color: Colors.grey),
              //   textInputType: TextInputType.name,
              // ),
              // const SizedBox(height: 24.0),
              // CustomTextFormField(
              //   hintText: 'Email',
              //   controller: TextEditingController(text: widget.userInfo.email),
              //   prefixIcon: const Icon(Icons.email, color: Colors.grey),
              //   textInputType: TextInputType.emailAddress,
              // ),
              const SizedBox(height: 24),
              CustomBotton(
                text: 'Update',

                onPressed: _updateUserInfo, // Call async update
              ),
            ],
          ),
        ),
      ),
    );
  }
}
