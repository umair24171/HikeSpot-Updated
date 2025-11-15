// Replace your entire BookedRideMap widget with this:

import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/helper/chat_helper.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_arrived_dialoge.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:geolocator/geolocator.dart';

class BookedRideMap extends StatefulWidget {
  const BookedRideMap({super.key, required this.rideData});
  final RideDataModel rideData;
  
  @override
  State<BookedRideMap> createState() => BookedRideMapState();
}

class BookedRideMapState extends State<BookedRideMap> {
  final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
  final MenueCubit _menueCubit = Di().sl<MenueCubit>();
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  final DriverRidesRequestsCubit _driverRidesRequestsCubit = Di().sl<DriverRidesRequestsCubit>();
  
  Timer? _timer;
  StreamSubscription? _rideStatusSubscription;
  double? _driverDistance;
  int? _estimatedTime;
  
  @override
  void initState() {
    super.initState();
    _initializeMap();
    _startRideTracking();
  }

  Future<void> _initializeMap() async {
    await _googleMapCubit.initialize(context);
    await _googleMapCubit.getLocation(context);
    
    // Update user's location periodically
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      _googleMapCubit.updateLocationDriver(context);
    });
  }

  void _startRideTracking() {
    // Listen to ride status changes
    _rideStatusSubscription = FirebaseFirestore.instance
        .collection("rides")
        .doc(widget.rideData.rideId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        RideDataModel updatedRide = RideDataModel.fromJson(snapshot.data()!);
        
        // Update route based on ride status
        if (updatedRide.rideStatus == 'Running') {
          // Driver is coming to pickup
          _trackDriverToPickup(updatedRide);
        } else if (updatedRide.rideStatus == 'Arrived') {
          // Driver has arrived
          _showArrivedDialog(updatedRide);
        } else if (updatedRide.rideStatus == 'start_destination') {
          // Ride started, going to destination
          _trackDriverToDestination(updatedRide);
        }
      }
    });
  }

  void _trackDriverToPickup(RideDataModel ride) {
    // Track driver's location and show route to pickup
    FirebaseFirestore.instance
        .collection("users")
        .doc(ride.driverId)
        .snapshots()
        .listen((driverSnapshot) {
      if (driverSnapshot.exists) {
        AuthModel driverData = AuthModel.fromJson(driverSnapshot.data()!);
        
        // Calculate distance to driver
        if (_googleMapCubit.currentLocation != null) {
          _driverDistance = Geolocator.distanceBetween(
            _googleMapCubit.currentLocation!.latitude,
            _googleMapCubit.currentLocation!.longitude,
            driverData.latitude,
            driverData.longitude,
          ) / 1000; // Convert to km
          
          // Estimate time (assuming 40 km/h average speed)
          _estimatedTime = ((_driverDistance ?? 0) / 40 * 60).round();
          
          if (mounted) {
            setState(() {});
          }
        }
        
        // Update driver marker and route
        _googleMapCubit.updateDriverMarkers(
          ride.driverId,
          driverData.latitude,
          driverData.longitude,
          // vehicleType: driverData.driverModel.carService,
        );
        
        // Draw route from driver to pickup
        _googleMapCubit.getPolyPoints(
          ride.pickupLatitude,
          ride.pickupLongitude,
        );
      }
    });
  }

  void _trackDriverToDestination(RideDataModel ride) {
    // Show route to destination
    _googleMapCubit.getPolyPoints(
      ride.destinationLatitude,
      ride.destinationLongitude,
    );
  }

  void _showArrivedDialog(RideDataModel ride) {
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: RiderArrivedDialoge(acceptRideModel: ride),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _rideStatusSubscription?.cancel();
    _googleMapCubit.mapController = Completer();
    _googleMapCubit.customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: BlocConsumer<GoogleMapCubit, GoogleMapState>(
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

          return Stack(
            children: [
              // Map
              BlocBuilder(
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
              ),
              
              // Top bar - Back button and ride info
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: SafeArea(
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      
                      // Driver info card
                      _buildDriverInfoCard(),
                    ],
                  ),
                ),
              ),
              
              // Bottom info card
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _buildRideInfoCard(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDriverInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor.withOpacity(0.2),
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.whiteColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextStyle(
                text: widget.rideData.driverName,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
              if (_driverDistance != null && _estimatedTime != null)
                AppTextStyle(
                  text: "${_driverDistance!.toStringAsFixed(1)} km away • $_estimatedTime min",
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor.withOpacity(0.8),
                ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _buildRideInfoCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.containerColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.primaryGreyColor.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ... existing status indicator and pickup location ...
        
        const SizedBox(height: 16),
        
        // Action buttons - NOW WITH CHAT!
        Row(
          children: [
            // Call Button
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Call driver
                  print("Call: ${widget.rideData.driverPhone}");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryDark,
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: AppColors.primaryDark, size: 20),
                      SizedBox(width: 8),
                      AppTextStyle(
                        text: "Call",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // 🔥 NEW: Chat Button
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Open chat with driver
                  ChatHelper.openChatWithUser(
                    context,
                    userId: widget.rideData.driverId,
                    currentUserId: _authCubit.authData.uid,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      AppTextStyle(
                        text: "Chat",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Cancel Button
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Cancel ride
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.redColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.redColor, width: 1),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.redColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  Set<Polyline> _buildPolylines() {
    return <Polyline>{
      Polyline(
        polylineId: const PolylineId("route"),
        color: AppColors.primaryDark,
        width: 6,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        jointType: JointType.round,
        geodesic: true,
        points: _googleMapCubit.polylineCoordinates,
      ),
    };
  }

  CameraPosition _getInitialCameraPosition() {
    return CameraPosition(
      target: LatLng(
        _googleMapCubit.currentLocation?.latitude ?? _authCubit.authData.latitude,
        _googleMapCubit.currentLocation?.longitude ?? _authCubit.authData.longitude,
      ),
      zoom: 14.5,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_googleMapCubit.mapController.isCompleted) {
      _googleMapCubit.mapController.complete(controller);
      controller.setMapStyle(_googleMapCubit.mapStyle);
      _googleMapCubit.customInfoWindowController.googleMapController = controller;
    }
  }

  void _onMapTap(LatLng argument) {
    _googleMapCubit.changeRidingSectionVisibility(false);
    _googleMapCubit.customInfoWindowController.hideInfoWindow!();
    _menueCubit.changeMenuVisibility(false);
  }

  void _onCameraMove(CameraPosition position) {
    _googleMapCubit.updateMarkers(position);
  }
}