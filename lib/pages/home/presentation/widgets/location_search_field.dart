import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/styles.dart';

class LocationSearchField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool? readOnly;
  final bool inCenterText;
  const LocationSearchField(
      {super.key, required this.hintText, this.prefixIcon, this.suffixIcon, this.keyboardType, this.controller, this.onTap, this.readOnly, this.inCenterText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      textAlign: inCenterText ? TextAlign.center : TextAlign.start,
      readOnly: readOnly ?? false,
      style: Styles.textStyle
          .copyWith(color: AppColors.primaryGreyColor, fontSize: 18),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle: Styles.textStyle
            .copyWith(color: AppColors.primaryGreyColor, fontSize: 18),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        constraints: const BoxConstraints(maxHeight: 49, minHeight: 49),
        fillColor: AppColors.secContainerColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none
        ),
      ),
    );
  }
}
