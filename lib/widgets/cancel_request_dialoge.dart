import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_dialoge.dart';
import 'package:hikespot/utils/app_text_style.dart';
import '../../../../../utils/app_colors.dart';


class CancelRequestDialoge extends StatelessWidget {
  const CancelRequestDialoge({super.key, required this.acceptRideModel, this.isNeedPop=false});
  final RideDataModel acceptRideModel;
final bool? isNeedPop;
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
                        child: Image.network(acceptRideModel.userimage),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: acceptRideModel.driverName,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                AppTextStyle(
                  text: "Cancel the Ride",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                        ],
                      ),
                    )
                  ],
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
                        text: 'Okay',
                        onTap: () async {
                          Navigator.pop(context);
                          await FirebaseFirestore.instance
                              .collection("rides")
                              .doc(acceptRideModel.rideId)
                              .update({"rideStatus":"Running"}).then((value) {
                                if(isNeedPop==true){
                                  Navigator.pop(context);
                                }
                              },);
                          final GoogleMapCubit _googleMapCubit =
                              Di().sl<GoogleMapCubit>();
                        },
                        textColor: AppColors.whiteColor,
                        bgColor: const Color(0xfff00d42),
                        borderColor: const Color.fromARGB(255, 120, 89, 96),
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
