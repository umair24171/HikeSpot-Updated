import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/styles.dart';

import '../utils/images_paths.dart';

class AppWidgets {
  // app logo used on login pages
  static Image appLogo = Image.asset(
    AppImages.appLogoPng,
    height: 57,
    width: 210,
  );
}

// terms and condition rich text
class AgreementText extends StatelessWidget {
  const AgreementText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: 'Joining our app means you agree to\n HikeSpot’s ',
              style: Styles.textStyle.copyWith(fontSize: 14)),
          TextSpan(
              text: 'Terms of Service ',
              style: Styles.textStyle.copyWith(fontSize: 14, color: Colors.red)
              // recognizer: TapGestureRecognizer()..onTap = () {},
              ),
          TextSpan(
              text: 'and ', style: Styles.textStyle.copyWith(fontSize: 14)),
          TextSpan(
              text: 'Privacy \n Policy.',
              style: Styles.textStyle.copyWith(fontSize: 14, color: Colors.red)
              // Add onTap handler for navigating to Privacy Policy
              // recognizer: TapGestureRecognizer()..onTap = () {},
              ),
        ],
      ),
    );
  }
}

// login text

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: 'Don’t have an account? ',
              style: Styles.textStyle.copyWith(fontSize: 14)),
          TextSpan(
              text: 'Sign Up',
              style: Styles.textStyle.copyWith(fontSize: 14, color: AppColors.primaryDark)
              ),
          // recognizer: TapGestureRecognizer()..onTap = () {},
        ],
      ),
    );
  }
}
