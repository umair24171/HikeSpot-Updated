import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class UploadDocConatiner extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Function()? onTap;
  final IconData icon;
  const UploadDocConatiner(
      {super.key,
      required this.heading,
      required this.subHeading,
      this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.secContainerColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: heading,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
                AppTextStyle(
                  text: subHeading,
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primaryGreyColor,
                )
              ],
            ),
            const Spacer(),
              Icon(icon, color: AppColors.primaryDark)
          ],
        ),
      ),
    );
  }
}
