import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/editprofile/domain/respository/editing_profile_repository.dart';

class EditingProfileUsecase{
  final EditingProfileRepository _profileRepository;

  EditingProfileUsecase(this._profileRepository);

  Future<Either<String, String>> execute(BuildContext context) async {
    return await _profileRepository.updateProfile(context);
  }
}