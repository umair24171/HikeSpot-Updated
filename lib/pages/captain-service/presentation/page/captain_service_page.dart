import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/captain-service/presentation/widgets/service_container.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';
import '../../../captainregister/presentation/widgets/captain_stepper.dart';

@RoutePage()
class CaptainServicePage extends StatelessWidget {
  const CaptainServicePage({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _captainStepperCubit.nextStep(1);
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
                height: getHeight(context) * 0.05,
              ),
              const AppTextStyle(
                text: "Select Service",
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              const AppTextStyle(
                text:
                    "How would you like to partner with HikeSpot o earn money?",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: getHeight(context) * 0.05,
              ),
              const ServiceContainer(
                image: AppImages.carImageService,
                serviceName: "Car Rides",
                service: CaptainService.CARRIDES,
                serviceDescription: "Car",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.bikeTypeIcon,
                serviceName: "Bike Rides",
                service: CaptainService.BIKERIDES,
                serviceDescription: "Bike",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.suvIcon,
                serviceName: "SUV Rides",
                service: CaptainService.SUVRIDES,
                serviceDescription: "Suv",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.truckImage,
                serviceName: "Heavy Duty \nTrack Rides",
                service: CaptainService.HEAVYDUITYTRACKRIDES,
                serviceDescription: "Track",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.rickshawIcon,
                serviceName: "Tuk Tuk Rides",
                service: CaptainService.TUKTUKRIDES,
                serviceDescription: "Tuk Tuk",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.suvIcon,
                serviceName: "Utility",
                service: CaptainService.UTILITYRIDES,
                serviceDescription: "Suv",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.doubleCab,
                serviceName: "Double Cabs Rides",
                service: CaptainService.DOUBLECABRIDES,
                serviceDescription: "Cabs",
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const ServiceContainer(
                image: AppImages.taxiImage,
                serviceName: "Taxi Rides",
                service: CaptainService.TAXIRIDES,
                serviceDescription: "Taxi",
              ),
              SizedBox(
                height: getHeight(context) * 0.08,
              ),
            ],
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureContainer(
          text: "Next",
          isValidate: true,
          textColor: AppColors.blackColor,
          onTap: () {
            if (_createCaptainRegisterCubit.carService == null) {
              WarningHelper.showToast(context,
                  message: "Please select a service",
                  color: AppColors.redColor);
              return;
            }
            _captainStepperCubit.nextStep(2);
            AutoRouter.of(context).push(const CaptainVehicleInfoPageRoute());
          },
        ),
      ),
    );
  }
}

final CaptainStepperCubit _captainStepperCubit = Di().sl<CaptainStepperCubit>();
final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
