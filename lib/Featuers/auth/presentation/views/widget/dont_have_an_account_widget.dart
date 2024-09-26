import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Featuers/auth/presentation/views/signup_view.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: "Don't have an account? ",
              style: AppStyles.styleRegular16
                ..copyWith(
                  color: const Color(0xff949d9e),
                )),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
            text: 'Sign Up',
            style: AppStyles.styleSemiBold16.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
