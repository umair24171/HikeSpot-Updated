import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/widgets/googlemap/custom_info_window.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
part '../state/google_map_state.dart';


class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapStateInitial());

  // Controllers
  Completer<GoogleMapController> mapController = Completer();
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  ScrollController scrollController = ScrollController();
  StreamSubscription? driversStreamSubscription;

  // Map related variables
  String mapStyle = "";
  List<Marker> markers = [];
  List<LatLng> polylineCoordinates = [];
  LatLng cameraPosition = const LatLng(30.175158, 71.491318);

  // Location related variables
  Position? currentLocation;
  geocoding.Placemark? address;
  StreamSubscription<Position>? positionStreamSubscription;
StreamSubscription? activeRideSubscription;
  // Markers
  Uint8List? pointerMarker;
  Uint8List? userMarker;

  // Ride related variables
  int selectedRideIndex = 0;
  bool showRidingSection = false;

  // Sample driver locations
  final List<LatLng> driverLocations = [];

  double routeDistanceInKm = 0.0;
String routeDistanceText = "";

void stopActiveRideTracking() {
  activeRideSubscription?.cancel();
  activeRideSubscription = null;
}

// Update your updateArrived method to handle state better:
int isArrived = 0;
RideDataModel? rideData;

void updateArrived(int value, {RideDataModel? rideModel}) async {
  emit(GoogleMapStateLoading());
  
  isArrived = value;
  
  if (rideModel != null) {
    rideData = rideModel;
  }
  
  if (value == 1) {
    // Driver is navigating (either to pickup or destination)
    print("🚗 Driver navigating...");
    
  } else if (value == 2) {
    // Driver has arrived at pickup
    print("✅ Driver arrived at pickup");
    
    // Update ride status in Firestore
    if (rideData != null) {
      await FirebaseFirestore.instance
          .collection("rides")
          .doc(rideData!.rideId)
          .update({"rideStatus": "Arrived"});
    }
    
  } else if (value == 0) {
    // Reset state - no active ride
    print("🔄 Resetting driver state");
    latitude1 = null;
    longitude2 = null;
    polylineCoordinates = [];
    rideData = null;
  }
  
  emit(GoogleMapStateMarkersUpdated());
}

// Initialize ride tracking when driver logs in
void initializeDriverMode(String driverId) {
  startActiveRideTracking(driverId);
}

