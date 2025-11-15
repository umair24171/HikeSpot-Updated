import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/otp/domain/repository/otp_verify_repository.dart';

import '../datasource/otp_verify_datasource.dart';

class OtpVerifyRepositoryImp extends OtpVerifyRepository {
  final OtpVerifyDataSource otpVerifyDataSource;

  OtpVerifyRepositoryImp(this.otpVerifyDataSource);
  @override
  Future<Either<String, AuthModel>> verifyOtp(String otp, AuthModel authModel,BuildContext context) {
    return otpVerifyDataSource.verifyOtp(otp, authModel,context);
  }
  
  @override
  Future<Either<String, String>> resentOtp(BuildContext context) {
    return otpVerifyDataSource.resentOtp(context);
  }
}
