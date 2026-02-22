import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/confirm_ride_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/googlemap/booked_ride_map.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import '../../../../../utils/app_colors.dart';

final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();

class UserRideRequestDialoge extends StatefulWidget {
  const UserRideRequestDialoge({super.key});

  @override
  State<UserRideRequestDialoge> createState() => _UserRideRequestDialogeState();
}

class _UserRideRequestDialogeState extends State<UserRideRequestDialoge> {
  @override
  Widget build(BuildContext context) {
    print("rider dialog");
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: AppColors.transparent,
      child: SafeArea(
        child: BlocBuilder(
          bloc: _createRideCubit,
          builder: (context, state) {
            print("rider dialog ${_createRideCubit.driverAcceptedData.length}");
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1,
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(AppConstants.ridesKey)
                          .doc(_createRideCubit.newRideId)
                          .collection(AppConstants.ridesRequest)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // 🔥 ADD LOGGING
    print("📊 Stream update - Has data: ${snapshot.hasData}");
    print("📊 Ride ID: ${_createRideCubit.newRideId}");
    
    if (snapshot.hasData) {
      print("📊 Docs count: ${snapshot.data!.docs.length}");
      
      if (snapshot.data!.docs.isNotEmpty) {
        print("📊 First doc data: ${snapshot.data!.docs.first.data()}");
      }
      }
                         // Replace the empty docs section in UserRideRequestDialoge
// This puts UI at top and bottom, leaving middle transparent for circles

// Replace the empty docs section in UserRideRequestDialoge
// This puts UI at top and bottom, leaving middle transparent for circles

if (snapshot.data!.docs.isEmpty) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.8,
    child: Stack(
      children: [
        // Top banner - searching status
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xff1e2124).withOpacity(.9),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.borderColor, width: 2),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryDark,
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                        text: "Looking for drivers...",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(height: 3),
                      AppTextStyle(
                        text: "Searching nearby drivers",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryGreyColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Bottom cancel button - doesn't block circles
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // FIXED: Proper ride cancellation
      print("🔴 Canceling ride search...");
      
      try {
        // 1. Delete the ride from Firestore if it exists
        if (Di().sl<CreateRideCubit>().newRideId.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection(AppConstants.ridesKey)
              .doc(Di().sl<CreateRideCubit>().newRideId)
              .delete();
          print("✅ Ride deleted from Firestore");
        }
        
        // 2. Cancel any active subscriptions
        Di().sl<CreateRideCubit>().ridesSubscription?.cancel();
        print("✅ Subscriptions cancelled");
        
        // 3. Stop the search circles animation
        Di().sl<DriverRidesRequestsCubit>().stopCircles();
        print("✅ Search circles stopped");
        
        // 4. Close the dialog if it's open
        if (context.mounted) {
          Navigator.of(context).pop();
          print("✅ Dialog closed");
        }
        
        // 5. Reset UI state
        _ridingSectionCubit.toggleContent();
        print("✅ UI state reset");
        
      } catch (e) {
        print("❌ Error canceling ride: $e");
        // Still try to reset UI even if error occurs
        Di().sl<DriverRidesRequestsCubit>().stopCircles();
        _ridingSectionCubit.toggleContent();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
              },
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                decoration: BoxDecoration(
                  color: const Color(0xfff00d42),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xff8c1a35),
                    width: 2.6,
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  alignment: Alignment.center,
                  child: const AppTextStyle(
                    text: "Cancel Search",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
                         else {
                            var dataList = snapshot.data!.docs
                                .map((e) => AcceptRideModel.fromJson(e.data()))
                                .toList();
                            List<AcceptRideModel> requestList = dataList
                                .where((element) => element.isRejected != true)
                                .toList();

                            return requestList.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height: requestList.length * 150.0 <
                                            MediaQuery.of(context).size.height * 1.2
                                        ? MediaQuery.of(context).size.height * 1.2
                                        : requestList.length * 150.0,
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: List.generate(
                                        requestList.length,
                                        (index) {
                                          return Positioned(
                                            top: index * 50.0,
                                            left: 0,
                                            right: 0,
                                            child: Dismissible(
                                              key: Key(requestList[index].toString()),
                                              onDismissed: (direction) =>
                                                  requestList.removeAt(index),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: RiderDialougBox(
                                                    listOfModels: dataList,
                                                    acceptRideModel: requestList[index]),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                          }
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Rest of your RiderDialougBox and DialogBoxButton code stays the same...
class RiderDialougBox extends StatefulWidget {
  final AcceptRideModel acceptRideModel;
  final List<AcceptRideModel> listOfModels;
  const RiderDialougBox(
      {super.key, required this.acceptRideModel, required this.listOfModels});

  @override
  State<RiderDialougBox> createState() => _RiderDialougBoxState();
}

class _RiderDialougBoxState extends State<RiderDialougBox> {
  Timer? _timer;
  int _start = 300;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _start = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer?.cancel();
          if (mounted) {
            Navigator.of(context).pop();
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
    double mdWidth = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.all(mdWidth * .001),
      backgroundColor: Colors.transparent,
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
            padding: const EdgeInsets.only(top: 17, left: 11, right: 11, bottom: 17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 59,
                      width: 59,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryDark.withOpacity(0.5)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: widget.acceptRideModel.driverData.firstname,
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
                              const SizedBox(width: 6),
                              AppTextStyle(
                                text: "${widget.acceptRideModel.driverData.ratings} ",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                              AppTextStyle(
                                text: "(${widget.acceptRideModel.driverData.totalRides} rides)",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGreyColor.withOpacity(0.6),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                AppTextStyle(
                  text: "${widget.acceptRideModel.duration} min. ${widget.acceptRideModel.distance}km",
                  fontSize: 17.12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                Center(child: stackWidget(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTextStyle(
                      text: "ZAR ${widget.acceptRideModel.fare}",
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                    Row(
                      children: [
                        const AppTextStyle(
                          text: "Remaining time ",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                        AppTextStyle(
                          text: "$_start:00",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogBoxButton(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection(AppConstants.ridesKey)
                            .doc(widget.acceptRideModel.rideId)
                            .collection(AppConstants.ridesRequest)
                            .doc(widget.acceptRideModel.driverData.uid)
                            .delete();
                        Navigator.of(context).pop();
                      },
                      text: 'Decline',
                      textColor: AppColors.whiteColor,
                      bgColor: const Color(0xfff00d42),
                      borderColor: const Color(0xff8c1a35),
                    ),
                  // In user_ride_request_dialoge.dart, replace the Accept button logic:

// In user_ride_request_dialoge.dart, replace the Accept button logic:
// In user_ride_request_dialoge.dart, replace the Accept button logic:

DialogBoxButton(
  text: 'Accept',
  onTap: () async {
    try {
      var driver = widget.acceptRideModel.driverData;
      
      // 1. Update ride status to Running and assign driver
      await FirebaseFirestore.instance
          .collection('rides')
          .doc(widget.acceptRideModel.rideId)
          .update({
        'distance': widget.acceptRideModel.distance,
        'driverId': driver.uid,
        'driverImage': driver.imageUrl,
        'driverName': driver.username,
        'driverPhone': driver.phoneNumber,
        'driverRatings': driver.ratings.toString(),
        'driverRideCounts': driver.totalRides.toString(),
        'rideStatus': 'Running',
        'fare': widget.acceptRideModel.fare,
        // 🔥 NEW: Add vehicle info from driver's profile
        'vehicleType': driver.driverModel.carService ?? "BIKERIDES", // e.g., "CARRIDES", "BIKERIDES"
        'vehicleModel': driver.driverModel.carModel ?? "Unknown",
        'vehicleNumber': driver.driverModel.carNumberPlate ?? "N/A",
        'vehicleColor': driver.driverModel.carService ?? "",
      });
      
      // 2. Mark this offer as accepted
      await FirebaseFirestore.instance
          .collection('rides')
          .doc(widget.acceptRideModel.rideId)
          .collection('ridesRequest')
          .doc(driver.uid)
          .update({'isAccepted': true});
      
      // 3. Delete all other driver offers
      for (var data in widget.listOfModels) {
        if (data.driverData.uid != widget.acceptRideModel.driverData.uid) {
          await FirebaseFirestore.instance
              .collection('rides')
              .doc(data.rideId)
              .collection('ridesRequest')
              .doc(data.driverData.uid)
              .delete();
        }
      }
      
      // 4. Get updated ride data
      DocumentSnapshot<Map<String, dynamic>> snap =
          await FirebaseFirestore.instance
              .collection('rides')
              .doc(widget.acceptRideModel.rideId)
              .get();
      RideDataModel rideModel = RideDataModel.fromJson(snap.data()!);
      
      // 5. Stop search circles animation
      Di().sl<DriverRidesRequestsCubit>().stopCircles();
      
      // 6. Stop search circles animation
      Di().sl<DriverRidesRequestsCubit>().stopCircles();
      
      // 7. Close ALL search dialogs
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      
      // 8. ✨ Navigate to ride tracking page directly
      if (mounted) {
        // Option 1: Use BookedRideMap (full screen tracking)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookedRideMap(rideData: rideModel),
          ),
        );
        
        // Option 2: Or show the ride details dialog with tracking
        // (Uncomment this and comment Option 1 if you prefer dialog)
        /*
        await Future.delayed(const Duration(milliseconds: 300));
        DialogHelper.showGeDialog(
          context: context,
          dialog: RiderDetailDialoug(rideData: rideModel),
          barrierDismissible: false, // Prevent dismissing
        );
        */
      }
      
    } catch (e) {
      print("❌ Error accepting ride: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error accepting ride: $e")),
        );
      }
    }
  },
  textColor: AppColors.blackColor,
  bgColor: const Color(0xffffbc07),
  borderColor: const Color(0xff7a561c),
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

  Widget stackWidget(context) {
    return SizedBox(
      height: 100,
      width: 298,
      child: Stack(
        children: [
          Positioned(
            right: 1,
            child: Container(
              height: 94,
              width: 94,
              decoration: BoxDecoration(
                border: Border.all(width: 7, color: const Color(0xff323337)),
                shape: BoxShape.circle,
                color: const Color(0xff3c3e41),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 53,
                width: 272,
                decoration: BoxDecoration(
                  color: const Color(0xffffbc07),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AppTextStyle(
                            text: "Model name", fontSize: 18, fontWeight: FontWeight.w600)),
                    Container(
                        padding: const EdgeInsets.only(left: 6.1, right: 6.1),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4a4a4a),
                            width: 0.38,
                          ),
                          borderRadius: BorderRadius.circular(3.05),
                        ),
                        child: const AppTextStyle(
                            text: "Ko00u", fontSize: 11, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 25,
            top: 5,
            child: PhysicalModel(
              elevation: 20,
              color: AppColors.transparent,
              shadowColor: AppColors.blackColor,
              child: SizedBox(
                  height: 60,
                  child: Transform.rotate(
                      angle: -0.42,
                      child: Image.asset(
                        AppImages.carIcon,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogBoxButton extends StatelessWidget {
  const DialogBoxButton({
    super.key,
    required this.text,
    this.onTap,
    this.bgColor,
    required this.borderColor,
    required this.textColor,
  });
  final String text;
  final Color textColor;
  final Color? bgColor;
  final Color borderColor;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(11.7),
              border: Border.all(width: 2.6, color: borderColor)),
          child: AppTextStyle(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: textColor,
          )),
    );
  }
}

final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();