void startActiveRideTracking(String driverId) {
  // Listen to driver's active rides
  activeRideSubscription = AppConstants.firestore
      .collection("rides")
      .where('driverId', isEqualTo: driverId)
      .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
      .snapshots()
      .listen((snapshot) {
    
    if (snapshot.docs.isNotEmpty) {
      RideDataModel activeRide = RideDataModel.fromJson(
        snapshot.docs.first.data()
      );
      
      print("🚗 Active ride status: ${activeRide.rideStatus}");
      
      // Update navigation based on ride status
      if (activeRide.rideStatus == 'Running') {
        // Going to pickup location
        print("📍 Navigating to pickup location");
        getPolyPoint(activeRide.pickupLatitude, activeRide.pickupLongitude);
        updateArrived(1, rideModel: activeRide);
        
      } else if (activeRide.rideStatus == 'Arrived') {
        // Waiting at pickup
        print("⏰ Arrived at pickup, waiting for user");
        updateArrived(2, rideModel: activeRide);
        
      } else if (activeRide.rideStatus == 'start_destination') {
        // Going to destination
        print("🎯 Navigating to destination");
        getPolyPoint(activeRide.destinationLatitude, activeRide.destinationLongitude);
        updateArrived(1, rideModel: activeRide);
      }
    } else {
      // No active ride, reset state
      print("✅ No active ride");
      updateArrived(0);
    }
  });
}

  Future<void> initialize(context) async {
    emit(GoogleMapStateLoading());

    try {
      await Future.wait([
        setMapStyle(),
        initializeMarkers(),
        getUserCurrentLocation(context),
      ]);

      if (currentLocation != null) {
        await getAddressFromLatLng(currentLocation!);
        updateUserMarker();
        listenToLocation(context);
        checkDriversInEntrance();
      }

      // await getPolyPoints();

      emit(GoogleMapStateLoaded());
    } catch (e) {
      emit(GoogleMapStateError(e.toString()));
    }
  }

 Future<void> setMapStyle() async {
  // 🔥 USE STANDARD GOOGLE MAPS - No custom style
  mapStyle = "[]"; // Empty style = default Google Maps
  print("✅ Using standard Google Maps style");
}

  Future<void> initializeMarkers0({
    double? latitude,
    double? longitude,
  }) async {
    markers.clear();

    // Load custom marker icons
   // Around line 110
pointerMarker = await getBytesFromAsset(AppImages.pointerIcon, 60); // 🔥 Changed from 40 to 60
userMarker = await getBytesFromAsset(AppImages.userHeader, 60); // 🔥 Changed from 40 to 60

    // Add the main user's location marker (based on current location)
    if (currentLocation != null && pointerMarker != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          icon: BitmapDescriptor.fromBytes(pointerMarker!),
          position:
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              const UserCustomInfo(),
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
            );
          },
        ),
      );
    }

    // Add marker for the specified other user location if provided
    if (latitude != null && longitude != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('otherUser'),
          icon: BitmapDescriptor.fromBytes(userMarker!),
          position: LatLng(latitude, longitude),
          onTap: () {},
        ),
      );
    }

    // Add driver markers
    for (int i = 0; i < driverLocations.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(AppImages.carIcon, 40);
      markers.add(
        Marker(
          markerId: MarkerId('driver$i'),
          position: driverLocations[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          draggable: false,
          infoWindow: const InfoWindow(
            title: 'Driver',
            snippet: 'This is a driver',
          ),
        ),
      );
    }
  }

  Future<void> initializeMarkers({double? latitude, double? longitude}) async {
    markers.clear();
    pointerMarker = await getBytesFromAsset(AppImages.pointerIcon, 40);
    userMarker = await getBytesFromAsset(AppImages.userHeader, 40);
    if (currentLocation != null && pointerMarker != null) {
      if (latitude != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('pointer'),
            icon: BitmapDescriptor.fromBytes(userMarker!),
            position: LatLng(latitude, longitude ?? 0),
            onTap: () {},
          ),
        );
        markers.add(
          Marker(
            markerId: const MarkerId('pointer'),
            icon: BitmapDescriptor.fromBytes(pointerMarker!),
            position:
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
            onTap: () {
              customInfoWindowController.addInfoWindow!(
                const UserCustomInfo(),
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
              );
            },
          ),
        );
      }
    }

    for (int i = 0; i < driverLocations.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(AppImages.carIcon, 40);
      markers.add(
        Marker(
          markerId: MarkerId('driver$i'),
          position: driverLocations[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          draggable: false,
          infoWindow: const InfoWindow(
            title: 'Driver',
            snippet: 'This is a driver',
          ),
        ),
      );
    }
  }

  Future<Position?> getUserCurrentLocation(context) async {
    await checkAndRequestPermissions();
    await checkAndRequestService();

    currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    Di().sl<AuthCubit>().updateLocation(context);
    return currentLocation;
  }

  // get location
  Future<void> getLocation(context) async {
    await getUserCurrentLocation(context).then(
      (value) {
        if (value != null) {
          print(
              "update address lati ${value.latitude}  longi${value.longitude}");
          getAddressFromLatLng(value);
          updateUserMarker();
        }
      },
    );
  }

  Future<void> checkAndRequestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      throw Exception("Location permission permanently denied");
    }
  }

  Future<void> checkAndRequestService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviceEnabled = await Geolocator.requestService();
      if (!serviceEnabled) {
        throw Exception("Location service is disabled");
      }
    }
  }

  Future<void> getAddressFromLatLng(Position? position) async {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(
            position?.latitude ?? 0, position?.longitude ?? 0);
    address = placemarks[0];
  }

  void updateUserMarker() {
    List<Marker> tempMarkers = markers
        .where((marker) => marker.markerId != const MarkerId('UserMarker'))
        .toList();

    if (currentLocation != null && userMarker != null) {
      tempMarkers.add(
        Marker(
          markerId: const MarkerId('UserMarker'),
          icon: BitmapDescriptor.fromBytes(userMarker!),
          rotation: currentLocation?.heading ?? 0,
          position:
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              const UserCustomInfo(),
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
            );
          },
        ),
      );
    }

    markers = tempMarkers;
  }

  Future<void> listenToLocation(context) async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );

    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position locationData) {
        currentLocation = locationData;
        updateUserMarker();
        Di().sl<AuthCubit>().updateLocation(context);
        emit(GoogleMapStateLocationUpdated(locationData));
      },
    );
  }

 // Replace the getPolyPoints method in your GoogleMapCubit with this:
