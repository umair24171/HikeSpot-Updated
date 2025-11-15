import 'package:dartz/dartz.dart';
import 'package:hikespot/pages/home/domain/repository/driver_accept_ride_repository.dart';

import '../datasource/driver_accept_ride_datasource.dart';
import '../model/accept-ride/accept_ride_model.dart';

class DriverAcceptRideRepositoryImpl implements DriverAcceptRideRepository {
  final DriverAcceptRideDatasource driverAcceptRideDatasource;

  DriverAcceptRideRepositoryImpl(this.driverAcceptRideDatasource);
  @override
  Future<Either<Exception, String>> driverAcceptRide(
      String rideId, AcceptRideModel acceptRideModel) {
    return driverAcceptRideDatasource.driverAcceptRide(rideId, acceptRideModel);
  }
}
