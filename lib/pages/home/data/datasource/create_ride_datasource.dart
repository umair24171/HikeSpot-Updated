import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/helper/connectivity_helper.dart';
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
      log('create_ride_datasource error: ${e.toString()}');

      // Only show toast if there's actually no internet connection
      bool hasConnection = await ConnectivityHelper.hasInternetConnection();
      if (!hasConnection) {
        WarningHelper.showToast(context,
            message: "Please check your internet connection and try again");
      } else {
        WarningHelper.showToast(context,
            message: "Failed to create ride. Please try again");
      }

      return const Left("Error");
    }
  }
}
