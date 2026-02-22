import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/data/models/driver-model/driver_model.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/data/model/ride/rider_accept_model.dart';
import 'package:hikespot/pages/home/domain/usecase/driver_accept_ride_usecase.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/utils/enums.dart';

import '../../../../../utils/app_colors.dart';

part '../state/driver_rides_requests_state.dart';

class DriverRidesRequestsCubit extends Cubit<DriverRidesRequestsState> {
  final DriverAcceptRideUsecase _rideUsecase;

  DriverRidesRequestsCubit(this._rideUsecase)
      : super(const DriverRidesRequestsInitial());
      
  StreamSubscription driverRidesSubscription =
      const Stream.empty().listen((event) {});
  StreamSubscription notificationSubscription =
      const Stream.empty().listen((event) {});
  List<RideDataModel> rides = [];
  List<Map<String, dynamic>> notificationList = [];
  Set<Circle> circles = {};
  bool _shouldStop = false;

  // Check if there is any rides in the entered entrance
  void checkRidesInEntrance() {
    debugPrint("🚗 Starting to check for nearby rides...");
    _shouldStop = false;
    buildCircles(AppColors.primaryDark);
    
    emit(const DriverRidesRequestsLoading(isSearchingForRides: true));
    
    driverRidesSubscription = AppConstants.firestore
        .collection(AppConstants.ridesKey)
        .where("rideStatus", isEqualTo: RideStatus.Pending.name)
        .snapshots()
        .listen((event) {
      var temprides =
          event.docs.map((e) => RideDataModel.fromJson(e.data())).toList();

      final DateTime now = DateTime.now();
      final DateTime fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      
      temprides = temprides.where((element) {
        try {
          DateTime rideTime;
          
          try {
            rideTime = DateTime.parse(element.rideStartDate);
          } catch (e) {
            List<String> parts = element.rideStartDate.split('/');
            if (parts.length == 3) {
              int day = int.parse(parts[0]);
              int month = int.parse(parts[1]);
              int year = int.parse(parts[2]);
              rideTime = DateTime(year, month, day);
            } else {
              return false;
            }
          }
          
          return rideTime.isAfter(fiveMinutesAgo);
        } catch (e) {
          print("❌ Error parsing ride time: ${e.toString()}");
          return false;
        }
      }).toList();
      
      temprides.sort((a, b) {
        try {
          DateTime aTime = DateTime.parse(a.rideStartDate);
          DateTime bTime = DateTime.parse(b.rideStartDate);
          return bTime.compareTo(aTime);
        } catch (e) {
          return 0;
        }
      });

      rides = temprides.where((element) {
        Map data = calculateDistanceAndTime(
            element.pickupLatitude, element.pickupLongitude);
        if (data["distance"] <= 30000) {
          element = element.copyWith(
              distance: data["distance"], duration: data["time"]);
          return true;
        } else {
          return false;
        }
      }).toList();
      
      print("✅ Found ${rides.length} pending rides nearby (last 5 min)");
      emit(const DriverRidesRequestsSuccess(isSearchingForRides: true));
    });
  }

  // Cancel the search
  void cancelSearch() {
    debugPrint("🛑 Canceling ride search...");
    _shouldStop = true;
    
    driverRidesSubscription.cancel();
    circles = {};
    rides = [];
    
    emit(const DriverRidesRequestsSuccess(isSearchingForRides: false));
    
    debugPrint("✅ Search cancelled and state updated");
  }

