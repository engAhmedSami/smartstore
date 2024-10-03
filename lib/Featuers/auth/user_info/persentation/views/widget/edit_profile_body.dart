import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storeapp/Core/Helper_Functions/scccess_top_snak_bar.dart';
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
  bool isLoading = false;

  // Default profile image path
  final String defaultProfileImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userInfo.name);
    bioController = TextEditingController(text: widget.userInfo.bio);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    await ShowDialogClass.imagePickerDialog(
      context: context,
      cameraFCT: () {
        picker.pickImage(source: ImageSource.camera).then(
          (value) {
            setState(() {
              profileImage = value;
            });
          },
        );
      },
      galleryFCT: () {
        picker.pickImage(source: ImageSource.gallery).then(
          (value) {
            setState(() {
              profileImage = value;
            });
          },
        );
      },
      removeFCT: () {
        setState(() {
          profileImage = null; // Reset profile image to null
          succesTopSnackBar(
            context,
            'Profile image removed successfully',
          );
        });
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

  Future<void> _deleteImageFromFirebase(String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete(); // Delete the image from Firebase Storage
      debugPrint("Image deleted successfully from Firebase Storage");
    } catch (e) {
      debugPrint("Error deleting image: $e");
    }
  }

  Future<void> _updateUserInfo() async {
    setState(() {
      isLoading = true; // Start loading
    });

    String? profilePicUrl = widget.userInfo.profilePic;

    try {
      // If the user is removing the image, delete it from Firebase
      if (profileImage == null && profilePicUrl != null) {
        await _deleteImageFromFirebase(
            profilePicUrl); // Remove image if not selecting a new one
        profilePicUrl = null; // Reset the profilePicUrl to null after deletion
      }
      // Upload profile image if it was selected
      else if (profileImage != null) {
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

      // After updating, navigate or perform UI actions
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint("Error updating user info: $e");
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
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
                    radius: 70,
                    backgroundImage: profileImage != null
                        ? FileImage(File(profileImage!.path))
                        : (widget.userInfo.profilePic != null &&
                                widget.userInfo.profilePic!.isNotEmpty
                            ? NetworkImage(widget.userInfo.profilePic!)
                            : NetworkImage(defaultProfileImage)
                                as ImageProvider),
                  )

                  // CircleAvatar(
                  //   radius: 70,
                  //   backgroundImage: profileImage != null
                  //       ? FileImage(
                  //           File(profileImage!.path)) // New selected image
                  //       : (profileImage == null &&
                  //               widget.userInfo.profilePic == null)
                  //           ? NetworkImage(
                  //               defaultProfileImage) // Default image if no image is selected
                  //           : widget.userInfo.profilePic != null
                  //               ? NetworkImage(widget
                  //                   .userInfo.profilePic!) // Old uploaded image
                  //               : NetworkImage(defaultProfileImage),
                  // ),
                  ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'Name',
                controller: nameController,
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 24),
              CustomBotton(
                text: 'Update',
                onPressed: _updateUserInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
