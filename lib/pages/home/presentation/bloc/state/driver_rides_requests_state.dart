part of '../cubit/driver_rides_requests_cubit.dart';

abstract class DriverRidesRequestsState extends Equatable {
  final bool isSearchingForRides;
  
  const DriverRidesRequestsState({this.isSearchingForRides = false});
  
  @override
  List<Object?> get props => [isSearchingForRides];
}

class DriverRidesRequestsInitial extends DriverRidesRequestsState {
  const DriverRidesRequestsInitial() : super(isSearchingForRides: false);
}

class DriverRidesRequestsLoading extends DriverRidesRequestsState {
  const DriverRidesRequestsLoading({super.isSearchingForRides});
}

class DriverRidesRequestsSuccess extends DriverRidesRequestsState {
  const DriverRidesRequestsSuccess({super.isSearchingForRides});
}

class DriverRidesRequestsFailure extends DriverRidesRequestsState {
  const DriverRidesRequestsFailure({super.isSearchingForRides});
}