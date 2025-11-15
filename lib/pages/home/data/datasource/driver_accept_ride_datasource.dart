import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';

abstract class DriverAcceptRideDatasource {
  Future<Either<Exception, String>> driverAcceptRide(
    String rideId,
    AcceptRideModel acceptRideModel,
  );
}

class DriverAcceptRideDatasourceImpl extends DriverAcceptRideDatasource {
  @override
  Future<Either<Exception, String>> driverAcceptRide(
      String rideId, AcceptRideModel acceptRideModel) async {
    try {
      log("id iss ${rideId}");
      await AppConstants.firestore
          .collection(AppConstants.ridesKey)
          .doc(rideId)
          .collection(AppConstants.ridesRequest)
          .doc(acceptRideModel.driverData.uid)
          .set({
            "driverData":acceptRideModel.driverData.toJson(),
            "isAccepted": acceptRideModel.isAccepted,
            "isRejected": acceptRideModel.isRejected,
            "distance":acceptRideModel.distance,
            "duration": acceptRideModel.duration,
            "rideId": acceptRideModel.rideId,
            "fare":acceptRideModel.fare,
          });
          log("Ride Request Sented Successfully");
      return right('Ride Request Sented Successfully');
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }
}
