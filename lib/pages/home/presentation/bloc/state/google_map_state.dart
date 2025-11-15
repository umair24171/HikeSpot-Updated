part of '../cubit/google_map_cubit.dart';

class GoogleMapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleMapStateInitial extends GoogleMapState {}

class GoogleMapStateLoading extends GoogleMapState {}

class GoogleMapStateLoaded extends GoogleMapState {}

class GoogleMapStateError extends GoogleMapState {
  final String error;
  
  GoogleMapStateError(this.error);
  
  @override
  List<Object?> get props => [error];
}

class GoogleMapStateLocationUpdated extends GoogleMapState {
  final Position locationData;
  
  GoogleMapStateLocationUpdated(this.locationData);
  
  @override
  List<Object?> get props => [locationData];
}

class GoogleMapStateUpdatingMarkers extends GoogleMapState {}

class GoogleMapStateMarkersUpdated extends GoogleMapState {}

class GoogleMapStateMovingCamera extends GoogleMapState {}

class GoogleMapStateCameraMoved extends GoogleMapState {}

class GoogleMapStateChangingRideIndex extends GoogleMapState {}

class GoogleMapStateRideIndexChanged extends GoogleMapState {
  final int index;
  
  GoogleMapStateRideIndexChanged(this.index);
  
  @override
  List<Object?> get props => [index];
}

class GoogleMapStateChangingRidingSection extends GoogleMapState {}

class GoogleMapStateRidingSectionShown extends GoogleMapState {}

class GoogleMapStateRidingSectionHidden extends GoogleMapState {}

class GoogleMapStateLocationListeningStopped extends GoogleMapState {}

// Existing states from your original file
class RidingSectionShow extends GoogleMapState {}

class RidingSectionHide extends GoogleMapState {}

class SelectedRideIndex extends GoogleMapState {
  final int index;
  SelectedRideIndex(this.index);
  @override
  List<Object?> get props => [index];
}

class SelectedRideIndexChange extends GoogleMapState {
  @override
  List<Object?> get props => [];
}