import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/safety/presentation/widgets/heading_container.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';

@RoutePage()
class GuidePage extends StatelessWidget {
  final bool isRiderTips;
  const GuidePage({super.key, required this.isRiderTips});

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
                      text: "Guide",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.1,
              ),
              const AppTextStyle(
                  text: "How to make every ride safe and comfortable?",
                  fontSize: 27,
                  color: AppColors.whiteColor,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500),
              const SizedBox(
                height: 40,
              ),
              const HeadingContainer(
                heading: "Safety First",
                number: "1",
                text: "Buckle up every time -even on short trips - no matter what seat you're sitting in. Do not distract the driver's attention from the road. Sit in the backseat diagonal to the driver sothey don't need to turn while talking to you.",
              ),
               const SizedBox(
                height: 20,
              ),
              const HeadingContainer(
                heading: "Respect for All",
                number: "2",
                text: "Please, respect your driver, their car, personal space, and privacy. Remember to greet your driver and thank them for the ride or help with your luggage. Little things like this make your mutual experience much better.\nPlease, be mindful and avoid asking personal questions, sharing contact info, and physical contact.",
              ),
               const SizedBox(
                height: 20,
              ),
              const HeadingContainer(
                heading: "Safety First",
                number: "1",
                text: "Buckle up every time -even on short trips - no matter what seat you're sitting in. Do not distract the driver's attention from the road. Sit in the backseat diagonal to the driver sothey don't need to turn while talking to you.",
              ),
              const HeadingContainer(
                heading: "Safety First",
                number: "1",
                text: "Buckle up every time -even on short trips - no matter what seat you're sitting in. Do not distract the driver's attention from the road. Sit in the backseat diagonal to the driver sothey don't need to turn while talking to you.",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
