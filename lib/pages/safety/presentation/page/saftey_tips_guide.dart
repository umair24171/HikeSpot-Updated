import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/profile/presentation/widgets/setting_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';

@RoutePage()
class SafteyGuideTipsPage extends StatelessWidget {
  const SafteyGuideTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: AppColors.primaryDark.withOpacity(0.37),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.whiteColor),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const AppTextStyle(
                      text: "Safety Tips and Guide",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.1,
              ),
              RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(children: [
                TextSpan(
                    text: "Safety Rules and Guidelines \nto ",
                    style: Styles.textStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor)),
                TextSpan(
                    text: " Keep Secure Everyone",
                    style: Styles.textStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark))
              ])),
              SizedBox(
                height: getHeight(context) * 0.041,
              ),
               SettingContainer(containerText: "How to make every ride safe and \ncomfortable?",
              onTap: () {
                AutoRouter.of(context).push(GuidePageRoute(isRiderTips: true));
              },
               icon: "",isNeedPrefixIcon: false,),
              const SizedBox(
                height: 10,
              ),
              const SettingContainer(containerText: "Tips for riders", icon: "",isNeedPrefixIcon: false,),
            ],
          ),
        ),
      )),
    );
  }
}
