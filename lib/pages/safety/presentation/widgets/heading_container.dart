import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/sizes.dart';

class HeadingContainer extends StatelessWidget {
  final String number;
  final String heading;
  final String text;
  const HeadingContainer(
      {super.key,
      required this.number,
      required this.heading,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.59),
                shape: BoxShape.circle,
              ),
              child: AppTextStyle(
                text: number,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AppTextStyle(
              text: heading,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ],
        ),
        SizedBox(
          height: getHeight(context) * 0.015,
        ),
        Container(
          width: getWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.secContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AppTextStyle(
            text: text,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor,
          ),
        )
      ],
    );
  }
}
