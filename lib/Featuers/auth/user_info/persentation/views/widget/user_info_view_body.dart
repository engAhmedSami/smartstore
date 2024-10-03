import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:storeapp/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:storeapp/Core/Widget/custom_botton.dart';
import 'package:storeapp/Core/Widget/nav_bar.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/save_info_cubit/profile_cubit.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/views/show_snck_bar.dart';
import 'package:storeapp/constans.dart';

class UserInfoViewBody extends StatefulWidget {
  const UserInfoViewBody({super.key});

  @override
  State<UserInfoViewBody> createState() => _UserInfoViewBodyState();
}

class _UserInfoViewBodyState extends State<UserInfoViewBody> {
  File? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final selectedImage = await pichImage(context); // Get image immediately
    setState(() {
      image = selectedImage; // Only use setState here after image selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: selectImage,
                  child: image == null
                      ? const CircleAvatar(
                          radius: 70,
                          child: Icon(
                            IconlyBold.profile,
                            size: 70,
                          ),
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(image!),
                        ),
                ),
                // const SizedBox(height: 20),
                // CustomTextFormField(
                //   prefixIcon: const Icon(Icons.person),
                //   textInputType: TextInputType.name,
                //   controller: nameController,
                //   hintText: 'Enter Your Name',
                // ),
                // const SizedBox(height: 20),
                // CustomTextFormField(
                //   prefixIcon: const Icon(Icons.email),
                //   textInputType: TextInputType.emailAddress,
                //   controller: emailController,
                //   hintText: 'Enter Your Email',
                // ),
                // const SizedBox(height: 20),
                // CustomTextFormField(
                //   prefixIcon: const Icon(Icons.info),
                //   textInputType: TextInputType.name,
                //   controller: bioController,
                //   hintText: 'Enter Your Bio',
                // ),
                const SizedBox(height: 20),
                CustomBotton(
                  onPressed: () async {
                    await storeData(); // Don't pass context directly here
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> storeData() async {
    // Capture context at the time of calling and not across the async boundary
    final profileCubit = context.read<ProfileCubit>();

    if (image != null) {
      // Perform the async operation with stored cubit and context before
      await profileCubit.saveUserInfo(
        name: nameController.text,
        email: emailController.text,
        bio: bioController.text,
        profilePic: image!.path,
      );

      // Use Navigator after async work is done
      if (mounted) {
        Navigator.pushNamed(context, NavBar.routeName);
      }
    } else {
      // Show the snackbar within the current context before awaiting any async tasks
      failuerTopSnackBar(context, "Please select an image");
    }
  }
}