Future<void> getPolyPoints(double latitude, double longitude) async {
  try {
    emit(GoogleMapStateLoading());
    
    // 🔥 Validate current location first
    if (currentLocation == null || 
        currentLocation!.latitude == 0 || 
        currentLocation!.longitude == 0) {
      debugPrint("❌ Invalid current location, fetching location first...");
      await getUserCurrentLocation(null);
      
      if (currentLocation == null) {
        debugPrint("❌ Still unable to get current location");
        emit(GoogleMapStateError("Unable to get your current location"));
        return;
      }
    }
    
    // 🔥 Validate destination coordinates
    if (latitude == 0 || longitude == 0) {
      debugPrint("❌ Invalid destination coordinates");
      emit(GoogleMapStateError("Invalid destination location"));
      return;
    }
    
    print("✅ Fetching route from (${currentLocation!.latitude}, ${currentLocation!.longitude}) to ($latitude, $longitude)");
    
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
          origin: PointLatLng(
              currentLocation!.latitude,
              currentLocation!.longitude),
          destination: PointLatLng(latitude, longitude),
          mode: TravelMode.driving,
          // 🔥 CRITICAL FIX: Avoid unpaved roads (gravel/sand) and ferries
          avoidHighways: false, // Allow highways for faster routes
          avoidTolls: false,    // Allow tolls
          avoidFerries: true,   // ✅ Avoid ferries
          // Note: flutter_polyline_points doesn't support avoidUnpaved directly
          // But we can optimize by requesting alternative routes
          alternatives: true,   // ✅ Get alternative routes to pick best paved option
      ),
      googleApiKey: AppConstants.googleMapApiKey,
    );
    
    // 🔥 Always show markers, even if polyline fails
    await initializeMarkers0(latitude: latitude, longitude: longitude);
    emit(GoogleMapStateMarkersUpdated());
    
    if (result.points.isNotEmpty) {
      print("✅ Route found with ${result.points.length} points");
      polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      
      // 🔥 Calculate total distance from polyline
      routeDistanceInKm = calculatePolylineDistance();
      routeDistanceText = "${routeDistanceInKm.toStringAsFixed(1)} km";
      
      print("✅ Route distance calculated: $routeDistanceText (${routeDistanceInKm} km)");
      
      // 🔥 CRITICAL: Emit state after calculating distance
      emit(GoogleMapStateMarkersUpdated());
      
      // Animate camera to show the full route
      await animateCameraToRoute(latitude, longitude);
      
      // 🔥 Emit final state
      emit(GoogleMapStateMarkersUpdated());
      
    } else {
      // 🔥 Handle ZERO_RESULTS - use straight-line distance as fallback
      print("⚠️ No route found. Status: ${result.status}. Error: ${result.errorMessage}");
      polylineCoordinates = [];
      
      // Calculate straight-line distance as fallback
      double distanceInMeters = Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        latitude,
        longitude,
      );
      routeDistanceInKm = distanceInMeters / 1000;
      routeDistanceText = "${routeDistanceInKm.toStringAsFixed(1)} km (straight-line)";
      
      print("⚠️ Using straight-line distance: $routeDistanceText (${routeDistanceInKm} km)");
      
      // 🔥 CRITICAL: Emit state after calculating distance
      emit(GoogleMapStateMarkersUpdated());
      
      // Still animate to show both markers
      await animateCameraToRoute(latitude, longitude);
      
      emit(GoogleMapStateMarkersUpdated());
    }
    
  } catch (e) {
    debugPrint("❌ Failed to get polypoints: ${e.toString()}");
    
    // 🔥 Still try to show markers and calculate straight-line distance
    try {
      await initializeMarkers0(latitude: latitude, longitude: longitude);
      
      // Calculate straight-line distance as fallback
      if (currentLocation != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          currentLocation!.latitude,
          currentLocation!.longitude,
          latitude,
          longitude,
        );
        routeDistanceInKm = distanceInMeters / 1000;
        routeDistanceText = "${routeDistanceInKm.toStringAsFixed(1)} km";
      }
      
      emit(GoogleMapStateMarkersUpdated());
      await animateCameraToRoute(latitude, longitude);
    } catch (markerError) {
      debugPrint("❌ Failed to show markers: ${markerError.toString()}");
    }
    
    emit(GoogleMapStateMarkersUpdated());
  }
}

