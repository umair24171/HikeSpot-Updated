import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import '../utils/app_text_style.dart';

class GestureContainer extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool? isLoading;
  final bool? isValidate;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? textSize;
  final Widget? customWidget;
  final bool isNeedArrow;
  final double? borderRadius;
  const GestureContainer(
      {super.key,
      this.onTap,
      required this.text,
      this.isLoading,
      this.isValidate,
      this.textColor,
      this.width,
      this.customWidget,
      this.isNeedArrow = true,
      this.height,
      this.borderRadius,
      this.textSize,
      this.buttonColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.whiteColor.withOpacity(0.2),
      splashFactory: InkSparkle.splashFactory,
      borderRadius: BorderRadius.circular(12),
      onTap: onTap ,
      child: Container(
        height: height ?? 54,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isValidate == false
              ? AppColors.primaryGreyColor
              : buttonColor ?? AppColors.primaryDark,
          border: isValidate == false
              ? Border.all(color: AppColors.transparent)
              : Border.all(
                  width: 2.6,
                  color: borderColor ?? AppColors.customColor(0xff979153)),
          borderRadius: BorderRadius.circular(borderRadius ?? 11.77),
          // boxShadow: isValidate == false
          //     ? null
          //     : [
          //         BoxShadow(
          //           color: buttonColor?.withOpacity(0.25) ?? AppColors.primaryDark.withOpacity(0.25),
          //           spreadRadius: 3.62,
          //           blurRadius: 3.62,
          //         )
          //       ],
        ),
        child: isLoading == true
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.whiteColor,
                    color: AppColors.primaryDark.withOpacity(0.7),
                    strokeWidth: 1.5,
                  ),
                ),
              )
            : customWidget ??
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                        // width: 25,
                        ),
                    AppTextStyle(
                      text: text,
                      fontSize: textSize ?? 18,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? AppColors.whiteColor,
                    ),
                    if (isNeedArrow == true)
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isValidate == false
                              ? AppColors.blackColor.withOpacity(0.2)
                              : const Color(0xffE5AE1A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.whiteColor,
                          size: 13,
                        ),
                      ),
                    if (isNeedArrow == false) const SizedBox(),
                  ],
                ),
      ),
    );
  }
}
