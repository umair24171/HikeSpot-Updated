import 'package:dartz/dartz.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
// import 'package:hikespot/app/constants/links.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/helper/text_validator.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/warning_helper.dart';

abstract class LoginCreateDataSource {
  Future<Either<String, String>> create(context);
}

class LoginCreateDataSourceImpl implements LoginCreateDataSource {
  LoginCreateDataSourceImpl();

  // <div style="text-align: center;">
  //   <img src=${AppLinks.appLogoUrl} alt="Logo" style="width: 150px; margin-bottom: 20px;"/>
  // </div>

  @override
  Future<Either<String, String>> create(context) async {
    final TextFieldCubit textFieldCubit = Di().sl<TextFieldCubit>();
    try {
      debugPrint("email ${textFieldCubit.emailController.text}");
      if (!StringValidator.isEmail(textFieldCubit.emailController.text)) {
        WarningHelper.showToast(context,
            message: 'Please enter a valid email address');
        return const Left("error while validation email");
      } else {
        debugPrint('email ${textFieldCubit.emailController.text}');
        EmailOTP.setTemplate(
          template: '''
  <div style="background-color: #f9f9f9; padding: 40px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;">
    <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
     
      <h2 style="color: #2c3e50; font-size: 24px; margin-bottom: 20px;">Welcome to {{appName}}!</h2>
      <p style="color: #7f8c8d; font-size: 16px; line-height: 1.6;">
        We're excited to have you on board. To complete your sign-up, please use the following OTP:
      </p>
      <p style="color: #e74c3c; font-size: 28px; font-weight: bold; margin: 20px 0;"><strong>{{otp}}</strong></p>
      <p style="color: #7f8c8d; font-size: 16px; line-height: 1.6;">
        This OTP is valid for the next 4 minutes. Please enter it on the verification screen to continue.
      </p>
      <p style="color: #7f8c8d; font-size: 16px; line-height: 1.6;">
        If you did not request this OTP, please disregard this email. Your account is safe.
      </p>
      <hr style="border: 0; border-top: 1px solid #ecf0f1; margin: 30px 0;">
      <p style="color: #95a5a6; font-size: 14px; text-align: center;">
        Thank you for choosing {{appName}}.<br>
        Need help? <a href="{{supportUrl}}" style="color: #3498db; text-decoration: none;">Contact Support</a>
      </p>
    </div>
  </div>
  ''',
        );

        EmailOTP.config(
          appEmail: "makkiijaz.dev@gmail.com",
          appName: "Hike Spot Taxi",
          otpLength: 6,
          expiry: 300000,
          otpType: OTPType.numeric,
        );
        var result =
            await EmailOTP.sendOTP(email: textFieldCubit.emailController.text);
        if (result) {
          return const Right("Success");
        } else {
          return const Left("error while sending otp");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      return Left("error ${e.toString()}");
    }
  }
}
