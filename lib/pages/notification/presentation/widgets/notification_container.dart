import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/sizes.dart';

class NotificationContainer extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String subHeading;
  const NotificationContainer(
      {super.key,
      required this.imagePath,
      required this.heading,
      required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: AppColors.secContainerColor),
      child: Row(
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
                color: AppColors.customColor(0xff515862),
                shape: BoxShape.circle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 20,
                  width: 20,
                )
              ],
            ),
          ),
          SizedBox(
            width: getHeight(context) * 0.008,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle(
                  text: heading,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  height: getHeight(context) * 0.005,
                ),
                AppTextStyle(
                  text: subHeading,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor.withOpacity(0.8),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
