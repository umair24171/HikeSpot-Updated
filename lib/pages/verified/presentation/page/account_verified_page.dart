import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/enums.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/images_paths.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../../widgets/widgets.dart';

@RoutePage()
class VerifiedPage extends StatelessWidget {
  final NewUser user;
  final String heading;
  final String subHeading;
  final Function()? onTap;
  final  bool needButton;
  const VerifiedPage(
      {super.key,
      required this.user,
      required this.heading,
      this.needButton = true,
      required this.subHeading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getWidth(context) * 0.02,
                ),
                AppWidgets.appLogo,
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                AppTextStyle(
                    text: heading, fontSize: 24, fontWeight: FontWeight.w700),
                AppTextStyle(
                  text: subHeading,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context) * 0.2,
                ),
                Image.asset(
                  AppImages.verified,
                  height: 305,
                  width: 213,
                ),
                // const Spacer(),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                if(needButton == true)
                GestureContainer(
                  text: "Get Start",
                  onTap: onTap ?? () {
                    if (user == NewUser.newUser) {
                      AutoRouter.of(context).push(const UploadProfilePageRoute());
                    } else {
                      AutoRouter.of(context).push(const DashBoardPageRoute());
                    }
                  },
                ),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
