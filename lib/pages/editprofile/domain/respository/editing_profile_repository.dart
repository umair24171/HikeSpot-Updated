import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class EditingProfileRepository {
  Future<Either<String, String>> updateProfile(BuildContext context);
}
