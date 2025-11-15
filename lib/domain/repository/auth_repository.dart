import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../data/models/auth-model/auth_model.dart';

abstract class AuthRepository {
  Future<Either<String, AuthModel>> getSelfInfo(BuildContext context);
    Future<Either<String, AuthModel>> updateUserInfo(BuildContext context,
      {required AuthModel authModel});
}