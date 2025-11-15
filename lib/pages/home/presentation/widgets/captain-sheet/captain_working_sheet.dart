import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/user_ride_request_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/riding_section.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';

class CaptainWorkingSheet extends StatefulWidget {
  final bool isCaptain;
  const CaptainWorkingSheet({super.key, required this.isCaptain});

  @override
  State<CaptainWorkingSheet> createState() => _CaptainWorkingSheetState();
}

class _CaptainWorkingSheetState extends State<CaptainWorkingSheet> {
  Widget captainWorkingSheet() {
    return BlocBuilder(
      bloc: _authCubit,
      builder: (context, state) {
        return Column(
          children: [
            if (widget.isCaptain == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppTextStyle(
                    text: "Turn on duty mode",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                  InkWell(
                      onTap: () {
                        _authCubit.turnOnDuty(context);
                        _driverRidesRequestsCubit.stopCircles();
                      },
                      child: SvgPicture.asset(
                          _authCubit.authData.driverModel.isOnDuty
                              ? AppImages.switchOn
                              : AppImages.switchOff)),
                ],
              ),
            if (_authCubit.authData.driverModel.isOnDuty)
              SizedBox(
                height: getHeight(context) * 0.037,
              ),
            if (_authCubit.authData.driverModel.isOnDuty ||
                widget.isCaptain == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppTextStyle(
                    text: "Add search range",
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      _ridingSectionCubit.toggleCaptainWorking();
                    },
                    child: Container(
                      height: 30,
                      width: 116,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.secContainerColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const AppTextStyle(
                        text: "Entrance",
                        fontSize: 16,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: getHeight(context) * 0.040,
            ),
           GestureContainer(
  text: widget.isCaptain == false ? "" : "Find customer",
  isNeedArrow: false,
  isValidate: _authCubit.authData.driverModel.isOnDuty ||
      widget.isCaptain == false,
  borderColor: widget.isCaptain == false
      ? AppColors.transparent
      : AppColors.transparent,
  textColor: _authCubit.authData.driverModel.isOnDuty
      ? AppColors.blackColor
      : AppColors.whiteColor,
  buttonColor: widget.isCaptain == false
      ? AppColors.transparent
      : AppColors.primaryDark,
  onTap: () async {
    if (widget.isCaptain == false) {
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
        
        // // 4. Close the dialog if it's open
        // if (context.mounted) {
        //   Navigator.of(context).pop();
        //   print("✅ Dialog closed");
        // }
        
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
    } else {
      // Driver side - Find customer
      _driverRidesRequestsCubit.checkRidesInEntrance();
      DialogHelper.showGeDialog(
          context: context, dialog: const UserRideRequestDialoge());
    }
  },
),
        
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _ridingSectionCubit,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: state is RidingSectionEntranceContent
                  ? const Offset(-1.0, 0.0)
                  : const Offset(2.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: Container(
              width: getWidth(context),
              padding: const EdgeInsets.only(
                  top: 41, left: 25, right: 25, bottom: 20),
              decoration: BoxDecoration(
                color: widget.isCaptain == false
                    ? AppColors.transparent
                    : AppColors.containerColor,
                border: widget.isCaptain == false
                    ? null
                    : Border(
                        top: BorderSide(
                          color: AppColors.borderColor.withOpacity(0.37),
                          width: 1,
                        ),
                      ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: state is CaptainWorkingState
                  ? captainWorkingSheet()
                  : buildSecondaryContent()),
        );
      },
    );
  }
}

final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
final DriverRidesRequestsCubit _driverRidesRequestsCubit =
    Di().sl<DriverRidesRequestsCubit>();
