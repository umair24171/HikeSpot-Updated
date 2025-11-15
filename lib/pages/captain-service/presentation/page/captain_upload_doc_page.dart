import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/pages/captain-service/presentation/widgets/upload_doc_container.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/widgets/confirm_dialoge.dart';
import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/warning_helper.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../captainregister/presentation/widgets/captain_stepper.dart';

@RoutePage()
class CaptainUploadDocPage extends StatelessWidget {
  const CaptainUploadDocPage({super.key});

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
                      _captainStepperCubit.nextStep(3);
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
                text: "Upload Documents",
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              const AppTextStyle(
                text:
                    "Please add and upload all necessary documents that showing below.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: getHeight(context) * 0.034,
              ),
              BlocBuilder(
                bloc: _fieldCubit,
                builder: (context, state) {
                  return UploadDocConatiner(
                    heading: "Profile Picture and Basic Info",
                    subHeading: "Upload document",
                    icon: _fieldCubit.firstNameController.text.isNotEmpty ||
                            _fieldCubit.lastNameController.text.isNotEmpty
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward_ios,
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const CaptainUploadProfilePageRoute());
                    },
                  );
                },
              ),
              SizedBox(
                height: getHeight(context) * 0.016,
              ),
              BlocBuilder(
                bloc: _createCaptainRegisterCubit,
                builder: (context, state) {
                  return UploadDocConatiner(
                    heading: "Vehicle Registration ",
                    subHeading: "Upload document",
                    icon: _createCaptainRegisterCubit
                                .carRegistrationBack.isNotEmpty &&
                            _createCaptainRegisterCubit
                                .carRegistrationFront.isNotEmpty
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward_ios,
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const CaptainVehicleUploadDocPageRoute());
                    },
                  );
                },
              ),
              SizedBox(
                height: getHeight(context) * 0.016,
              ),
              BlocBuilder(
                bloc: _createCaptainRegisterCubit,
                builder: (context, state) {
                  return UploadDocConatiner(
                    heading: "Driving License",
                    subHeading: "Upload document",
                    icon: _createCaptainRegisterCubit.drivingLicence.isNotEmpty
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward_ios,
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const CaptainUploadLicencePageRoute());
                    },
                  );
                },
              ),
              SizedBox(
                height: getHeight(context) * 0.2,
              ),
              BlocBuilder(
                bloc: _fieldCubit,
                builder: (context, state) {
                  return BlocBuilder(
                    bloc: _createCaptainRegisterCubit,
                    builder: (context, state) {
                      return GestureContainer(
                        text: "Next",
                        isValidate: _fieldCubit
                                .firstNameController.text.isNotEmpty &&
                            _fieldCubit.lastNameController.text.isNotEmpty &&
                            _createCaptainRegisterCubit
                                .carRegistrationBack.isNotEmpty &&
                            _createCaptainRegisterCubit
                                .carRegistrationFront.isNotEmpty &&
                            _createCaptainRegisterCubit
                                .drivingLicence.isNotEmpty,
                        textColor: AppColors.blackColor,
                        onTap: () {
                          if (_fieldCubit.firstNameController.text.isEmpty) {
                            WarningHelper.showToast(context,
                                message: "Please enter your first name");
                            return;
                          } else if (_fieldCubit
                              .lastNameController.text.isEmpty) {
                            WarningHelper.showToast(context,
                                message: "Please enter your last name");
                            return;
                          } else if (_createCaptainRegisterCubit
                              .carRegistrationBack.isEmpty) {
                            WarningHelper.showToast(context,
                                message:
                                    "Please upload the back side of your vehicle registration document");
                            return;
                          } else if (_createCaptainRegisterCubit
                              .carRegistrationFront.isEmpty) {
                            WarningHelper.showToast(context,
                                message:
                                    "Please upload the front side of your vehicle registration document");
                            return;
                          } else if (_createCaptainRegisterCubit
                              .drivingLicence.isEmpty) {
                            WarningHelper.showToast(context,
                                message: "Please upload your driving license");
                            return;
                          } else {
                            DialogHelper.showGeDialog(
                                context: context,
                                dialog: ConfirmDialoge(
                                    onTap: () {
                                      _captainStepperCubit.nextStep(4);
                                      AutoRouter.of(context).push(
                                          const CaptainGetStartedPageRoute());
                                    },
                                    heading:
                                        "Driving License\nSuccessfully Verified",
                                    subHeading:
                                        "Your driving license successfully verified.\nNow please upload the other documents.",
                                    buttonText: "GO to Become a Captain"));
                          }
                        },
                      );
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
final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
final TextFieldCubit _fieldCubit = Di().sl<TextFieldCubit>();
