import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:hikespot/data/models/auth-model/auth_model.dart';

import '../repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<String, AuthModel>> getSelfInfo(BuildContext context) async {
    return await _authRepository.getSelfInfo(context);
  }

  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context,
      {required AuthModel authModel}) async {
    return await _authRepository.updateUserInfo(context, authModel: authModel);
  }
}
