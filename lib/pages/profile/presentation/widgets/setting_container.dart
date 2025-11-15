import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class SettingContainer extends StatelessWidget {
  final String containerText;
  final String icon;
  final bool? isNeedPrefixIcon;
  final bool isNeedIcon;
  final Function()? onTap;
  final Widget? suffixIxon;
  final Color? textColor;
  const SettingContainer(
      {super.key,
      required this.containerText,
      required this.icon,
      this.isNeedIcon = true,
      this.textColor,
      this.onTap, this.isNeedPrefixIcon = true, this.suffixIxon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secContainerColor,
        ),
        child: Row(
          children: [
            if(isNeedPrefixIcon == true)
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: AppColors.containerColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AppTextStyle(
                text: containerText,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: textColor ?? AppColors.whiteColor),
            const Spacer(),
            if (isNeedIcon == true)
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primaryDark,
                size: 15,
              ),
              suffixIxon ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
