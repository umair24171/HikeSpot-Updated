import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/googlemap/booked_ride_map.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/widgets/accept_confirm_ride.dart';
import 'package:hikespot/widgets/cancel_request_dialoge.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/sizes.dart';
import '../../../home/presentation/bloc/cubit/menue_cubit.dart';
import '../../../home/presentation/widgets/menue/menue.dart';

@RoutePage()
class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool _isBackPressedOnce = false;
  Timer? _backPressTimer;
 @override
void initState() {
  super.initState();
  
  // Initialize notification listener
  _driverCubitNotification.acceptedNotification();
  
  // ✨ NEW: Check for active rides on app startup
  _checkForActiveRides();
}

// ✨ NEW: Check for active rides when app starts
void _checkForActiveRides() {
  if (_menueCubit.userState == AppState.user) {
    // User side: Check if user has an active ride
    _checkUserActiveRide();
  } else {
    // Driver side: Check if driver has an active ride
    _checkDriverActiveRide();
  }
}
// ✨ USER SIDE: Check for active rides
void _checkUserActiveRide() async {
  try {
    final snapshot = await AppConstants.firestore
        .collection("rides")
        .where('userId', isEqualTo: authCubit.authData.uid)
        .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
        .limit(1)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      // User has an active ride!
      RideDataModel activeRide = RideDataModel.fromJson(
        snapshot.docs.first.data()
      );
      
      print("🚗 Active ride found! Status: ${activeRide.rideStatus}");
      
      // Navigate to ride tracking screen after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookedRideMap(rideData: activeRide),
            ),
          );
        }
      });
    } else {
      print("✅ No active rides");
    }
  } catch (error) {
    // ✅ Silently handle error - don't show popup (Firebase already did)
    print("❌ Error checking active rides: $error");
    // Network error - user will see Firebase's native error, no need to show another
  }
}

