import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_container.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_setting_container.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
                      text: "Notifications",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.019,
              ),
              const NotificationSettingContainer(),
              const NotificationContainer(
                heading: "Payment Successfully!",
                subHeading: "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                imagePath: AppImages.notificationDiscountIcon,
              ),
              const NotificationContainer(
                heading: "Payment Successfully!",
                subHeading: "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                imagePath: AppImages.paymentSuccessIcon,
              ),
              const NotificationContainer(
                heading: "Payment Successfully!",
                subHeading: "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                imagePath: AppImages.cardAddedIcon,
              ),
              const NotificationContainer(
                heading: "Payment Successfully!",
                subHeading: "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                imagePath: AppImages.walletIcon,
              ),
              Container(
                height: getHeight(context) * 0.13,
                width: getHeight(context) * 0.13,
                decoration: BoxDecoration(
                    color: AppColors.secContainerColor.withOpacity(0.47),
                    shape: BoxShape.circle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.recipetIcon),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const AppTextStyle(
                text: "No notifications at the moment",
                fontSize: 26,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
