import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/editprofile/domain/respository/editing_profile_repository.dart';
import '../datasource/editing_profile_datasource.dart';

class EditingProfileRepositoryImpl implements EditingProfileRepository {
  final EditingProfileDataSource editingProfileDataSource;

  EditingProfileRepositoryImpl(this.editingProfileDataSource);
  @override
  Future<Either<String, String>> updateProfile(BuildContext context) {
   return editingProfileDataSource.updateProfile(context);
  }
}
