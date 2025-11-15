import 'package:dartz/dartz.dart';

import '../../data/model/accept-ride/accept_ride_model.dart';

abstract class DriverAcceptRideRepository {
  Future<Either<Exception, String>> driverAcceptRide(
    String rideId,
    AcceptRideModel acceptRideModel,
  );
}