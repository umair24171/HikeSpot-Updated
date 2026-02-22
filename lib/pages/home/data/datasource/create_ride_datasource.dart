import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/helper/shared_prefs_helper.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';

import '../../../../helper/warning_helper.dart';

abstract class CreateRideDatasource {
  Future<Either<String, RideDataModel>> createRide(BuildContext context,
      {required RideDataModel rideModel});
}

class CreateRideDatasourceImpl implements CreateRideDatasource {
  CreateRideDatasourceImpl();

  @override
  Future<Either<String, RideDataModel>> createRide(BuildContext context,
      {required RideDataModel rideModel}) async {
    try {
      await AppConstants.firestore
          .collection(AppConstants.ridesKey)
          .doc(rideModel.rideId)
          .set(rideModel.toJson());
      SharedPrefsHelper.setData(
          data: rideModel.rideId, key: AppConstants.ridesKey);
      return Right(rideModel);
    } catch (e) {
      log('create-ride-error: ${e.toString()}');
      // ✅ Return descriptive error instead of showing toast
      return Left('Failed to create ride: ${e.toString()}');
    }
  }
}
