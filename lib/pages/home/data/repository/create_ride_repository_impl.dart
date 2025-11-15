import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/home/data/datasource/create_ride_datasource.dart';

import '../../domain/repository/create_ride_repository.dart';
import '../model/ride/ride_data_model.dart';

class CreateRideRepositoryImpl implements CreateRideRepository {
  final CreateRideDatasource createRideDataSource;

  CreateRideRepositoryImpl( this.createRideDataSource);

  @override
  Future<Either<String, RideDataModel>> createRide(BuildContext context,
      {required RideDataModel rideModel}) {
    return createRideDataSource.createRide(context, rideModel: rideModel);
  }
}
