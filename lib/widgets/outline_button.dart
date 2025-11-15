import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';

import '../utils/app_text_style.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool? isLoading;
  final bool? isValidate;
  const CustomOutlineButton(
      {super.key,
        this.onTap,
        required this.text,
        this.isLoading,
        this.isValidate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.whiteColor.withOpacity(0.2),
      splashFactory: InkSparkle.splashFactory,
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(11.77),
        ),
        child: isLoading == true ? const Center(child: CircularProgressIndicator(),) : AppTextStyle(
          text: text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
    );
  }
}
