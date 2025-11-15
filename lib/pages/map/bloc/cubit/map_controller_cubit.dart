import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';

part '../state/map_controller_state.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapControllerInitial());

  RideDataModel? rideDataModel;

  MapPageType mapPageType = MapPageType.CreatingRide;
  Set<Marker> markers = {};

  changeMapPageType(MapPageType type) {
    emit(MapControllerLoading());
    mapPageType = type;
    emit(MapControllerLoaded());
  }

  void setRideData(RideDataModel data) {
    emit(MapControllerLoading());
    rideDataModel = data;
    emit(MapControllerLoaded());
  }

  /// get markers
  Set<Marker> getMarkers() {
    emit(MapControllerLoading());
    if (MapPageType.CreatingRide == mapPageType) {
      markers.add(Di().sl<GoogleMapCubit>().getPointerMarker(CameraPosition(
          target: Di().sl<GoogleMapCubit>().cameraPosition, zoom: 16)));
      return markers;
    } else {
      markers = {
        Marker(
          markerId: const MarkerId("destination"),
          position: LatLng(rideDataModel?.destinationLatitude ?? 0.0,
              rideDataModel?.destinationLongitude ?? 0.0),
          icon:
              BitmapDescriptor.fromBytes(Di().sl<GoogleMapCubit>().userMarker!),
          infoWindow: const InfoWindow(title: "Destination"),
        ),
        if (rideDataModel?.stepOverLatitude != null &&
            rideDataModel?.stepOverLongitude != null)
          Marker(
            markerId: const MarkerId("stepOver"),
            icon: BitmapDescriptor.fromBytes(
                Di().sl<GoogleMapCubit>().userMarker!),
            position: LatLng(rideDataModel?.stepOverLatitude ?? 0.0,
                rideDataModel?.stepOverLongitude ?? 0.0),
            infoWindow: const InfoWindow(title: "Step Over"),
          ),
        Marker(
          markerId: const MarkerId("pickup"),
          icon:
              BitmapDescriptor.fromBytes(Di().sl<GoogleMapCubit>().userMarker!),
          position: LatLng(rideDataModel?.pickupLatitude ?? 0.0,
              rideDataModel?.pickupLongitude ?? 0.0),
          infoWindow: const InfoWindow(title: "Pickup"),
        ),
      };
      return markers;
    }
  }

  // update pointer marker
  void updatePointerMarker(CameraPosition position) {
    emit(MapControllerLoading());
    markers.clear();
    markers.add(Di().sl<GoogleMapCubit>().getPointerMarker(position));
    emit(MapControllerLoaded());
  }

  // get the polyline between the destination and the step over and the pickup
  Set<Polyline> getPolyline() {
    emit(MapControllerLoading());
    return {
      Polyline(
        polylineId: const PolylineId("destination"),
        color: AppColors.redColor,
        points: [
          LatLng(rideDataModel?.destinationLatitude ?? 0.0,
              rideDataModel?.destinationLongitude ?? 0.0),
          LatLng(rideDataModel?.stepOverLatitude ?? 0.0,
              rideDataModel?.stepOverLongitude ?? 0.0),
          LatLng(rideDataModel?.pickupLatitude ?? 0.0,
              rideDataModel?.pickupLongitude ?? 0.0),
        ],
        width: 5,
      ),
    };
  }
}
