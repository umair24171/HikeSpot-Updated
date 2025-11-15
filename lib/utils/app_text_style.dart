import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;
  const AppTextStyle(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        this.color = AppColors.blackColor,
        this.textAlign,
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.lexend(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,),
    );
  }
}

