import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/onboarding/presentation/items/rides_comp.dart';
import 'package:hikespot/pages/onboarding/presentation/items/saftey_comp.dart';
import 'package:hikespot/pages/onboarding/presentation/items/smooth_comp.dart';
import 'package:hikespot/pages/onboarding/presentation/items/time_comp.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

Color colorData1 = AppColors.primaryDark;
Color colorData2 = AppColors.primaryDark;
Color colorData3 = AppColors.primaryDark;
int index = 0;

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Builder(builder: (context) {
        return LiquidSwipe(
          waveType: WaveType.liquidReveal,
          slideIconWidget: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.whiteColor,
          ),

          // Container(
          //   height: 60,
          //   width: 60,
          //   padding: EdgeInsets.all(10),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryDark,
          //     shape: BoxShape.circle,
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.primaryDark.withOpacity(0.25),
          //         spreadRadius: 3.62,
          //         blurRadius: 3.62,
          //       )
          //     ],
          //   ),
          //   child: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.whiteColor,
          //     size: 34,
          //   ),
          // ),
          // positionSlideIcon: 0.8,
          // // fullTransitionValue: 880,
          onPageChangeCallback: (activePageIndex) {
            if (activePageIndex == 0) {
              setState(() {
                colorData1 = AppColors.primaryDark;
              });
            } else if (activePageIndex == 1) {
              setState(() {
                colorData2 = AppColors.primaryDark;
              });
            } else if (activePageIndex == 2) {
              setState(() {
                colorData3 = AppColors.primaryDark;
              });
            }else if(activePageIndex == 3){
              AutoRouter.of(context).push(const LoginPageRoute());
            }
          },
          slidePercentCallback: (slidePercentHorizontal, slidePercentVertical) {
            if (slidePercentHorizontal > 40.0) {
              setState(() {
                colorData1 = AppColors.whiteColor;
                colorData2 = AppColors.whiteColor;
                colorData3 = AppColors.whiteColor;
              });
            }
          },
          enableSideReveal: true,
          preferDragFromRevealedArea: true,
          enableLoop: false,
          ignoreUserGestureWhileAnimating: true,
          pages: [
            const SafetyComp(),
            TimeComp(
              color: colorData1,
            ),
            RidesComp(color: colorData2),
            SmoothComp(color: colorData3)
          ],
        );
      }),
    );
  }
}

final LiquidController controller = LiquidController();
