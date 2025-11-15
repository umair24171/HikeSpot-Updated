import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/auth-model/auth_model.dart';

abstract class OtpVerifyRepository {
  Future<Either<String, AuthModel>> verifyOtp(String otp, AuthModel authModel,BuildContext context);
    Future<Either<String, String>> resentOtp(BuildContext context);
}