import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../data/model/ride/ride_data_model.dart';

abstract class CreateRideRepository {
  Future<Either<String, RideDataModel>> createRide(BuildContext context,
      {required RideDataModel rideModel});
}
