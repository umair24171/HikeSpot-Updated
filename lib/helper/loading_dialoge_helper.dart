import 'package:flutter/material.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/utils/app_colors.dart';

class LoadingDialogeHelper extends StatelessWidget {
  const LoadingDialogeHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: AppColors.transparent,
      backgroundColor: AppColors.transparent,
      clipBehavior: Clip.none,
      shadowColor: AppColors.transparent,
      elevation: 0,
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.bgColor,
                  blurRadius: 10,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: const CircularProgressIndicator(
              color: AppColors.bgColor,
              backgroundColor: AppColors.activtyCont,
            ),
          ),
        ),
      ),
    );
  }
}

showLoadingDialoge(BuildContext context) {
  return DialogHelper.showGeDialog(
      barrierDismissible: false,
      context: context,
      dialog: const LoadingDialogeHelper());
}
