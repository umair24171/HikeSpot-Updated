import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../datsource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(  this.authDataSource);

  @override
  Future<Either<String, AuthModel>> getSelfInfo(BuildContext context) {
    return authDataSource.getSelfInfo(context);
  }
  
  @override
  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context, {required AuthModel authModel}) {
    return authDataSource.updateUserInfo(context, authModel: authModel);
  }
 
}