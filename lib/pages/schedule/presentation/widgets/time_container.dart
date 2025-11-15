import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class TimeContainer extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? onTap;
  const TimeContainer({super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 49,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secContainerColor,
        ),
        child:    Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(
              width: 9,
            ),
             AppTextStyle(text: text, fontSize: 17, fontWeight: FontWeight.w400,color: AppColors.whiteColor,),
            const Spacer(),
             const Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.primaryDark,),
          ],
        ),
      ),
    );
  }
}