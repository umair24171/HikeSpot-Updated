part of '../cubit/map_controller_cubit.dart';

class MapControllerState extends Equatable {
  @override
  List<Object?> get props => [];
}


class MapControllerInitial extends MapControllerState {}

class MapControllerLoading extends MapControllerState {}

class MapControllerLoaded extends MapControllerState {}

class MapControllerError extends MapControllerState {}