// 🔥 NEW: Calculate total distance from polyline points
double calculatePolylineDistance() {
  double totalDistance = 0.0;
  
  for (int i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += Geolocator.distanceBetween(
      polylineCoordinates[i].latitude,
      polylineCoordinates[i].longitude,
      polylineCoordinates[i + 1].latitude,
      polylineCoordinates[i + 1].longitude,
    );
  }
  
  return totalDistance / 1000; // Convert meters to kilometers
}

Future<void> animateCameraToRoute(double destLat, double destLng) async {
  try {
    final GoogleMapController controller = await mapController.future;
    
    if (currentLocation != null) {
      // Calculate bounds to show both start and end points
      double minLat = currentLocation!.latitude < destLat 
          ? currentLocation!.latitude 
          : destLat;
      double maxLat = currentLocation!.latitude > destLat 
          ? currentLocation!.latitude 
          : destLat;
      double minLng = currentLocation!.longitude < destLng 
          ? currentLocation!.longitude 
          : destLng;
      double maxLng = currentLocation!.longitude > destLng 
          ? currentLocation!.longitude 
          : destLng;
      
      // 🔥 DYNAMIC padding based on distance
      double distance = routeDistanceInKm;
      double padding;
      
      if (distance > 100) {
        padding = 0.15; // 15% padding for long routes (100+ km)
      } else if (distance > 50) {
        padding = 0.10; // 10% padding for medium routes (50-100 km)
      } else if (distance > 20) {
        padding = 0.08; // 8% padding for short routes (20-50 km)
      } else {
        padding = 0.05; // 5% padding for very short routes (<20 km)
      }
      
      // Apply padding
      double latPadding = (maxLat - minLat) * padding;
      double lngPadding = (maxLng - minLng) * padding;
      
      minLat -= latPadding;
      maxLat += latPadding;
      minLng -= lngPadding;
      maxLng += lngPadding;
      
      // Create bounds
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
      
      // 🔥 Animate camera with proper padding
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 80), // Screen edge padding in pixels
      );
      
      print("✅ Camera animated to show full ${routeDistanceText} route");
      print("📍 Bounds: SW($minLat, $minLng) - NE($maxLat, $maxLng)");
    }
  } catch (e) {
    debugPrint("❌ Failed to animate camera: ${e.toString()}");
  }
}
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void updateMarkers(CameraPosition position) {
    emit(GoogleMapStateUpdatingMarkers());
    updatePointerMarker(position);
    emit(GoogleMapStateMarkersUpdated());
  }

  void updatePointerMarker(CameraPosition position) {
    List<Marker> tempMarkers = markers
        .where((marker) => marker.markerId != const MarkerId('pointer'))
        .toList();

    if (pointerMarker != null) {
      tempMarkers.add(
        Marker(
          markerId: const MarkerId('pointer'),
          icon: BitmapDescriptor.fromBytes(pointerMarker!),
          position: LatLng(position.target.latitude, position.target.longitude),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              const UserCustomInfo(),
              LatLng(position.target.latitude, position.target.longitude),
            );
          },
        ),
      );
    }

    markers = tempMarkers;
  }

  getPointerMarker(CameraPosition position) {
    return Marker(
      markerId: const MarkerId('pointer'),
      icon: BitmapDescriptor.fromBytes(pointerMarker!),
      position: LatLng(position.target.latitude, position.target.longitude),
      onTap: () {
        customInfoWindowController.addInfoWindow!(
          const UserCustomInfo(),
          LatLng(position.target.latitude, position.target.longitude),
        );
      },
    );
  }

  Future<void> goToCurrentLocation() async {
    emit(GoogleMapStateMovingCamera());
    final GoogleMapController controller = await mapController.future;
    if (currentLocation != null) {
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        zoom: 16,
      )));
    }
    emit(GoogleMapStateCameraMoved());
  }

  void changeIndex(int index) {
    emit(GoogleMapStateChangingRideIndex());
    selectedRideIndex = index;
    emit(GoogleMapStateRideIndexChanged(index));
  }

  void changeRidingSectionVisibility(bool show) {
    emit(GoogleMapStateChangingRidingSection());
    showRidingSection = show;
    emit(show
        ? GoogleMapStateRidingSectionShown()
        : GoogleMapStateRidingSectionHidden());
  }

  void stopListeningToLocation() {
    positionStreamSubscription?.cancel();
    emit(GoogleMapStateLocationListeningStopped());
  }

  @override
  Future<void> close() {
    stopListeningToLocation();
    return super.close();
  }

  // check that if there is any driver in the range of the 300 km
  Future<void> checkDriversInEntrance() async {
    try {
      log("checking drivers in entrance");
      emit(GoogleMapStateLoading());
      driversStreamSubscription = AppConstants.firestore
          .collection(AppConstants.usersKey)
          .where("isRequestedDriver", isEqualTo: true)
          .snapshots()
          .listen(
        (event) {
          List<AuthModel> tempDrivers =
              event.docs.map((e) => AuthModel.fromJson(e.data())).toList();
          List<AuthModel> drivers = tempDrivers.where((element) {
            double distance = Geolocator.distanceBetween(
              currentLocation?.latitude ?? 0,
              currentLocation?.longitude ?? 0,
              element.driverModel.latitude,
              element.driverModel.longitude,
            );
            log((distance / 1000).toString());
            return distance / 1000 <= 300 &&
                element.driverModel.isOnDuty &&
                element.driverModel.isVerified;
          }).toList();
          for (var element in drivers) {
            emit(GoogleMapStateMarkersUpdated());
            driverLocations.add(LatLng(
                element.driverModel.latitude, element.driverModel.longitude));
            log("${driverLocations.length} drivers found in the range of 300 km");
            updateDriverMarkers(element.uid, element.driverModel.latitude,
                element.driverModel.longitude);
          }
          emit(GoogleMapStateMarkersUpdated());
        },
      );
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // update the driver markers
  Future<void> updateDriverMarkers(
      String id, double latitude, double longitude) async {
    emit(GoogleMapStateLoading());
    List<Marker> tempMarkers = List.from(markers);
    tempMarkers.removeWhere((element) => element.markerId.value.contains(id));
    final Uint8List markerIcon = await getBytesFromAsset(AppImages.carIcon, 40);
    tempMarkers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        draggable: false,
        infoWindow: const InfoWindow(
          title: 'Driver',
          snippet: 'This is a driver',
        ),
      ),
    );
    log("Driver markers updated successfully ${tempMarkers.length}");
    markers.addAll(tempMarkers);
    emit(GoogleMapStateMarkersUpdated());
  }

  // get address from placemark
  String getAddressFromPlacemark() {
    return "${address?.street}, ${address?.locality}, ${address?.administrativeArea}, ${address?.country}";
  }

  updateLocationDriver(context) async {
    final AuthCubit _auth = Di().sl<AuthCubit>();
    await getUserCurrentLocation(context).then(
      (value) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.authData.uid)
            .update({
          "latitude": value!.latitude,
          "longitude": value.longitude,
        });
      },
    );
  }



 double? latitude1;
