import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/login/presentation/bloc/cubit/login_create_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/custom_text_field.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:hikespot/widgets/phone_text_field.dart';
import 'package:hikespot/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
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
                const AppTextStyle(
                    text: "Join us via phone number",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                const AppTextStyle(
                  text: "We’ll text a code to verify your \nphone number.",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getWidth(context) * 0.2,
                ),
                const PhoneTextField(),
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                CustomTextField(
                  text: 'Email',
                  controller: _phoneTextFieldCubit.emailController,
                  icon: AppImages.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                ),
                const Spacer(),
                const AgreementText(),
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                BlocBuilder(
                  bloc: _phoneTextFieldCubit,
                  builder: (context, state) {
                    return BlocBuilder(
                      bloc: _loginCreateCubit,
                      builder: (context, state) {
                        log(state.toString());
                        return GestureContainer(
                          text: "Next",
                          isLoading: state is LoginCreateLoading,
                          isValidate: _phoneTextFieldCubit.checkField(),
                          onTap: () {
                            _loginCreateCubit.loginCreate(context);
                          },
                        );
                      },
                    );
                  },
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

final LoginCreateCubit _loginCreateCubit = Di().sl<LoginCreateCubit>();
final TextFieldCubit _phoneTextFieldCubit = Di().sl<TextFieldCubit>();
