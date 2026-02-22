// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/helper/shared_prefs_helper.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:uuid/uuid.dart';

import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../routes/routes_imports.gr.dart';

abstract class OtpVerifyDataSource {
  Future<Either<String, AuthModel>> verifyOtp(
      String otp, AuthModel authModel, BuildContext context);

  Future<Either<String, String>> resentOtp(BuildContext context);
}

class OtpVerifyDataSourceImpl implements OtpVerifyDataSource {
  OtpVerifyDataSourceImpl();

  @override
  Future<Either<String, AuthModel>> verifyOtp(
      String otp, AuthModel authModel, BuildContext context) async {
    try {
      bool result = EmailOTP.verifyOTP(otp: otp);

      if (result == true) {
        var data = await AppConstants.firestore
            .collection("users")
            .where("email", isEqualTo: authModel.email)
            .get();
        var uid = const Uuid().v4();
        if (data.docs.isNotEmpty) {
          var authData = AuthModel.fromJson(data.docs.first.data());
          if (authData.phoneNumber == authModel.phoneNumber) {
            authModel = authData;
            WarningHelper.showToast(context,
                color: AppColors.greenColor,
                message: "Otp Verified Successfully",
                icon: Icons.verified);
            AutoRouter.of(context).push(VerifiedPageRoute(
                heading: "Phone Number Verified",
                subHeading:
                    "Congratulations 🎊 your phone\nnumber has been successfully verified.",
                user: NewUser.oldUser));
            await SharedPrefsHelper.setData(
                data: jsonEncode(authModel.toJson()), key: AppConstants.userKey);
            return Right(authModel);
          } else {
            WarningHelper.showToast(context,
                message:
                    "Make Sure You Entered The Correct PhoneNumber Which Is Attached To Your Account");
            return const Left("Phone number error");
          }
        } else {
          authModel = authModel.copyWith(uid: uid);
          try {
            // ✅ FIXED: Convert to JSON string and back to ensure proper serialization
            Map<String, dynamic> userData = jsonDecode(jsonEncode(authModel.toJson()));
            
            await AppConstants.firestore
                .collection("users")
                .doc(uid)
                .set(userData);
                
            log("✅️ OTP 🔑 Validate Successfully");
          } catch (e) {
            WarningHelper.showToast(context,
                color: AppColors.redColor,
                message: "Error while storing user data, please try again");
            log("Database error $e");
            return Left("Database error: ${e.toString()}");
          }
          WarningHelper.showToast(context,
              color: AppColors.greenColor,
              message: "Otp Verified Successfully");
          AutoRouter.of(context).push(VerifiedPageRoute(
              heading: "Phone Number Verified",
              subHeading:
                  "Congratulations 🎊 your phone\nnumber has been successfully verified.",
              user: NewUser.newUser));
          await SharedPrefsHelper.setData(
              data: jsonEncode(authModel.toJson()), key: AppConstants.userKey);
          return Right(authModel);
        }
      } else {
        WarningHelper.showToast(context,
            color: AppColors.redColor, message: "Please enter the correct OTP");
        return const Left("Error while verifying OTP");
      }
    } catch (e) {
      WarningHelper.showToast(context,
          color: AppColors.redColor,
          message: "Error while verifying OTP, please try again");
      log("error $e");
      return Left("Error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> resentOtp(BuildContext context) async {
    final TextFieldCubit textFieldCubit = Di().sl<TextFieldCubit>();
    try {
      EmailOTP.config(
        appName: "HikeSpot",
        appEmail: "umairbzu10@gmail.com",
        otpLength: 6,
        expiry: 300000,
        otpType: OTPType.numeric,
      );

      // Configure SMTP
      EmailOTP.setSMTP(
        host: 'smtp.gmail.com',
        emailPort: EmailPort.port587,
        secureType: SecureType.tls,
        username: 'umairbzu10@gmail.com',
        password: 'xeydmdaxgwlwxvsh',
      );
      
      // Set custom template
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
            Thank you for choosing {{appName}}.
          </p>
        </div>
      </div>
      ''',
      );

      var result =
          await EmailOTP.sendOTP(email: textFieldCubit.emailController.text);
      if (result) {
        WarningHelper.showToast(context,
            color: AppColors.greenColor, message: "OTP resent successfully");
        return const Right("Success");
      } else {
        WarningHelper.showToast(context,
            color: AppColors.redColor,
            message: "Error while sending OTP, please try again");
        return const Left("error while sending otp");
      }
    } catch (e) {
      WarningHelper.showToast(context,
          color: AppColors.redColor,
          message: "Error while sending OTP, please try again");
      log("error $e");
      return Left("error ${e.toString()}");
    }
  }
}