import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';

InkWell buildInkWell({required BuildContext context,required Function() onTap,required Widget child}) {
  return InkWell(
    splashColor: AppColors.transparent,
    splashFactory: NoSplash.splashFactory,
    overlayColor: MaterialStateProperty.all(AppColors.transparent),
    onTap: onTap,
    child: child
  );
}