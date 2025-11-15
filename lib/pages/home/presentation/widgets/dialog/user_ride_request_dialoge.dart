import 'dart:async';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/confirm_ride_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import '../../../../../utils/app_colors.dart';

class UserRideRequestDialoge extends StatefulWidget {
  const UserRideRequestDialoge({super.key});

  @override
  State<UserRideRequestDialoge> createState() => _UserRideRequestDialogeState();
}

class _UserRideRequestDialogeState extends State<UserRideRequestDialoge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: AppColors.transparent,
      child: SafeArea(
        child: BlocBuilder(
          bloc: _driverRidesRequestsCubit,
          builder: (context, state) {
          return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1, // list height 
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height:_driverRidesRequestsCubit.rides.length * 150.0<MediaQuery.of(context).size.height*1.2?MediaQuery.of(context).size.height*1.2:_driverRidesRequestsCubit.rides.length * 150.0, // Adjust height dynamically
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: List.generate(
                        _driverRidesRequestsCubit.rides.length,
                        (index) {
                          return Positioned(
                            top: index * 50.0, // Stack items with spacing
                            left: 0,
                            right: 0,
                            child: Dismissible(
                              key: Key(_driverRidesRequestsCubit.rides[index].toString()),
                              onDismissed: (direction) =>
                                  _driverRidesRequestsCubit.removeRide(index, context),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RideRequestContainer(
                                  rideData: _driverRidesRequestsCubit.rides[index],
                                  index: index,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ); },
        ),
      ),
    );
  }
}


class RideRequestContainer extends StatefulWidget {
  final RideDataModel rideData;
  final int index;
  const RideRequestContainer({
    super.key,
    required this.rideData,
    required this.index,
  });

  @override
  State<RideRequestContainer> createState() => _RideRequestContainerState();
}

class _RideRequestContainerState extends State<RideRequestContainer> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _start = 15;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _start = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer?.cancel();
          if (mounted) {
            _driverRidesRequestsCubit.removeRide(widget.index, context);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.containerColor.withOpacity(0.4),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 320,
            decoration: BoxDecoration(
                color: const Color(0xff1e2124).withOpacity(.6),
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(25)),
            padding:
                const EdgeInsets.only(top: 17, left: 11, right: 11, bottom: 17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 59,
                        width: 59,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDark.withOpacity(0.5)),
                        child: Image.network(widget.rideData.userimage),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: widget.rideData.username,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryDark,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              AppTextStyle(
                                text: widget.rideData.userRatings,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                              AppTextStyle(
                                text:
                                    "(${widget.rideData.userRideCounts} rides)",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    AppColors.primaryGreyColor.withOpacity(0.6),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.enteranceIcon,
                      height: 20,
                      width: 20,
                    ),
                    AppTextStyle(
                      text: widget.rideData.pickupAddress,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                // 🔥 UPDATE YOUR RideRequestContainer in driver ride request dialog
// Add this section after the pickup/destination addresses

// Inside the RideRequestContainer build method, after showing the addresses:

// Show different info based on ride type
BlocBuilder(
  bloc: _createRideCubit,
  builder: (context, state) {
    if (widget.rideData.isParcelDelivery) {
      // 🔥 PARCEL DELIVERY INFO
      return Column(
        children: [
          const SizedBox(height: 10),
          // Parcel badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_shipping_rounded, color: Colors.orange, size: 16),
                SizedBox(width: 6),
                AppTextStyle(
                  text: "Parcel Delivery",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Parcel details container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, 
                         color: AppColors.primaryDark, size: 16),
                    const SizedBox(width: 8),
                    const AppTextStyle(
                      text: "Parcel Size: ",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGreyColor,
                    ),
                    AppTextStyle(
                      text: widget.rideData.parcelSize,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, color: AppColors.borderColor),
                const SizedBox(height: 8),
                const AppTextStyle(
                  text: "Receiver Details:",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person_outline, 
                         color: AppColors.whiteColor, size: 14),
                    const SizedBox(width: 6),
                    AppTextStyle(
                      text: widget.rideData.receiverName,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, 
                         color: AppColors.whiteColor, size: 14),
                    const SizedBox(width: 6),
                    AppTextStyle(
                      text: widget.rideData.receiverPhone,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // 🔥 HITCHHIKING INFO (existing passenger info)
      return const SizedBox.shrink();
      // Or show passenger count if you want:
      // return widget.rideData.passengerCounts > 0
      //     ? Container with passenger info
      //     : SizedBox.shrink();
    }
  },
),

const SizedBox(height: 10),

// Then continue with fare and buttons...
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      dashBorder(2),
                      dashBorder(3),
                      dashBorder(3),
                      dashBorder(2),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.mapIcon,
                      height: 20,
                      width: 20,
                    ),
                    AppTextStyle(
                      text: widget.rideData.stepOverAddress,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      dashBorder(2),
                      dashBorder(3),
                      dashBorder(3),
                      dashBorder(2),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.lineIcon,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.7,
                      child: AppTextStyle(
                        textAlign: TextAlign.left,
                        text: widget.rideData.destinationAddress,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: "ZAR ${widget.rideData.fare}",
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                        const AppTextStyle(
                          text: "Offered fare by customer",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const AppTextStyle(
                          text: "Remaining time ",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                        AppTextStyle(
                          text: "00:$_start",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(11.7),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: getWidth(context),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.7),
                          color: AppColors.primaryGreyColor.withOpacity(0.22)),
                      child: AppTextStyle(
                        text: widget.rideData.comment,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                LocationSearchField(
                  hintText: "",
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  prefixIcon: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextStyle(
                        text: " ZAR ",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DialogBoxButton(
                        text: 'Decline',
                        onTap: () => context.router.pop(),
                        textColor: AppColors.whiteColor,
                        bgColor: const Color(0xfff00d42),
                        borderColor: const Color(0xff8c1a35),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DialogBoxButton(
  text: 'Send Offer',
  onTap: () async {
    // 1. Send the offer to Firestore
    _driverRidesRequestsCubit.sendOffer(
        widget.rideData.rideId,
        _controller.text,
        context);
    
    // 2. Close this dialog
    Navigator.of(context).pop();
    
    // 3. Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Offer sent! Waiting for user acceptance..."),
        duration: Duration(seconds: 2),
      ),
    );
    
    // 4. Start listening for ride acceptance
    _listenForRideAcceptance(widget.rideData.rideId);
  },
  textColor: AppColors.blackColor,
  bgColor: const Color(0xffffbc07),
  borderColor: const Color(0xff7a561c),
),

                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _listenForRideAcceptance(String rideId) {
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  
  FirebaseFirestore.instance
      .collection("rides")
      .doc(rideId)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.exists) {
      RideDataModel ride = RideDataModel.fromJson(snapshot.data()!);
      
      // Check if this driver was accepted
      if (ride.driverId == authCubit.authData.uid && 
          ride.rideStatus == "Running") {
        
        print("🎉 User accepted your ride! Navigating to pickup...");
        
        // 1. Stop the circle animations
        Di().sl<DriverRidesRequestsCubit>().stopCircles();
        
        // 2. Close any open dialogs
        Navigator.of(context).popUntil((route) => route.isFirst);
        
        // 3. Set up navigation to pickup location
        Di().sl<GoogleMapCubit>().updateArrived(1, rideModel: ride);
        Di().sl<GoogleMapCubit>().getPolyPoint(
          ride.pickupLatitude, 
          ride.pickupLongitude
        );
        
        // 4. Show navigation UI
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ride accepted! Navigate to pickup location"),
            backgroundColor: AppColors.primaryDark,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  });
}
}

final DriverRidesRequestsCubit _driverRidesRequestsCubit =
    Di().sl<DriverRidesRequestsCubit>();
final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();