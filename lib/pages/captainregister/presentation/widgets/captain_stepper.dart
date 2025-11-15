import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/captain-service/presentation/page/captain_service_page.dart';
import 'package:hikespot/pages/captain-service/presentation/page/captain_upload_doc_page.dart';
import 'package:hikespot/pages/captain-service/presentation/page/captain_vehicle_information.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import 'package:hikespot/pages/captainregister/presentation/page/captain_register_page.dart';
import 'package:hikespot/pages/otp/presentation/page/otp_page.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';

class CaptainStepper extends StatelessWidget {
  const CaptainStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _captainStepperCubit,
      builder: (context, state) {
        return FlutterStepIndicator(
          height: 20,
          division: 1,
          list: const [
            CaptainRegisterPage(),
            OtpPage(state: AppState.captain),
            CaptainServicePage(),
            CaptainVehicleInfoPage(),
            CaptainUploadDocPage(),
          ],
          onChange: (int index) {
            if (index != _captainStepperCubit.currentStep) {
              log('onChange $index');

              _captainStepperCubit.nextStep(index);
            }
          },
          page: _captainStepperCubit.currentStep,
          positiveColor: AppColors.primaryDark,
          negativeColor: AppColors.whiteColor,
          padding: const EdgeInsets.all(1),
          paddingLine: const EdgeInsets.all(1.2),
          progressColor: AppColors.whiteColor,
          durationScroller: const Duration(milliseconds: 400),
          durationCheckBulb: const Duration(milliseconds: 400),
        );
      },
    );
  }
}

final CaptainStepperCubit _captainStepperCubit = Di().sl<CaptainStepperCubit>();
