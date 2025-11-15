import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/otp/domain/repository/otp_verify_repository.dart';

class OtpVerifyUseCase {
  final OtpVerifyRepository _otpRepository;

  OtpVerifyUseCase(this._otpRepository);

  Future<Either<String, AuthModel>> execute(
      String otp, AuthModel authModel, BuildContext context) async {
    return await _otpRepository.verifyOtp(otp, authModel, context);
  }

  Future<Either<String, String>> resentOtp(BuildContext context) {
    return _otpRepository.resentOtp(context);
  }
}
