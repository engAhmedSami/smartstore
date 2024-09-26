import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Core/Utils/assets.dart';
import 'package:storeapp/Core/Widget/custom_botton.dart';
import 'package:storeapp/Core/Widget/custom_text_field.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/forgot_password_view.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/dont_have_an_account_widget.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/or_divider.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/password_field.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/social_login_button.dart';

import 'package:storeapp/constans.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late String email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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
                  'Wellcome Back',
                  style: AppStyles.styleSemiBold24,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's get you logged in so you can start exploring",
                  style: AppStyles.styleMedium14,
                ),
              ),
              Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextFormField(
                      controller: emailcontroller,
                      focusNode: emailFocusNode,
                      hintText: 'example123@gmail.com',
                      textInputType: TextInputType.emailAddress,
                      onSaved: (value) {
                        email = value!;
                      },
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PasswordField(
                      hintText: 'password',
                      focusNode: passwordFocusNode,
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgotPasswordView.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forget Password?',
                            style: AppStyles.styleRegular16.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    CustomBotton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context
                              .read<SigninCubit>()
                              .signIn(email: email, password: password);
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      text: 'Sign In',
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    const DontHaveAnAccountWidget(),
                    const SizedBox(
                      height: 33,
                    ),
                    const OrDivider(),
                    const SizedBox(
                      height: 16,
                    ),
                    SocialLoginButton(
                      onPressed: () {
                        context.read<SigninCubit>().signInWithGoogle();
                      },
                      image: Assets.users_imagesGoogle,
                      tital: 'Sign in with Google',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SocialLoginButton(
                      onPressed: () {},
                      image: Assets.users_imagesGuest,
                      tital: 'Sign in as Guest',
                    ),
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
