import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/home/domain/repository/create_ride_repository.dart';

import '../../data/model/ride/ride_data_model.dart';

class CreateRideUsecase {
  final CreateRideRepository _rideRepository;

  CreateRideUsecase(this._rideRepository);

  Future<Either<String, RideDataModel>> execute(
      BuildContext context, RideDataModel model) async {
    return await _rideRepository.createRide(context, rideModel: model);
  }
}
