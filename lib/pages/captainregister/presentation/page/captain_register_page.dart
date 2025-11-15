import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/pages/captainregister/presentation/widgets/captain_location_field.dart';
import 'package:hikespot/pages/captainregister/presentation/widgets/captain_stepper.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/text_field.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/widgets/custom_container.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:hikespot/widgets/phone_text_field.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class CaptainRegisterPage extends StatefulWidget {
  const CaptainRegisterPage({super.key});

  @override
  State<CaptainRegisterPage> createState() => _CaptainRegisterPageState();
}

class _CaptainRegisterPageState extends State<CaptainRegisterPage> {
  @override
  void initState() {
    _fieldCubit.phoneController.text = _authCubit.authData.phoneNumber;
    super.initState();
  }
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
              const SizedBox(
                height: 38,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: "Sign up as ",
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                  CustomContainer(
                    text: "a Captain.",
                    textSize: 27,
                  ),
                ],
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: AppTextStyle(
                    text: "Register in just 5\nminutes",
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  )),
              const SizedBox(
                height: 42,
              ),
              const AppTextStyle(
                text: "Phone Number",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
              const SizedBox(
                height: 10,
              ),
              PhoneTextField(
                fillColor: AppColors.secContainerColor,
                textColor: AppColors.whiteColor,
                phoneController: PhoneController(
                  initialValue: PhoneNumber.findPotentialPhoneNumbers(
                          _authCubit.authData.phoneNumber)
                      .first,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              const CaptainLocationField(),
              const SizedBox(
                height: 22,
              ),
              const ProfileTextField(
                  hintText: "Enter your referral code here",
                  heading: "Referral Code ( Optional )"),
              const SizedBox(
                height: 45,
              ),
              BlocBuilder(
                bloc: _createCaptainRegisterCubit,
                builder: (context, state) {
                  return BlocBuilder(
                    bloc: _fieldCubit,
                    builder: (context, state) {
                      return GestureContainer(
                        text: "Next",
                        isValidate:
                            _fieldCubit.phoneController.text.isNotEmpty &&
                                _createCaptainRegisterCubit.placemark != null,
                        onTap: () {
                          if (_fieldCubit.phoneController.text.isEmpty) {
                            WarningHelper.showToast(context,
                                message: "Please enter your phone number");
                            return;
                          } else if (_createCaptainRegisterCubit.placemark ==
                              null) {
                            WarningHelper.showToast(context,
                                message: "Please choose your location");
                            return;
                          }
                          _captainStepperCubit.nextStep(1);
                          _fieldCubit.emailController.text =
                              _authCubit.authData.email;
                          _createCaptainRegisterCubit.sendOtp(context);
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
final TextFieldCubit _fieldCubit = Di().sl<TextFieldCubit>();
final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
