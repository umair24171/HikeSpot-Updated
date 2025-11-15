import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class UserGoogleMap extends StatefulWidget {
  const UserGoogleMap({super.key});

  @override
  State<UserGoogleMap> createState() => UserGoogleMapState();
}

class UserGoogleMapState extends State<UserGoogleMap> {
  final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
  final MenueCubit _menueCubit = Di().sl<MenueCubit>();
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  final DriverRidesRequestsCubit _driverRidesRequestsCubit =
      Di().sl<DriverRidesRequestsCubit>();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _googleMapCubit.initialize(context);
    _googleMapCubit.getLocation(context);
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      _googleMapCubit.updateLocationDriver(context);
    });
  }

//  void updateMark(context) {
  //   _googleMapCubit.updatemar(context);
  // }
  @override
  void dispose() {
    _timer!.cancel();
    _googleMapCubit.mapController = Completer();
    _googleMapCubit.customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, GoogleMapState>(
      bloc: _googleMapCubit,
      listener: (context, state) {
        if (state is GoogleMapStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is GoogleMapStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GoogleMapStateError) {
          return Center(
            child: AppTextStyle(
              text: "Error: ${state.error}",
              fontSize: 24,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return BlocBuilder(
          bloc: _driverRidesRequestsCubit,
          builder: (context, state) {
            return GoogleMap(
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: false,
              fortyFiveDegreeImageryEnabled: true,
              buildingsEnabled: true,
              markers: Set<Marker>.of(_googleMapCubit.markers),
              style: _googleMapCubit.mapStyle,
              circles: _driverRidesRequestsCubit.circles,
              onTap: _onMapTap,
              polylines: _buildPolylines(),
              initialCameraPosition: _getInitialCameraPosition(),
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
            );
          },
        );
      },
    );
  }

  Set<Circle> _buildCircles() {
    return <Circle>{
      Circle(
        circleId: const CircleId("finding"),
        radius: 100,
        fillColor: AppColors.redColor.withOpacity(0.4),
        strokeWidth: 0,
        strokeColor: AppColors.transparent,
        center: LatLng(
          _googleMapCubit.currentLocation?.latitude ?? 0,
          _googleMapCubit.currentLocation?.longitude ?? 0,
        ),
      ),
      Circle(
        circleId: const CircleId("finding2"),
        radius: 150,
        fillColor: AppColors.redColor.withOpacity(0.3),
        strokeWidth: 0,
        strokeColor: AppColors.transparent,
        center: LatLng(
          _googleMapCubit.currentLocation?.latitude ?? 0,
          _googleMapCubit.currentLocation?.longitude ?? 0,
        ),
      ),
      Circle(
        circleId: const CircleId("finding3"),
        radius: 200,
        fillColor: AppColors.redColor.withOpacity(0.2),
        strokeWidth: 0,
        strokeColor: AppColors.transparent,
        center: LatLng(
          _googleMapCubit.currentLocation?.latitude ?? 0,
          _googleMapCubit.currentLocation?.longitude ?? 0,
        ),
      ),
      Circle(
        circleId: const CircleId("finding4"),
        radius: 250,
        fillColor: AppColors.redColor.withOpacity(0.1),
        strokeWidth: 0,
        strokeColor: AppColors.transparent,
        center: LatLng(
          _googleMapCubit.currentLocation?.latitude ?? 0,
          _googleMapCubit.currentLocation?.longitude ?? 0,
        ),
      ),
    };
  }

  void _onMapTap(LatLng argument) {
    _googleMapCubit.changeRidingSectionVisibility(false);
    _googleMapCubit.customInfoWindowController.hideInfoWindow!();
    _menueCubit.changeMenuVisibility(false);
  }

 // Replace the _buildPolylines method in UserGoogleMap (google_map.dart) with this:

Set<Polyline> _buildPolylines() {
  if (_googleMapCubit.polylineCoordinates.isEmpty) {
    return <Polyline>{};
  }
  
  return <Polyline>{
    Polyline(
      polylineId: const PolylineId("route"),
      color: AppColors.primaryDark, // 🔥 Changed to primary color for better visibility
      width: 6, // 🔥 Increased width from 5 to 6
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.round, // 🔥 Smoother corners
      geodesic: true, // 🔥 Follow earth's curvature
      points: _googleMapCubit.polylineCoordinates,
      patterns: [
        // 🔥 Optional: Add pattern for better visibility
        // PatternItem.dot,
        // PatternItem.gap(10),
      ],
    ),
  };
}

  CameraPosition _getInitialCameraPosition() {
    return CameraPosition(
      target: LatLng(
        _googleMapCubit.currentLocation?.latitude ??
            _authCubit.authData.latitude,
        _googleMapCubit.currentLocation?.longitude ??
            _authCubit.authData.longitude,
      ),
      zoom: 14.5,
    );
  }
// In your google_map.dart (UserGoogleMapState class)
// Find the _onMapCreated method and replace it with this:

void _onMapCreated(GoogleMapController controller) {
  // 🔥 FIX: Only complete if not already completed
  if (!_googleMapCubit.mapController.isCompleted) {
    _googleMapCubit.mapController.complete(controller);
    controller.setMapStyle(_googleMapCubit.mapStyle);
    _googleMapCubit.customInfoWindowController.googleMapController = controller;
  } else {
    print("⚠️ MapController already completed, skipping...");
  }
}

  void _onCameraMove(CameraPosition position) {
    _googleMapCubit.updateMarkers(position);
    // _googleMapCubit.customInfoWindowController.hideInfoWindow!();
  }
}
