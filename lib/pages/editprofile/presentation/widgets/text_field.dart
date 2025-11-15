import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/styles.dart';

class ProfileTextField extends StatelessWidget {
  final String hintText;
  final String heading;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const ProfileTextField(
      {super.key, required this.hintText, required this.heading, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: heading,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          style: Styles.textStyle
              .copyWith(fontSize: 16, color: AppColors.whiteColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: const BoxConstraints(maxHeight: 50),
            fillColor: AppColors.secContainerColor,
            hintText: hintText,
            hintStyle: Styles.textStyle
                .copyWith(fontSize: 16, color: AppColors.primaryGreyColor),
            filled: true,
            border:
                Styles.textFieldBorder.copyWith(borderSide: BorderSide.none),
            enabledBorder:
                Styles.textFieldBorder.copyWith(borderSide: BorderSide.none),
            focusedBorder:
                Styles.textFieldBorder.copyWith(borderSide: BorderSide.none),
            disabledBorder:
                Styles.textFieldBorder.copyWith(borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
