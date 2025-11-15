import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/blocs/cubits/deep_link_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/profile/presentation/widgets/setting_container.dart';
import 'package:hikespot/utils/images_paths.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';

@RoutePage()
class ReferPage extends StatelessWidget {
  const ReferPage({super.key});

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
                      text: "Refer",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.08,
              ),
              const AppTextStyle(
                text: "Invite your friends",
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
              const SizedBox(
                height: 8,
              ),
              const AppTextStyle(
                text:
                    "Share the code below or ask them to enter itduring the signup. Utilize the app features when your friend signs up on our app.",
                fontSize: 14,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: getHeight(context) * 0.1,
              ),
              Image.asset(
                AppImages.referImage,
                height: 144,
                width: 283,
              ),
              SizedBox(
                height: getHeight(context) * 0.2,
              ),
              SettingContainer(
                containerText: "How referral works?",
                icon: "",
                isNeedIcon: false,
                isNeedPrefixIcon: false,
                suffixIxon: SvgPicture.asset(AppImages.iconDown),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              DottedBorder(
                color: AppColors.primaryDark,
                radius: const Radius.circular(12),
                borderType: BorderType.RRect,
                dashPattern: const [6],
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      AppTextStyle(
                        text: _authCubit.authData.referCode,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _deepLinkCubit.buildLink();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.copyIcon),
                            const AppTextStyle(
                              text: "Copy Code",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final DeepLinkCubit _deepLinkCubit = Di().sl<DeepLinkCubit>();
