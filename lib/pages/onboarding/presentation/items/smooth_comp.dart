import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/custom_container.dart';

class SmoothComp extends StatelessWidget {
  final Color color;
  const SmoothComp({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: getHeight(context),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 85,
            ),
            const CustomContainer(text: "Safe and Smooth"),
            const AppTextStyle(text: " rides", fontSize: 34, fontWeight: FontWeight.w700),
            const SizedBox(
              height: 50,
            ),
            Image.asset(AppImages.onBoarding4,height: 178,width: getWidth(context),),
            const SizedBox(
              height: 50,
            ),
            const AppTextStyle(
                text:
                "We ask our drivers to keep their\ncars in good condition and\nfollow traffic rules to ensure\nyour safety.",
                fontSize: 20,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w300),
            SizedBox(
              height: getHeight(context) / 6,
            ),
            SizedBox(
              width: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreyColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreyColor,
                      shape: BoxShape.circle,
                    ),
                  ),Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreyColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 7,
                    width: 20,
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(7)
                    ),
                  ),Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreyColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
