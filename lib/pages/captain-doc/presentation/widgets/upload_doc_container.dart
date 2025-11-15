import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

class UploadRegistrationDocContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Function()? onTap;
  final File? file;
  const UploadRegistrationDocContainer(
      {super.key,
      this.height,
      this.width,
      required this.text,
      this.onTap,
      this.file});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height ?? 248,
          width: width ?? getWidth(context) * 0.4,
          decoration: BoxDecoration(
            color: AppColors.primaryGreyColor.withOpacity(0.17),
            borderRadius: BorderRadius.circular(17),
          ),
          child: file != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.file(file ?? File(""),fit: BoxFit.cover,))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      SvgPicture.asset(
                        AppImages.uploadIcon,
                        height: 18,
                        width: 18,
                        color: AppColors.primaryDark,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppTextStyle(
                          text: text,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDark,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ])),
    );
  }
}