// ✨ DRIVER SIDE: Check for active rides
void _checkDriverActiveRide() async {
  try {
    final snapshot = await AppConstants.firestore
        .collection("rides")
        .where('driverId', isEqualTo: authCubit.authData.uid)
        .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
        .limit(1)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      // Driver has an active ride!
      RideDataModel activeRide = RideDataModel.fromJson(
        snapshot.docs.first.data()
      );
      
      print("🚗 Driver has active ride! Status: ${activeRide.rideStatus}");
      
      // Set up navigation state based on ride status
      if (activeRide.rideStatus == 'Running') {
        // Driver going to pickup
        _googleMapCubit.updateArrived(1, rideModel: activeRide);
        _googleMapCubit.getPolyPoint(
          activeRide.pickupLatitude,
          activeRide.pickupLongitude,
        );
      } else if (activeRide.rideStatus == 'Arrived') {
        // Driver waiting at pickup
        _googleMapCubit.updateArrived(2, rideModel: activeRide);
      } else if (activeRide.rideStatus == 'start_destination') {
        // Driver going to destination
        _googleMapCubit.updateArrived(1, rideModel: activeRide);
        _googleMapCubit.getPolyPoint(
          activeRide.destinationLatitude,
          activeRide.destinationLongitude,
        );
      }
    } else {
      print("✅ No active rides");
    }
  } catch (error) {
    // ✅ Silently handle error - don't show popup (Firebase already did)
    print("❌ Error checking active rides: $error");
    // Network error - user will see Firebase's native error, no need to show another
  }
}


  void _listenToUserRideStatus() {
    AppConstants.firestore
        .collection("rides")
        .where('userId', isEqualTo: authCubit.authData.uid)
        .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
        .snapshots()
        .listen((snapshot) {
      
      if (snapshot.docs.isNotEmpty) {
        RideDataModel activeRide = RideDataModel.fromJson(
          snapshot.docs.first.data()
        );
        
        print("👤 User has active ride: ${activeRide.rideStatus}");
        
        // Make sure UI shows map, not search dialogs
        if (_ridingSectionCubit.state is! RidingSectionEntranceContent) {
          _ridingSectionCubit.showEntranceContent();
        }
        
        // Track driver's location and show route
        _trackDriverForUser(activeRide);
      }
    });
  }

  void _trackDriverForUser(RideDataModel ride) {
    // Listen to driver's real-time location
    AppConstants.firestore
        .collection("users")
        .doc(ride.driverId)
        .snapshots()
        .listen((driverDoc) {
      
      if (driverDoc.exists) {
        AuthModel driverData = AuthModel.fromJson(
          driverDoc.data() as Map<String, dynamic>
        );
        
        // Update driver marker on map
        _googleMapCubit.updateDriverMarkers(
          ride.driverId,
          driverData.latitude,
          driverData.longitude,
        );
        
        // Show route based on ride status
        if (ride.rideStatus == 'Running') {
          // Driver is coming to pickup
          _googleMapCubit.getPolyPoints(
            ride.pickupLatitude,
            ride.pickupLongitude,
          );
        } else if (ride.rideStatus == 'start_destination') {
          // Driver is going to destination
          _googleMapCubit.getPolyPoints(
            ride.destinationLatitude,
            ride.destinationLongitude,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _backPressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_ridingSectionCubit.state is! RidingSectionEntranceContent) {
          _ridingSectionCubit.onPopScope();
        } else {
          if (_isBackPressedOnce) {
            SystemNavigator.pop();
          } else {
            _isBackPressedOnce = true;
            // WarningHelper.showToast(context, message: "Tap Again To Close");

            _backPressTimer?.cancel();
            _backPressTimer = Timer(const Duration(seconds: 2), () {
              _isBackPressedOnce = false;
            });
          }
        }
      },
      child: BlocBuilder(
        bloc: _menueCubit,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              _menueCubit.changeMenuVisibility(false);
            },
            child: Scaffold(
              backgroundColor: AppColors.bgColor,
              body: Stack(
                children: [
                  if (_menueCubit.userState == AppState.user)
                    _menueCubit.screens[_menueCubit.currentIndex],
                  if (_menueCubit.userState == AppState.captain)
                    _menueCubit.riderScreen[_menueCubit.currentIndex],
                  BlocBuilder(
                      bloc: _menueCubit,
                      builder: (context, state) {
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          top: _menueCubit.showMenu
                              ? -getHeight(context) * 0.4
                              : 0,
                          left: 0,
                          right: 0,
                          child: const DownMenue(),
                        );
                      }),
                 if (_menueCubit.userState == AppState.captain)
  StreamBuilder(
    stream: AppConstants.firestore
        .collection("rides")
        .where('rideStatus', isEqualTo: RideStatus.Pending.name)
        // 🔥 REMOVED orderBy to avoid index requirement for now
        // .orderBy('rideStartDate', descending: true) 
        .snapshots(),
    builder: (context, snapshot) {
      // ✅ Handle errors silently - Firebase already shows error dialog
      if (snapshot.hasError) {
        print("❌ StreamBuilder error: ${snapshot.error}");
        return const SizedBox(); // Hide dialog on error
      }
      
      if (snapshot.hasData) {
        if (snapshot.data!.docs.isEmpty) {
          return const SizedBox();
        } else {
          List<RideDataModel> rideDataModelList = snapshot.data!.docs
              .map((e) => RideDataModel.fromJson(e.data()))
              .toList();
          
          // 🔥 NEW: Filter by time with FLEXIBLE date parsing
          final DateTime now = DateTime.now();
          final DateTime fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
          
          rideDataModelList = rideDataModelList.where((element) {
            try {
              DateTime rideTime;
              
              // 🔥 Try ISO format first (new rides)
              try {
                rideTime = DateTime.parse(element.rideStartDate);
              } catch (e) {
                // 🔥 If ISO fails, try parsing old format "25/10/2025"
                List<String> parts = element.rideStartDate.split('/');
                if (parts.length == 3) {
                  int day = int.parse(parts[0]);
                  int month = int.parse(parts[1]);
                  int year = int.parse(parts[2]);
                  rideTime = DateTime(year, month, day);
                } else {
                  print("❌ Cannot parse date: ${element.rideStartDate}");
                  return false;
                }
              }
              
              bool isRecent = rideTime.isAfter(fiveMinutesAgo);
              return isRecent;
            } catch (e) {
              print("❌ Error parsing ride time: ${e.toString()}");
              return false;
            }
          }).toList();
          
          // 🔥 Sort manually by date (newest first)
          rideDataModelList.sort((a, b) {
            try {
              DateTime aTime = DateTime.parse(a.rideStartDate);
              DateTime bTime = DateTime.parse(b.rideStartDate);
              return bTime.compareTo(aTime); // Descending
            } catch (e) {
              return 0;
            }
          });
          
          // Distance filter
          final double driverLat = authCubit.authData.driverModel.latitude;
          final double driverLng = authCubit.authData.driverModel.longitude;
          
          rideDataModelList = rideDataModelList.where((element) {
            double distance = Geolocator.distanceBetween(
              driverLat,
              driverLng,
              element.pickupLatitude,
              element.pickupLongitude,
            );
            double distanceInKm = distance / 1000;
            print("📍 Ride distance: ${distanceInKm.toStringAsFixed(1)} km");
            return distanceInKm <= 300;
          }).toList();
          
          print("🚗 Found ${rideDataModelList.length} pending rides nearby");
          
          return rideDataModelList.isNotEmpty
              ? Stack(
                  children: List.generate(
                    rideDataModelList.length > 3 ? 3 : rideDataModelList.length,
                    (index) {
                      var rideDataModel = rideDataModelList[index];
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Center(
                            child: RideAcceptDialogue(
                              acceptRideModel: rideDataModel,
                              index: index,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox();
        }
      } else {
        return const SizedBox();
      }
    },
  ),
                 
                  if (_menueCubit.userState == AppState.user)
                    StreamBuilder(
                        stream: AppConstants.firestore
                            .collection("rides")
                            .where('userId', isEqualTo: authCubit.authData.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          // ✅ Handle errors silently - Firebase already shows error dialog
                          if (snapshot.hasError) {
                            print("❌ User rides StreamBuilder error: ${snapshot.error}");
                            return const SizedBox(); // Hide dialog on error
                          }
                          
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return SizedBox();
                            } else {
                              List<RideDataModel> rideDataModelList =
                                  snapshot.data!.docs
                                      .map(
                                        (e) => RideDataModel.fromJson(e.data()),
                                      )
                                      .toList();
                              rideDataModelList = rideDataModelList
                                  .where(
                                    (element) => element.rideStatus == "Cancel",
                                  )
                                  .toList();
                              return rideDataModelList.isNotEmpty
                                  ? Stack(
                                      children: List.generate(
                                          1, (index) {
                                        var rideDataModel =
                                            rideDataModelList[index];
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Center(
                                              child: CancelRequestDialoge(
                                                acceptRideModel: rideDataModel,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  : SizedBox();
                            }
                          } else {
                            return SizedBox();
                          }
                        }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final AuthCubit authCubit = Di().sl<AuthCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final DriverRidesRequestsCubit _driverCubitNotification =
    Di().sl<DriverRidesRequestsCubit>();
    final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
