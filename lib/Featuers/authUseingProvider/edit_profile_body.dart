import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storeapp/Core/Utils/custom_progrss_hud.dart';
import 'package:storeapp/Core/Widget/custom_botton.dart';
import 'package:storeapp/Core/Widget/custom_text_field.dart';
import 'package:storeapp/Featuers/authUseingProvider/user_model.dart';

class EditUserInfoView extends StatefulWidget {
  final String uid;
  final UserModelProvider userModelProvider;
  final VoidCallback onUserInfoUpdated;

  const EditUserInfoView({
    super.key,
    required this.uid,
    required this.userModelProvider,
    required this.onUserInfoUpdated,
  });

  @override
  EditUserInfoViewState createState() => EditUserInfoViewState();
}

class EditUserInfoViewState extends State<EditUserInfoView> {
  late TextEditingController nameController;

  XFile? profileImage;
  String? profilePicUrl;
  bool isLoading = false;

  final String defaultProfileImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.userModelProvider.userName);

    profilePicUrl = widget.userModelProvider.userImage;
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImage = pickedImage;
      });
    }
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
    setState(() {
      isLoading = true;
    });

    try {
      if (profileImage != null) {
        profilePicUrl = await _uploadImageToFirebase(profileImage!.path);
      }

      final updatedUserInfo = {
        'name': nameController.text,
        'profilePic': profilePicUrl,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(updatedUserInfo);

      widget.onUserInfoUpdated();

      if (!mounted) return;

      Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint("Error updating user info: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: CustomProgrssHud(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: profileImage != null
                        ? FileImage(File(profileImage!.path))
                        : (profilePicUrl != null && profilePicUrl!.isNotEmpty)
                            ? NetworkImage(profilePicUrl!)
                            : NetworkImage(defaultProfileImage),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: 'Name',
                  controller: nameController,
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                CustomBotton(
                  text: 'Update',
                  onPressed: _updateUserInfo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
