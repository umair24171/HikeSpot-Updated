import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/googlemap/booked_ride_map.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/cancel_request_dialoge.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../realease-payment/presentation/page/realease_payment_page.dart';

class RiderDetailDialoug extends StatelessWidget {
  final RideDataModel rideData;
  const RiderDetailDialoug({super.key, required this.rideData});

  @override
  Widget build(BuildContext context) {

   String _getVehicleIcon(String vehicleType) {
  // Map vehicle types to their image assets
  switch (vehicleType.toUpperCase()) {
    case 'CARRIDES':
    case 'CAR':
      return AppImages.carImageService;
    
    case 'BIKERIDES':
    case 'BIKE':
    case 'MOTORCYCLE':
      return AppImages.bikeTypeIcon;
    
    case 'SUVRIDES':
    case 'SUV':
      return AppImages.suvIcon;
    
    case 'HEAVYDUITYTRACKRIDES':
    case 'TRUCK':
    case 'TRACK':
      return AppImages.truckImage;
    
    case 'TUKTUKRIDES':
    case 'TUKTUK':
    case 'RICKSHAW':
      return AppImages.rickshawIcon;
    
    case 'UTILITYRIDES':
    case 'UTILITY':
      return AppImages.suvIcon; // Using SUV icon for utility
    
    case 'DOUBLECABRIDES':
    case 'DOUBLECAB':
    case 'CABS':
      return AppImages.doubleCab;
    
    case 'TAXIRIDES':
    case 'TAXI':
      return AppImages.taxiImage;
    
    default:
      // Default to bike if vehicle type is unknown
      return AppImages.bikeTypeIcon;
  }
}
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      surfaceTintColor: AppColors.transparent,
      child: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: 310,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                   StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore.instance
      .collection("users")
      .doc(rideData.driverId)
      .snapshots(),
  builder: (context, snapshot) {
    // Default values if data not available
    String vehicleModel = "Bike";
    String vehicleNumber = "N/A";
    String vehicleType = "BIKE";
    
    if (snapshot.hasData && snapshot.data!.exists) {
      try {
        AuthModel driverData = AuthModel.fromJson(
          snapshot.data!.data() as Map<String, dynamic>
        );
        vehicleModel = driverData.driverModel.carModel;
        vehicleNumber = driverData.driverModel.carNumberPlate;
        vehicleType = driverData.driverModel.carService;
      } catch (e) {
        print("Error parsing driver data: $e");
      }
    }
    
    return Stack(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 94,
                decoration: BoxDecoration(
                  color: const Color(0xff424244).withOpacity(.6),
                  borderRadius: BorderRadius.circular(25)
                ),
                padding: const EdgeInsets.only(
                  top: 17, left: 11, right: 11, bottom: 17
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppTextStyle(
                          text: "Vehicle Details",
                          fontSize: 18,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600
                        ),
                        AppTextStyle(
                          text: vehicleModel,
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500
                        ),
                        AppTextStyle(
                          text: vehicleNumber,
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500
                        ),
                      ],
                    ),
                  ]
                ),
              ),
            ),
          ),
        ),
        // Show appropriate vehicle icon based on type
        Positioned(
          top: 0,
          child: Image.asset(
            _getVehicleIcon(vehicleType),
            height: 94,
            width: 164,
            fit: BoxFit.contain,
          )
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryDark.withOpacity(0.37)
            ),
            child: IconButton(
              onPressed: () {
                // Share ride details
              },
              icon: SvgPicture.asset(AppImages.shareIcon)
            ),
          ),
        ),
      ],
    );
  },
),

                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryDark.withOpacity(0.37)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(AppImages.shareIcon)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 51,
                            decoration: BoxDecoration(
                                color: const Color(0xff424244).withOpacity(.6),
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                top: 17, left: 11, right: 11, bottom: 17),
                            // width: 322,
                            child: AppTextStyle(
                                text:
                                    "Your Driver is Arriving In ${rideData.duration} Minutes from Now",
                                fontSize: 12,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DriverDetailWidget(
                        personDetail: false,
                        showRideDetail: true,
                        rideData: rideData,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureContainer(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => BookedRideMap(rideData: rideData),));
                            },
                            text: '0',
                            borderRadius: 12,
                            customWidget: Row(
                              children: [
                                const AppTextStyle(
                                  text: 'View Ride',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                SvgPicture.asset(AppImages.handelIcon),
                              ],
                            ),
                          ),
                          GestureContainer(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReleasePayment(),
                                )),
                            text: ' Cancel Ride ',
                            borderRadius: 12,
                            buttonColor: AppColors.redColor,
                            borderColor: AppColors.borderColorRed,
                            isNeedArrow: false,
                            textSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
            if (_menueCubit.userState == AppState.user)
                    StreamBuilder(
                        stream: AppConstants.firestore
                            .collection("rides")
                            .where('userId', isEqualTo: authCubit.authData.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
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
  }
}

