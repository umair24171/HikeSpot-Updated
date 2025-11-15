import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hikespot/utils/app_colors.dart';

class Styles {

  // text fields decoration
  static  OutlineInputBorder  textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: AppColors.primaryGreyColor,width: 1)
  );

  /// text styling
  static TextStyle textStyle = GoogleFonts.lexend(
    fontSize:16,
    color:AppColors.blackColor,
    fontWeight:FontWeight.w400,
  );
}