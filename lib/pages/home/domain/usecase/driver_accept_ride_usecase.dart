import 'package:dartz/dartz.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';
import 'package:hikespot/pages/home/domain/repository/driver_accept_ride_repository.dart';

class DriverAcceptRideUsecase {
  final DriverAcceptRideRepository _rideRepository;

  DriverAcceptRideUsecase(this._rideRepository);

  Future<Either<Exception, String>> call(String rideId, AcceptRideModel accept) async {
    return await _rideRepository.driverAcceptRide(rideId, accept);
  }
}
