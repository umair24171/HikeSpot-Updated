part of '../cubit/driver_rides_requests_cubit.dart';

class DriverRidesRequestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DriverRidesRequestsInitial extends DriverRidesRequestsState {}

class DriverRidesRequestsLoading extends DriverRidesRequestsState {}

class DriverRidesRequestsSuccess extends DriverRidesRequestsState {}

class DriverRidesRequestsFailure extends DriverRidesRequestsState {}
