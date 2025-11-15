import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/screen_sizes.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class WarningHelper {
  static void showToast(BuildContext context,
      {String? message, 
       Color color = AppColors.primaryDark,
       IconData icon = Icons.error_outline,
       Color iconColor = AppColors.blackColor}) {
    
    // 🔥 FIX: Calculate width BEFORE the builder
    final double screenWidth = getWidth(context);
    
    AnimatedSnackBar(
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
      snackBarStrategy: StackSnackBarStrategy(),
      animationDuration: const Duration(seconds: 1),
      animationCurve: Curves.easeIn,
      builder: ((context) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: screenWidth, // 🔥 Use the pre-calculated width
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 18,
                color: iconColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: AppTextStyle(
                  text: message ?? "Error while doing action",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        );
      }),
    ).show(context);
  }
}