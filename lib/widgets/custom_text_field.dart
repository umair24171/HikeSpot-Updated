import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/helper/text_validator.dart';

import '../blocs/cubits/text_field_cubit.dart';
import '../core/di/service_locator_imports.dart';
import '../utils/app_colors.dart';
import '../utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String icon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String inputText = "";
  bool isEmailStruchter = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: inputText.isNotEmpty
                  ? AppColors.primaryDark.withOpacity(0.25)
                  : AppColors.primaryGreyColor.withOpacity(0.25),
              spreadRadius: 3.62,
              blurRadius: 3.62,
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          style: Styles.textStyle,
          cursorColor: AppColors.primaryDark,
          onChanged: (value) {
            _phoneTextFieldCubit.checkField();
            setState(() {
              inputText = value;
              if (StringValidator.emailRegex.hasMatch(value)) {
                isEmailStruchter = true;
              } else {
                isEmailStruchter = false;
              }
            });
          },
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 4),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.icon,
                  color: isEmailStruchter
                      ? Colors.blue
                      : AppColors.primaryGreyColor,
                ),
              ],
            ),
            fillColor: AppColors.whiteColor,
            constraints: const BoxConstraints(
              maxHeight: 44,
              minHeight: 44,
            ),
            border: Styles.textFieldBorder,
            enabledBorder: Styles.textFieldBorder.copyWith(
              borderSide: BorderSide(
                  color: inputText.isNotEmpty
                      ? AppColors.primaryDark
                      : AppColors.primaryGreyColor,
                  width: 1),
            ),
            focusedBorder: Styles.textFieldBorder.copyWith(
              borderSide:
                  const BorderSide(color: AppColors.primaryDark, width: 1),
            ),
          ),
        ));
  }
}

final TextFieldCubit _phoneTextFieldCubit = Di().sl<TextFieldCubit>();
