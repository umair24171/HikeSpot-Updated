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
          if (authData.phoneNumber == authData.phoneNumber) {
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
                data: jsonEncode(authModel), key: AppConstants.userKey);
            return Right(authModel);
          } else {
            WarningHelper.showToast(context,message: "Make Sure You Entered The Correct PhoneNumber Which Is Atteched To Your Account");
            return const Left("Phone number error");
          }
        } else {
          authModel = authModel.copyWith(uid: uid);
          try {
            await AppConstants.firestore
                .collection("users")
                .doc(uid)
                .set(authModel.toJson());
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
              data: jsonEncode(authModel), key: AppConstants.userKey);
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
        appEmail: "makkiijaz.dev@gmail.com",
        appName: "Hike Spot Taxi",
        otpLength: 6,
        expiry: 600000,
        otpType: OTPType.numeric,
      );
      var result =
          await EmailOTP.sendOTP(email: textFieldCubit.emailController.text);
      if (result) {
        WarningHelper.showToast(context,
            color: AppColors.greenColor, message: "OTP resented successfully");
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
