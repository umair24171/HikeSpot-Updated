import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/pages/profile/presentation/widgets/setting_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/images_paths.dart';
import '../../../../utils/sizes.dart';

@RoutePage()
class SafetyPage extends StatelessWidget {
  const SafetyPage({super.key});

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
                      text: "Safety",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.1,
              ),
              Container(
                height: getHeight(context) * 0.13,
                width: getHeight(context) * 0.13,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColors.secContainerColor.withOpacity(0.47),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  AppImages.securityIcon,
                  height: 78,
                  width: 66,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const AppTextStyle(
                text: "Who do you want to contact?",
                fontSize: 26,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: AppColors.whiteColor,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingContainer(
                containerText: "Ambulance",
                icon: "",
                isNeedIcon: false,
                onTap: () {},
                suffixIxon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.customColor(0xffDDDDDD),
                        blurRadius: 10,
                      )
                    ],
                    shape: BoxShape.circle,
                    color: AppColors.customColor(0xffDDDDDD),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.callIcon),
                    ],
                  ),
                ),
                isNeedPrefixIcon: false,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingContainer(
                containerText: "Police",
                icon: "",
                suffixIxon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.customColor(0xffDDDDDD),
                        blurRadius: 10,
                      )
                    ],
                    shape: BoxShape.circle,
                    color: AppColors.customColor(0xffDDDDDD),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.callIcon),
                    ],
                  ),
                ),
                isNeedIcon: false,
                isNeedPrefixIcon: false,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingContainer(
                  containerText: "Safety tips and guide",
                  onTap: () {
                    AutoRouter.of(context)
                        .push(const SafteyGuideTipsPageRoute());
                  },
                  icon: AppImages.securityIcon),
            ],
          ),
        ),
      )),
    );
  }
}