class DriverDetailWidget extends StatelessWidget {
  final RideDataModel rideData;
  const DriverDetailWidget(
      {super.key,
      required this.showRideDetail,
      required this.personDetail,
      required this.rideData});
  final bool showRideDetail;
  final bool personDetail;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.whiteColor),
              color: const Color(0xff424244).withOpacity(.6),
              borderRadius: BorderRadius.circular(25)),
          padding:
              const EdgeInsets.only(top: 17, left: 11, right: 11, bottom: 17),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 7),
                width: 38,
                height: 6,
                decoration: BoxDecoration(
                    color: const Color(0xffffbc07),
                    borderRadius: BorderRadius.circular(100)),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.39, color: const Color(0xff837879))),
                    child: Container(
                      height: 78,
                      width: 78,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryDark.withOpacity(0.8)),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTextStyle(
                        text: 'Driver Details',
                        fontSize: 15,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const AppTextStyle(
                              text: 'Name : ',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.whiteColor),
                          AppTextStyle(
                              text: rideData.driverName,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const AppTextStyle(
                              text: 'Ph No : ',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.whiteColor),
                          AppTextStyle(
                              text: rideData.driverPhone,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.whiteColor),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: getHeight(context) * .01,
              ),
              personDetail == false
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(AppImages.enteranceIcon),
                            dashBorder(3),
                            dashBorder(8),
                            SvgPicture.asset(AppImages.mapIcon),
                            dashBorder(3),
                            dashBorder(8),
                            dashBorder(3),
                            SvgPicture.asset(AppImages.lineIcon),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              alignment: Alignment.centerLeft,
                              height: getHeight(context) * .06,
                              width: getWidth(context) * .73,
                              child: AppTextStyle(
                                  text: rideData.pickupAddress,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              alignment: Alignment.centerLeft,
                              height: getHeight(context) * .06,
                              width: getWidth(context) * .73,
                              child: AppTextStyle(
                                  text: rideData.stepOverAddress,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              alignment: Alignment.centerLeft,
                              height: getHeight(context) * .06,
                              width: getWidth(context) * .73,
                              child: AppTextStyle(
                                  text: rideData.destinationAddress,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor),
                            ),
                          ],
                        )
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              showRideDetail == false
                  ? const SizedBox()
                  : const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.borderColor,
                    ),
              const SizedBox(
                height: 10,
              ),
              showRideDetail == false
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppTextStyle(
                                text: 'Ride Details',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark),
                            const SizedBox(height: 13),
                            Row(
                              children: [
                                const AppTextStyle(
                                  text: 'Total No of Rides : ',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.whiteColor,
                                ),
                                AppTextStyle(
                                  text: rideData.driverRideCounts,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                            const SizedBox(height: 13),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 15,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.primaryDark,
                                        size: 15,
                                      );
                                    },
                                  ),
                                ),
                                AppTextStyle(
                                  text:
                                      '( ${rideData.driverRatings} + Ratings )',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                            const SizedBox(height: 13),
                            const AppTextStyle(
                              text: 'Chat the Driver',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.borderColor,
                                        spreadRadius: 3,
                                        blurRadius: 10),
                                  ],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: AppColors.borderColor)),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                width: 41,
                                height: 41,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xff767677))),
                                child: SvgPicture.asset(AppImages.callIcon),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 18,
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColors.borderColor,
                                          spreadRadius: 3,
                                          blurRadius: 10),
                                    ],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2, color: AppColors.borderColor)),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  width: 41,
                                  height: 41,
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2,
                                          color: const Color(0xff767677))),
                                  child: SvgPicture.asset(AppImages.messageIcon),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Widget dashBorder(double height) {
  return Container(
    margin: const EdgeInsets.only(top: 3, bottom: 3),
    width: 2,
    height: height,
    color: AppColors.primaryDark,
  );
}

final AuthCubit authCubit = Di().sl<AuthCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();
