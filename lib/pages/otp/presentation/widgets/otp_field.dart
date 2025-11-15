import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/styles.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final AppState state;
  const OtpField({super.key, required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: Styles.textStyle.copyWith(fontSize: 18,color: state == AppState.user ? AppColors.blackColor : AppColors.whiteColor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Pinput(
      closeKeyboardWhenCompleted: true,

      length: 6,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      submittedPinTheme: defaultPinTheme,
      showCursor: true,
      onClipboardFound: (value) {
        controller.text = value;
      },
      onCompleted: (pin) => print(pin),
    );
  }
}