double? longitude2;
  //get poly
  Future<void> getPolyPoint(double latitude, double longitude) async {
    try {
      latitude1=latitude;
      longitude2=longitude;
      // Start listening to the location
      listenToLoc();

      print("available");
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
            origin: PointLatLng(currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0),
            destination: PointLatLng(latitude, longitude),
            mode: TravelMode.driving),
        googleApiKey: AppConstants.googleMapApiKey,
      );
      if (result.points.isNotEmpty) {
        print("available address");
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      }

      initializeMarkers0(latitude: latitude, longitude: longitude);
      
    } catch (e) {
      debugPrint("Failed to get polyline points: ${e.toString()}");
    }
  }

  Future<void> listenToLoc() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );

    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position locationData) {
        currentLocation = locationData;

        // Update the user marker position on the map
        updateUserMarker();

        // Move the camera to follow the current location
        goToCurrentLocation();

        // Emit location update state
        emit(GoogleMapStateLocationUpdated(locationData));
      },
    );
  }

  Future<void> goToCurrentLoc() async {
    emit(GoogleMapStateMovingCamera());
    final GoogleMapController controller = await mapController.future;
    if (currentLocation != null) {
      await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          zoom: 16,
        ),
      ));
    }
    emit(GoogleMapStateCameraMoved());
  }

  void stopListeningToLoc() {
    positionStreamSubscription?.cancel();
    emit(GoogleMapStateLocationListeningStopped());
  }
}
