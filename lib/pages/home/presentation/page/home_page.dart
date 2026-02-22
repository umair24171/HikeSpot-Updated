import 'dart:ui';
import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/captain-sheet/captain_working_sheet.dart';
import 'package:hikespot/pages/home/presentation/widgets/googlemap/google_map.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/riding_section.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/sizes.dart';
import '../bloc/cubit/google_map_cubit.dart';



@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: BlocBuilder(
        bloc: _ridingSectionCubit,
        builder: (context, mapState) {
          // 🔥 Dynamic map height based on state
          final mapHeight = 
          mapState is CaptainWorkingState 
              ? screenHeight * 0.75  // 80% when searching for driver
              :
               screenHeight * 0.5; // 50% normally
          
          return Stack(
            children: [
              // 🔥 MAP LAYER - Dynamic height
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: 0,
                left: 0,
                right: 0,
                height: mapHeight,
                child: const UserGoogleMap(),
              ),

              // 🔥 BOTTOM CONTENT AREA
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: mapHeight,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: AppColors.containerColor,
                  // 🔥 You can add your content widgets here
                ),
              ),

              // 🔥 REAL-TIME DRIVER TRACKING (For Users with Active Rides)
              if (_menueCubit.userState == AppState.user)
                StreamBuilder<QuerySnapshot>(
                  stream: AppConstants.firestore
                      .collection("rides")
                      .where('userId', isEqualTo: _authCubit.authData.uid)
                      .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    
                    RideDataModel activeRide = RideDataModel.fromJson(
                      snapshot.data!.docs.first.data() as Map<String, dynamic>
                    );
                    
                    return StreamBuilder<DocumentSnapshot>(
                      stream: AppConstants.firestore
                          .collection("users")
                          .doc(activeRide.driverId)
                          .snapshots(),
                      builder: (context, driverSnapshot) {
                        if (!driverSnapshot.hasData || !driverSnapshot.data!.exists) {
                          return const SizedBox.shrink();
                        }
                        
                        AuthModel driverData = AuthModel.fromJson(
                          driverSnapshot.data!.data() as Map<String, dynamic>
                        );
                        
                        _googleMapCubit.updateDriverMarkers(
                          activeRide.driverId,
                          driverData.latitude,
                          driverData.longitude,
                        );
                        
                        if (activeRide.rideStatus == 'Running' || 
                            activeRide.rideStatus == 'Arrived') {
                          _googleMapCubit.getPolyPoints(
                            activeRide.pickupLatitude,
                            activeRide.pickupLongitude,
                          );
                        } else if (activeRide.rideStatus == 'start_destination') {
                          _googleMapCubit.getPolyPoints(
                            activeRide.destinationLatitude,
                            activeRide.destinationLongitude,
                          );
                        }
                        
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),

              // 🔥 TOP BAR
              Positioned(
                top: 20,
                left: 27,
                right: 27,
                child: SafeArea(
                  child: BlocBuilder(
                    bloc: _googleMapCubit,
                    builder: (context, state) {
                      return state is RidingSectionHide
                          ? Row(
                              children: [
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryDark.withOpacity(0.37),
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      _googleMapCubit.changeRidingSectionVisibility(false);
                                    },
                                    icon: const Icon(Icons.arrow_back,
                                        color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryDark.withOpacity(0.37),
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      _menueCubit.changeMenuVisibility(true);
                                    },
                                    icon: const Icon(Icons.menu_rounded,
                                        color: AppColors.whiteColor),
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ),

              // 🔥 DISTANCE & FARE OVERLAY
              Positioned(
                top: 80,
                left: 20,
                child: BlocBuilder(
                  bloc: _googleMapCubit,
                  builder: (context, state) {
                    if (_googleMapCubit.routeDistanceInKm > 0 && 
                        _googleMapCubit.polylineCoordinates.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            const Icon(Icons.route_rounded, color: AppColors.whiteColor, size: 20),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextStyle(
                                  text: _googleMapCubit.routeDistanceText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                ),
                                AppTextStyle(
                                  text: "Estimated fare: R${(_googleMapCubit.routeDistanceInKm * 1.35).round()}",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              // 🔥 MAIN CONTENT (Riding Section, Location Button, Driver Buttons)
              BlocBuilder(
                bloc: _googleMapCubit,
                builder: (context, state) {
                  return Stack(
                    children: [
                      // USER: Riding Section
                      if (_menueCubit.userState == AppState.user)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          bottom: state is RidingSectionHide ? -screenHeight * 0.4 : 0,
                          left: 0,
                          right: 0,
                          child: const RidingSection(),
                        ),
                      
                      // Location Button
                      BlocBuilder(
                        bloc: _ridingSectionCubit,
                        builder: (context, state) {
                          return AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            bottom: state is RidingSectionHide
                                ? 30
                                : screenHeight * 0.43 + _ridingSectionCubit.locationButtonGap,
                            right: 20,
                            child: state is RidingSectionPayment
                                ? const SizedBox()
                                : Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryGreyColor.withOpacity(0.52),
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: () async {
                                        _googleMapCubit.changeRidingSectionVisibility(true);
                                        await _googleMapCubit.goToCurrentLocation();
                                      },
                                      icon: const Icon(
                                          Icons.location_searching_rounded,
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                          );
                        },
                      ),
                      
                      // 🔥 DRIVER BUTTONS
                      if (_menueCubit.userState == AppState.captain)
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("rides")
                              .where('driverId', isEqualTo: _authCubit.authData.uid)
                              .where('rideStatus', whereIn: ['Running', 'Arrived', 'start_destination'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return  Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    // 🔥 Add pointer events to ensure it's tappable
            color: Colors.transparent,
                                  child: CaptainWorkingSheet(isCaptain: true)),
                              );
                            }

                            RideDataModel activeRide = RideDataModel.fromJson(
                              snapshot.data!.docs.first.data() as Map<String, dynamic>
                            );

                            print("🚗 Driver has active ride! Status: ${activeRide.rideStatus}");

                            // 🔥 CASE 1: Going to pickup (Running)
                            if (activeRide.rideStatus == 'Running') {
                              print("📍 Showing 'I've Arrived' button");
                              
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_googleMapCubit.isArrived != 1) {
                                  _googleMapCubit.getPolyPoint(
                                    activeRide.pickupLatitude,
                                    activeRide.pickupLongitude,
                                  );
                                  _googleMapCubit.updateArrived(1, rideModel: activeRide);
                                }
                              });

                              return Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: AppColors.primaryDark.withOpacity(0.3),
                                    splashFactory: InkSparkle.splashFactory,
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () async {
                                      print("✅ Driver clicked 'I've Arrived'");
                                      await FirebaseFirestore.instance
                                          .collection("rides")
                                          .doc(activeRide.rideId)
                                          .update({"rideStatus": "Arrived"});
                                      _googleMapCubit.updateArrived(2, rideModel: activeRide);
                                    },
                                    child: Container(
                                      height: 54,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDark,
                                        borderRadius: BorderRadius.circular(11.77),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryDark.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const AppTextStyle(
                                        text: "I've Arrived at Pickup",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            // 🔥 CASE 2: Arrived at pickup (Arrived)
                            else if (activeRide.rideStatus == 'Arrived') {
                              print("⏰ Showing waiting overlay");
                              
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_googleMapCubit.isArrived != 2) {
                                  _googleMapCubit.updateArrived(2, rideModel: activeRide);
                                }
                              });

                              return Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Center(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 30),
                                        padding: const EdgeInsets.all(24),
                                        decoration: BoxDecoration(
                                          color: AppColors.containerColor,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: AppColors.primaryDark,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryDark.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.primaryDark,
                                                size: 48,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const AppTextStyle(
                                              text: "You've Arrived!",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.whiteColor,
                                            ),
                                            const SizedBox(height: 12),
                                            const AppTextStyle(
                                              text: "Waiting for passenger to confirm pickup...",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryGreyColor,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 24),
                                            const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryDark,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryDark.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.primaryDark.withOpacity(0.3),
                                                    ),
                                                    child: const Icon(
                                                      Icons.person,
                                                      color: AppColors.whiteColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppTextStyle(
                                                        text: activeRide.username,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.whiteColor,
                                                      ),
                                                      AppTextStyle(
                                                        text: activeRide.usernumber,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.primaryGreyColor,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            GestureDetector(
                                              onTap: () {
                                                print("📞 Call: ${activeRide.usernumber}");
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(vertical: 14),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryDark,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.phone, color: AppColors.blackColor, size: 20),
                                                    SizedBox(width: 8),
                                                    AppTextStyle(
                                                      text: "Call Passenger",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.blackColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            // 🔥 CASE 3: Going to destination (start_destination)
                            else if (activeRide.rideStatus == 'start_destination') {
                              print("🎯 Showing 'Finish Ride' button");
                              
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_googleMapCubit.isArrived != 1) {
                                  _googleMapCubit.getPolyPoint(
                                    activeRide.destinationLatitude,
                                    activeRide.destinationLongitude,
                                  );
                                  _googleMapCubit.updateArrived(1, rideModel: activeRide);
                                }
                              });

                              return Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.green.withOpacity(0.3),
                                    splashFactory: InkSparkle.splashFactory,
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () => _showFinishRideDialog(context, activeRide),
                                    child: Container(
                                      height: 54,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(11.77),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.green.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.flag_rounded, color: Colors.white, size: 24),
                                          SizedBox(width: 8),
                                          AppTextStyle(
                                            text: "Finish Ride",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                    ],
                  );
                },
              ),

              // 🔥 CUSTOM INFO WINDOW (constrained to map area)
            // 🔥 CUSTOM INFO WINDOW - Let it handle its own positioning
CustomInfoWindow(
  controller: _googleMapCubit.customInfoWindowController,
  height: 41,
  width: 230,
  offset: 50,
),
            ],
          );
        },
      ),
    );
  }

  // 🔥 FINISH RIDE DIALOG
  void _showFinishRideDialog(BuildContext context, RideDataModel ride) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flag_rounded, color: Colors.green, size: 64),
              ),
              const SizedBox(height: 20),
              const AppTextStyle(
                text: "Finish This Ride?",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const AppTextStyle(
                text: "Confirm that you have reached the destination.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryGreyColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppTextStyle(
                          text: "Passenger:",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreyColor,
                        ),
                        AppTextStyle(
                          text: ride.username,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppTextStyle(
                          text: "Fare:",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreyColor,
                        ),
                        AppTextStyle(
                          text: "R${ride.fare.toStringAsFixed(0)}",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.redColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.redColor),
                        ),
                        child: const AppTextStyle(
                          text: "Cancel",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await _finishRide(context, ride);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const AppTextStyle(
                          text: "Finish",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  // 🔥 FINISH RIDE METHOD
  Future<void> _finishRide(BuildContext context, RideDataModel ride) async {
    try {
      print("🏁 Finishing ride: ${ride.rideId}");
      
      await FirebaseFirestore.instance
          .collection("rides")
          .doc(ride.rideId)
          .update({
        'rideStatus': 'Completed',
        'rideEndDate': DateTime.now().toIso8601String(),
      });
      
      _googleMapCubit.updateArrived(0);
      _googleMapCubit.polylineCoordinates = [];
      
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text("Ride completed! 🎉"),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
      
      print("✅ Ride finished successfully");
      
    } catch (e) {
      print("❌ Error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    }
  }
}

final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();