  void stopCircles() {
    _shouldStop = true;
    circles = {};
  }
void sendOffer(String rideId, String fare, BuildContext context) async {
  print("🚗 ===== DRIVER SENDING OFFER =====");
  print("🚗 Ride ID: $rideId");
  print("🚗 Fare: $fare");
  
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  emit(DriverRidesRequestsLoading(isSearchingForRides: state.isSearchingForRides));

  try {
    // 🔥 MANUAL FIX: Construct AuthModel manually with properly serialized DriverModel
    final cleanAuthData = AuthModel(
      uid: authCubit.authData.uid,
      phoneNumber: authCubit.authData.phoneNumber,
      email: authCubit.authData.email,
      imageUrl: authCubit.authData.imageUrl,
      username: authCubit.authData.username,
      firstname: authCubit.authData.firstname,
      lastname: authCubit.authData.lastname,
      ratings: authCubit.authData.ratings,
      totalRides: authCubit.authData.totalRides,
      latitude: authCubit.authData.latitude,
      longitude: authCubit.authData.longitude,
      address: authCubit.authData.address,
      // 🔥 Reconstruct DriverModel from JSON to ensure it's clean
      driverModel: DriverModel.fromJson(authCubit.authData.driverModel.toJson()),
      // Copy other fields if needed...
    );
    
    print("🔥 Clean AuthData created successfully");

    AcceptRideModel acceptRideModel = AcceptRideModel(
      driverData: cleanAuthData,
      distance: 0.0,
      duration: 0.0,
      rideId: rideId,
      fare: double.parse(fare),
    );

    print("🔥 AcceptRideModel created");
    print("🔥 Calling usecase...");
    
    var result = await _rideUsecase.call(rideId, acceptRideModel);
    
    result.fold(
      (error) {
        print("❌ USECASE ERROR: $error");
        WarningHelper.showToast(context, message: error.toString());
        emit(DriverRidesRequestsFailure(isSearchingForRides: state.isSearchingForRides));
      },
      (data) {
        print("✅ USECASE SUCCESS: $data");
        emit(DriverRidesRequestsSuccess(isSearchingForRides: state.isSearchingForRides));
      },
    );
    
  } catch (e, stackTrace) {
    print("❌ ERROR: $e");
    print("❌ Stack: $stackTrace");
    WarningHelper.showToast(context, message: "Error: $e");
    emit(DriverRidesRequestsFailure(isSearchingForRides: state.isSearchingForRides));
  }
}
  void confirmRideByRider(RiderAcceptModel acceptRideModel) async {
    try {
      final GoogleMapCubit googleMapCubit = Di().sl<GoogleMapCubit>();
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("accepted")
          .doc(acceptRideModel.rideId)
          .collection("ridesRequest")
          .get();
      final AuthCubit authCubit = Di().sl<AuthCubit>();
      
      if (snapshot.docs.isNotEmpty) {
        for (var i in snapshot.docs) {
          if (i.id != authCubit.authData.uid) {
            await FirebaseFirestore.instance
                .collection("accepted")
                .doc(acceptRideModel.rideId)
                .collection("ridesRequest")
                .doc(i.id)
                .delete();
            print("deleted successfully");
          }
        }
      }

      Map<String, double> result = await calculateDistanceAndDuration(
        destinationLatitude: acceptRideModel.pickupLatitude,
        destinationLongitude: acceptRideModel.pickupLongitude,
      );
      
      await FirebaseFirestore.instance
          .collection("rides")
          .doc(acceptRideModel.rideId)
          .update({
        "driverId": authCubit.authData.uid,
        "driverImage": authCubit.authData.imageUrl,
        "driverName": authCubit.authData.username,
        "driverPhone": authCubit.authData.phoneNumber,
        "driverRatings": authCubit.authData.ratings.toString(),
        "driverRideCounts": authCubit.authData.totalRides.toString(),
        "distance": result["distance_km"],
        "duration": result["duration_minutes"],
        "rideStatus": "running",
      });
      
      googleMapCubit.getPolyPoints(
        acceptRideModel.pickupLatitude,
        acceptRideModel.pickupLongitude,
      );
      
      await FirebaseFirestore.instance
          .collection("accepted")
          .doc(authCubit.authData.uid)
          .collection("ride_detail")
          .doc(acceptRideModel.rideId)
          .delete();
          
      print("data updated successfully");
    } catch (e) {
      print("accept error is $e");
    }
  }

  Future<Map<String, double>> calculateDistanceAndDuration({
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double currentLatitude = currentPosition.latitude;
    double currentLongitude = currentPosition.longitude;

    double distanceInKm = _calculateHaversineDistance(
      currentLatitude,
      currentLongitude,
      destinationLatitude,
      destinationLongitude,
    );

    double averageSpeedKmh = 50;
    double durationInMinutes = (distanceInKm / averageSpeedKmh) * 60;

    return {
      'distance_km': distanceInKm,
      'duration_minutes': durationInMinutes.roundToDouble(),
    };
  }

  double _calculateHaversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double R = 6371;
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void removeRide(int index, BuildContext context) {
    emit(DriverRidesRequestsLoading(isSearchingForRides: state.isSearchingForRides));
    rides.removeAt(index);
    print("rides data length: ${rides.length}");
    if (rides.isEmpty) {
      Navigator.of(context).pop();
    }
    emit(DriverRidesRequestsSuccess(isSearchingForRides: state.isSearchingForRides));
  }

  Map<String, double> calculateDistanceAndTime(
      double latitude, double longitude) {
    final GoogleMapCubit googleMapCubit = Di().sl<GoogleMapCubit>();
    double distance = Geolocator.distanceBetween(
      googleMapCubit.currentLocation?.latitude ?? 0,
      googleMapCubit.currentLocation?.longitude ?? 0,
      latitude,
      longitude,
    );

    double time = (distance / 1000) / 50 * 60;

    return {
      'distance': distance / 1000,
      'time': time,
    };
  }

  Future<void> buildCircles(Color circleColor) async {
    final GoogleMapCubit googleMapCubit = Di().sl<GoogleMapCubit>();
    for (var i = 1; i <= 6; i++) {
      if (_shouldStop) {
        debugPrint("🛑 Circles stopped at iteration $i");
        break;
      }
      
      emit(DriverRidesRequestsLoading(isSearchingForRides: state.isSearchingForRides));
      debugPrint("circle length $i");
      await Future.delayed(const Duration(milliseconds: 600));
      
      String formattedNumber = '0.$i';
      var circle = Circle(
        circleId: CircleId("finding${i.toString()}"),
        radius: 100 * i.toDouble(),
        fillColor: circleColor.withOpacity(double.parse(formattedNumber)),
        strokeWidth: 0,
        strokeColor: AppColors.transparent,
        center: LatLng(
          googleMapCubit.currentLocation?.latitude ?? 0,
          googleMapCubit.currentLocation?.longitude ?? 0,
        ),
      );
      circles.add(circle);
      emit(DriverRidesRequestsSuccess(isSearchingForRides: state.isSearchingForRides));
      
      if (i == 6) {
        circles = {};
        if (!_shouldStop) {
          buildCircles(circleColor);
        }
      }
    }
  }

  void acceptedNotification() async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    notificationSubscription = AppConstants.firestore
        .collection("accepted")
        .doc(authCubit.authData.uid)
        .collection("ride_detail")
        .where("confirmRequest", isEqualTo: false)
        .snapshots()
        .listen(
      (event) {
        if (event.docs.isNotEmpty) {
          notificationList = event.docs.cast<Map<String, dynamic>>();
        }
      },
    );
  }
}