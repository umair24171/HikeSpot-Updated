import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/confirm_ride_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_dialoge.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import '../../../../../utils/app_colors.dart';

class RideAcceptDialogue extends StatefulWidget {
  final RideDataModel acceptRideModel;
  final int index;
  const RideAcceptDialogue({
    super.key,
    required this.acceptRideModel,
    required this.index,
  });

  @override
  State<RideAcceptDialogue> createState() => _RideAcceptDialogueState();
}

class _RideAcceptDialogueState extends State<RideAcceptDialogue> {
  // Timer? _timer;
  // int _start = 15;

  // @override
  // void initState() {
  //   super.initState();

  //   _startTimer();
  // }

  // void _startTimer() {
  //   _timer?.cancel();
  //   _start = 15;
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_start > 0) {
  //         _start--;
  //       } else {
  //         _timer?.cancel();
  //         if (mounted) {
  //           _driverRidesRequestsCubit.removeRide(widget.index, context);
  //         }
  //       }
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

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
                        child: Image.network(widget.acceptRideModel.userimage),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: widget.acceptRideModel.username,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star_rounded,
                          //       color: AppColors.primaryDark,
                          //       size: 18,
                          //     ),
                          //     const SizedBox(
                          //       width: 6,
                          //     ),
                          //     AppTextStyle(
                          //       text: widget.acceptRideModel.userRatings,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w500,
                          //       color: AppColors.whiteColor,
                          //     ),
                          //     AppTextStyle(
                          //       text:
                          //           "(${widget.rideData.userRideCounts} rides)",
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w500,
                          //       color:
                          //           AppColors.primaryGreyColor.withOpacity(0.6),
                          //     ),
                          //   ],
                          // )
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: AppTextStyle(
                        text: widget.acceptRideModel.pickupAddress,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                      ),
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
                      AppImages.mapIcon,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: AppTextStyle(
                        text: widget.acceptRideModel.stepOverAddress,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                      ),
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
                      width: MediaQuery.of(context).size.width * .5,
                      child: AppTextStyle(
                        textAlign: TextAlign.left,
                        text: widget.acceptRideModel.destinationAddress,
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
                    AppTextStyle(
                      text: "ZAR ${widget.acceptRideModel.fare}",
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DialogBoxButton(
                        text: 'Cancel',
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("rides")
                              .doc(widget.acceptRideModel.rideId)
                              .update({"rideStatus": "Cancel"});
                          final GoogleMapCubit _googleMapCubit =
                              Di().sl<GoogleMapCubit>();
                        },
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
                        text: 'View Ride',
                        onTap: () async {
                          log("update ride strat");
                          await FirebaseFirestore.instance
                              .collection("rides")
                              .doc(widget.acceptRideModel.rideId)
                              .update({"rideStatus": "Start"});
                              
                          final GoogleMapCubit _googleMapCubit =
                              Di().sl<GoogleMapCubit>();
                          _googleMapCubit.getPolyPoint(
                              widget.acceptRideModel.pickupLatitude,
                              widget.acceptRideModel.pickupLongitude);
                              _googleMapCubit.updateArrived(1,rideModel:widget.acceptRideModel );
                          // _driverRidesRequestsCubit
                          //     .confirmRideByRider(widget.acceptRideModel);
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
}

final DriverRidesRequestsCubit _driverRidesRequestsCubit =
    Di().sl<DriverRidesRequestsCubit>();
