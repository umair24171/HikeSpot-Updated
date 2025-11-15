import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final double? textSize;
  const CustomContainer({super.key, required this.text, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.7),
          bottomRight: Radius.circular(15.7),
        ),
      ),
      child:
          AppTextStyle(text: text, fontSize: textSize ?? 34, fontWeight: FontWeight.w700),
    );
  }
}
