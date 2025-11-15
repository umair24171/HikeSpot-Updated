import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/otp/presentation/widgets/otp_field.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/widgets/outline_button.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../../widgets/widgets.dart';
import '../../../captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import '../bloc/cubit/otp_verify_cubit.dart';

@RoutePage()
class OtpPage extends StatelessWidget {
  final AppState state;
  const OtpPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state == AppState.captain
            ? AppColors.bgColor
            : AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getWidth(context) * 0.02,
                ),
                if (state == AppState.user) AppWidgets.appLogo,
                if (state == AppState.captain)
                  const AppTextStyle(
                    text: "Enter OTP",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                AppTextStyle(
                    text: state == AppState.user
                        ? "Authentication Code"
                        : "OTP Code",
                    fontSize: 24,
                    color: state == AppState.user
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                    fontWeight: FontWeight.w700),
                AppTextStyle(
                  text: "Enter 6-digit code we just texted \nto your email,",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: state == AppState.user
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                  textAlign: TextAlign.center,
                ),
                AppTextStyle(
                  text: " ${_fieldCubit.emailController.text}",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getWidth(context) * 0.15,
                ),
                OtpField(
                  state: state,
                  controller: _fieldCubit.otpController,
                ),
                SizedBox(
                  height: getWidth(context) * 0.02,
                ),
                if (state == AppState.user)
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).replace(const LoginPageRoute());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        AppTextStyle(
                          text: "Use Different Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                      ],
                    ),
                  ),
                const Spacer(),
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                GestureContainer(
                  text: "Verify Account",
                  isValidate: true,
                  onTap: () {
                    if (state == AppState.user) {
                      _otpVerifyCubit.otpVerify(AppState.user, context);
                    } else {
                      _createCaptainRegisterCubit.verifyOtp(context);
                    }
                  },
                ),
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                CustomOutlineButton(
                  text: "Resent Code",
                  onTap: () => _otpVerifyCubit.resentOtp(context),
                ),
                SizedBox(
                  height: getWidth(context) * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final TextFieldCubit _fieldCubit = Di().sl<TextFieldCubit>();
final OtpVerifyCubit _otpVerifyCubit = Di().sl<OtpVerifyCubit>();
final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
