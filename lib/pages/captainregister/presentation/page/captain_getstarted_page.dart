import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../widgets/gesture_container.dart';
import '../widgets/captain_stepper.dart';

@RoutePage()
class CaptainGetStartedPage extends StatelessWidget {
  const CaptainGetStartedPage({super.key});

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
                      text: "Become a Captain",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              const CaptainStepper(),
              SizedBox(
                height: getHeight(context) * 0.028,
              ),
              const AppTextStyle(
                text:
                    "Congratulations 🎊 for\nBecoming a Captain with\nHikeSpot ",
                fontSize: 20,
                textAlign: TextAlign.center,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: getHeight(context) * 0.076,
              ),
              Image.asset(AppImages.captainCarImage),
              SizedBox(
                height: getHeight(context) * 0.076,
              ),
              const AppTextStyle(
                text:
                    "HikeSpot team hope that you will enjoy\nyour journey to offer HikeSpot Services.",
                fontSize: 15,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context) * 0.094,
              ),
              BlocBuilder(
                bloc: _createCaptainRegisterCubit,
                builder: (context, state) {
                  return GestureContainer(
                    text: "Get Started",
                    isLoading: _createCaptainRegisterCubit.isCreateCaptain,
                    isValidate: true,
                    textColor: AppColors.blackColor,
                    onTap: () {
                      _createCaptainRegisterCubit.createCaptain(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
