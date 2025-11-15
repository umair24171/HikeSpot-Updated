import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/images_paths.dart';
import '../../../../widgets/gesture_container.dart';

class NoCardContainer extends StatelessWidget {
  const NoCardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 181,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.dialogeColor, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryGreyColor.withOpacity(0.34)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 34,
                width: 42,
                decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.37),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.cardIcon),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const AppTextStyle(
                text: "No Cards Added",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark,
              ),
            ],
          ),
          const AppTextStyle(
            text: "Add card to enjoy a seamless \npayment experience",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 25,
          ),
            GestureContainer(
            text: "Add a Card",
            borderRadius: 100,
            onTap: () {
              AutoRouter.of(context).push(const AddCardPageRoute());
            },
            isNeedArrow: false,
            isValidate: true,
          )
        ],
      ),
    );
  }
}
