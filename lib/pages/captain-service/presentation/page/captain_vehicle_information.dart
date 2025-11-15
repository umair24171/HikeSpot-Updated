import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/text_field.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import '../../../captainregister/presentation/widgets/captain_stepper.dart';

@RoutePage()
class CaptainVehicleInfoPage extends StatelessWidget {
  const CaptainVehicleInfoPage({super.key});

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
                      _captainStepperCubit.nextStep(2);
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
                height: getHeight(context) * 0.038,
              ),
              const AppTextStyle(
                text: "Vehicle Information",
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              const AppTextStyle(
                text:
                    "Please add all necessary details about your vehicle that showing below.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: getHeight(context) * 0.032,
              ),
              ProfileTextField(
                  hintText: "Enter your car model name",
                  controller: _fieldCubit.carModelController,
                  heading: "Car Model Name"),
              SizedBox(
                height: getHeight(context) * 0.016,
              ),
              ProfileTextField(
                  hintText: "Enter your car number plate",
                  controller: _fieldCubit.carNumberController,
                  heading: "Car Number Plate"),
              SizedBox(
                height: getHeight(context) * 0.2,
              ),
              BlocBuilder(
                bloc: _fieldCubit,
                builder: (context, state) {
                  return GestureContainer(
                    text: "Next",
                    isValidate:
                        _fieldCubit.carModelController.text.isNotEmpty &&
                            _fieldCubit.carNumberController.text.isNotEmpty,
                    onTap: () {
                      if (_fieldCubit.carModelController.text.isEmpty ||
                          _fieldCubit.carNumberController.text.isEmpty) {
                        WarningHelper.showToast(context,
                            message: "Please fill all fields",
                            color: AppColors.redColor);
                        return;
                      }
                      _captainStepperCubit.nextStep(3);
                      AutoRouter.of(context)
                          .push(const CaptainUploadDocPageRoute());
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

final CaptainStepperCubit _captainStepperCubit = Di().sl<CaptainStepperCubit>();
final TextFieldCubit _fieldCubit = Di().sl<TextFieldCubit>();
