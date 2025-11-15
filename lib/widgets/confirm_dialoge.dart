import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';

class ConfirmDialoge extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String buttonText;
  final Function()? onTap;
  const ConfirmDialoge(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.buttonText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff3D4145),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff3D4145),
          border: Border.all(
            color: AppColors.whiteColor.withOpacity(0.17),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(AppImages.verifiedIcon),
            const SizedBox(
              height: 20,
            ),
            AppTextStyle(
              text: heading,
              fontSize: 19,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDark,
            ),
            const SizedBox(
              height: 6,
            ),
            AppTextStyle(
              text: subHeading,
              fontSize: 11,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: GestureContainer(
                onTap: onTap,
                text: buttonText,
                textColor: AppColors.blackColor,
                isNeedArrow: false,
                isValidate: true,
                height: 40,
                textSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
