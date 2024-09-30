import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeapp/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Core/Utils/show_dialog.dart';
import 'package:storeapp/Core/Widget/custom_botton.dart';
import 'package:storeapp/Core/Widget/custom_text_field.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/have_an_account_widget.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/implement_profile_image.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/password_field.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/terms_and_condition.dart';

import 'package:storeapp/constans.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  late final TextEditingController comfirmpasswordcontroller;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode comfirmpasswordFocusNode;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, userName, password;
  late bool isTermsAccepted = false;
  XFile? pickImage;

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    comfirmpasswordcontroller = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    comfirmpasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    comfirmpasswordcontroller.dispose();
    super.dispose();
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await ShowDialogClass.imagePickerDialog(
      context: context,
      cameraFCT: () {
        picker.pickImage(source: ImageSource.camera).then(
          (value) {
            setState(
              () {
                pickImage = value;
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
                pickImage = value;
              },
            );
          },
        );
      },
      removeFCT: () {
        setState(
          () {
            pickImage = null;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const AppNameAnimatedText(
                text: 'Shop Smart',
                fontSize: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wellcome',
                  style: AppStyles.styleSemiBold24,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign up now to receive special offers and updates from our app",
                  style: AppStyles.styleMedium14,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ImplementProfileImage(
                pickImage: pickImage,
                function: () async {
                  await localImagePicker();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    CustomTextFormField(
                      onSaved: (value) {
                        userName = value!;
                      },
                      hintText: 'Full Name',
                      textInputType: TextInputType.name,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      validator: (value) {
                        return MyValidators.displayNamevalidator(
                          value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        email = value!;
                      },
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      validator: (value) {
                        return MyValidators.emailValidator(
                          value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PasswordField(
                      controller: passwordcontroller,
                      hintText: 'Password',
                      onSaved: (value) {
                        password = value!;
                      },
                      focusNode: passwordFocusNode,
                      validator: (value) {
                        return MyValidators.passwordValidator(
                          value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PasswordField(
                      controller: comfirmpasswordcontroller,
                      hintText: 'Confirm Password',
                      onSaved: (value) {
                        password = value!;
                      },
                      focusNode: comfirmpasswordFocusNode,
                      validator: (value) {
                        return MyValidators.repeatPasswordValidator(
                          value: value,
                          password: passwordcontroller.text,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TermsAndCondition(
                      onChange: (value) {
                        isTermsAccepted = value;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomBotton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          // Check if the user accepted the terms and selected an image
                          if (!isTermsAccepted) {
                            failuerTopSnackBar(
                              context,
                              'You must agree to the terms and conditions.',
                            );
                            return; // Stop further processing if terms are not accepted
                          }

                          if (pickImage == null) {
                            ShowDialogClass.showDialogClass(
                              isError: true,
                              context: context,
                              text: 'Please select an image',
                              function: () {},
                            );
                            return; // Stop further processing if image is not selected
                          }

                          // Proceed with signup if both conditions are met
                          context
                              .read<SignupCubit>()
                              .createUserWithEmailAndPassword(
                                email,
                                password,
                                userName,
                                pickImage!.path,
                              );
                        } else {
                          setState(
                            () {
                              autovalidateMode = AutovalidateMode.always;
                            },
                          );
                        }
                      },
                      text: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const HaveAnAccountWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
