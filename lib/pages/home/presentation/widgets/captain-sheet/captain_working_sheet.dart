import 'dart:developer';

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
          
          // 🔥 WRAP IN BLOCBUILDER TO LISTEN TO STATE CHANGES
         // 🔥 ADD TYPE PARAMETERS: BlocBuilder<CubitType, StateType>
BlocBuilder<DriverRidesRequestsCubit, DriverRidesRequestsState>(
  bloc: _driverRidesRequestsCubit,
  builder: (context, state) {
    final bool isSearching = state.isSearchingForRides;
    final bool isEnabled = _authCubit.authData.driverModel.isOnDuty || widget.isCaptain == false;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? () async {
          if (widget.isCaptain == false) {
            // User side - Cancel ride request
            print("🔴 User canceling ride search...");
            
            try {
              if (Di().sl<CreateRideCubit>().newRideId.isNotEmpty) {
                await FirebaseFirestore.instance
                    .collection(AppConstants.ridesKey)
                    .doc(Di().sl<CreateRideCubit>().newRideId)
                    .delete();
                print("✅ Ride deleted from Firestore");
              }
              
              Di().sl<CreateRideCubit>().ridesSubscription?.cancel();
              Di().sl<DriverRidesRequestsCubit>().stopCircles();
              _ridingSectionCubit.toggleContent();
              
            } catch (e) {
              print("❌ Error canceling ride: $e");
              Di().sl<DriverRidesRequestsCubit>().stopCircles();
              _ridingSectionCubit.toggleContent();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          } else {
            // Driver side
            if (isSearching) {
              // Cancel the search
              print("🛑 Driver canceling search...");
              _driverRidesRequestsCubit.cancelSearch();
              
              // Close the dialog if it's open
              if (context.mounted && Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              
              print("✅ Driver search cancelled");
            } else {
            // Navigator.of(context).pop();
              // Start searching
              print("🚗 Driver starting search...");
              _driverRidesRequestsCubit.checkRidesInEntrance();
              DialogHelper.showGeDialog(
                  context: context, 
                  dialog: const UserRideRequestDialoge());
            }
          }
        } : null,
        borderRadius: BorderRadius.circular(12),
        splashColor: isSearching 
            ? AppColors.redColor.withOpacity(0.3)
            : AppColors.primaryDark.withOpacity(0.3),
        child: Container(
          width: double.infinity,
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isCaptain == false
                ? AppColors.transparent
                : isSearching
                    ? AppColors.transparent
                    : isEnabled 
                        ? AppColors.primaryDark
                        : AppColors.primaryDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.isCaptain == false
              ? const SizedBox.shrink()
              : AppTextStyle(
                  text: isSearching ? "" : "Find customer",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isEnabled 
                      ? AppColors.blackColor 
                      : AppColors.whiteColor,
                ),
        ),
      ),
    );
  },
),
 SizedBox(
            height: getHeight(context) * 0.040,
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
