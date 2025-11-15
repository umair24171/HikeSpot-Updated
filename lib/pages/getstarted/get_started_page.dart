import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';

@RoutePage()
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        width: getWidth(context),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.getStartedImg),fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight:  Radius.circular(32),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                child: Container(
                  height: 215,
                  width: getWidth(context),
                  padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                  decoration:   BoxDecoration(
                    color:  const Color(0xffCBCCD4).withOpacity(0.17),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight:  Radius.circular(32),
                    ),
                  ),
                  child:   Column(
                    children: [
                      const AppTextStyle(text: "Move with Safety", fontSize: 30, fontWeight: FontWeight.w700,color: AppColors.whiteColor,),
                      const AppTextStyle(text: "Moving Minds, Move You", fontSize: 18, fontWeight: FontWeight.w300,color: AppColors.whiteColor),
                      const SizedBox(
                        height: 38,
                      ),
                      GestureContainer(
                        text: "Get Started",
                        isValidate: true,
                        onTap: () {
                          AutoRouter.of(context).push(const OnBoardingPageRoute());
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
