import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/captain-sheet/captain_working_sheet.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_dialoge.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/location_add_sheet.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/passenger_sheet.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/payment_section.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/riding_list.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../utils/enums.dart';

class RidingSection extends StatelessWidget {
  const RidingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _ridingSectionCubit,
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Container(
            width: getWidth(context),
            // ✅ Add SafeArea padding at bottom to prevent button from being hidden
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20 + MediaQuery.of(context).padding.bottom, // Account for system UI
            ),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              border: Border(
                top: BorderSide(
                  color: AppColors.primaryGreyColor.withOpacity(0.6),
                  width: 0.7,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: AnimatedSwitcher(
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
              child: state is RidingSectionEntranceContent
                  ? buildEntranceContent(context)
                  : state is RidingSectionPassenger
                      ? const PassengerSheet()
                      : state is RidingSectionPayment
                          ? const PaymentSection()
                          : state is CaptainWorkingState
                              ? const CaptainWorkingSheet(
                                  isCaptain: false,
                                )
                              : buildSecondaryContent(),
            ),
          ),
        );
      },
    );
  }
}

final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();

Widget buildSecondaryContent() {
  return Column(
    key: const ValueKey('SecondaryContent'),
    children: [
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (_menueCubit.userState == AppState.captain) {
                _ridingSectionCubit.showCaptainWorkingSection();
              } else {
                _ridingSectionCubit.toggleContent();
              }
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.37),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.whiteColor),
            ),
          ),
          const AppTextStyle(
            text: "Number of entrance",
            fontSize: 20,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: () {
              if (_menueCubit.userState == AppState.captain) {
                _ridingSectionCubit.showCaptainWorkingSection();
              } else {
                _ridingSectionCubit.toggleContent();
              }
            },
            child: Container(
              height: 29,
              width: 29,
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.65),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.cancelIcon),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      LocationSearchField(
        hintText: "Enter the range of entrance",
        controller: _createRideCubit.enteranceController,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppTextStyle(
            text:
                "You can expand the range for search the\n drivers after add the entrance number.",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.redColor,
          ),
          Container(
            height: 23,
            width: 23,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.redColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: const AppTextStyle(
              text: "!",
              fontSize: 12,
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 36),
      const GestureContainer(text: "Done", isNeedArrow: false)
    ],
  );
}

Widget buildEntranceContent(BuildContext context) {
  return Column(
    key: const ValueKey('EntranceContent'),
    children: [
      // 🔥 NEW: Ride Type Selector (Hitchhiking vs Parcel)
      BlocBuilder(
        bloc: _createRideCubit,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _createRideCubit.setRideType(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_createRideCubit.isParcelDelivery
                            ? AppColors.primaryDark
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: !_createRideCubit.isParcelDelivery
                                ? AppColors.whiteColor
                                : AppColors.primaryGreyColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          AppTextStyle(
                            text: "Hitchhiking",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: !_createRideCubit.isParcelDelivery
                                ? AppColors.whiteColor
                                : AppColors.primaryGreyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _createRideCubit.setRideType(true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _createRideCubit.isParcelDelivery
                            ? AppColors.primaryDark
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_shipping_rounded,
                            color: _createRideCubit.isParcelDelivery
                                ? AppColors.whiteColor
                                : AppColors.primaryGreyColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          AppTextStyle(
                            text: "Parcel",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _createRideCubit.isParcelDelivery
                                ? AppColors.whiteColor
                                : AppColors.primaryGreyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      
      const SizedBox(height: 16),
      
      // Vehicle type list
      const RidingList(),
      const SizedBox(height: 11),
      
      // Pickup location
      Row(
        children: [
          SvgPicture.asset(AppImages.enteranceIcon),
          const SizedBox(width: 5),
          BlocBuilder(
            bloc: _googleMapCubit,
            builder: (context, state) {
              return Expanded(
                child: AppTextStyle(
                  text:
                      "${_googleMapCubit.address?.street}, ${_googleMapCubit.address?.thoroughfare}, ${_googleMapCubit.address?.administrativeArea}, ${_googleMapCubit.address?.locality} , ${_googleMapCubit.address?.country}",
                  fontSize: 13,
                  maxLines: 2,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _ridingSectionCubit.toggleContent();
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
      const SizedBox(height: 11),
      
      // Destination field
      LocationSearchField(
        hintText: "To",
        readOnly: true,
        controller: _createRideCubit.destinationDisplayController,
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const LocationAddSheet();
            },
          );
        },
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.searchIcon),
          ],
        ),
      ),
      const SizedBox(height: 11),
      
      // 🔥 Parcel Details (only show if Parcel Delivery selected)
      BlocBuilder(
        bloc: _createRideCubit,
        builder: (context, state) {
          if (_createRideCubit.isParcelDelivery) {
            return Column(
              children: [
                // Parcel weight/size
                LocationSearchField(
                  hintText: "Parcel size (Small/Medium/Large)",
                  controller: _createRideCubit.parcelSizeController,
                  prefixIcon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inventory_2_outlined, 
                           color: AppColors.primaryDark, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                
                // Receiver name
                LocationSearchField(
                  hintText: "Receiver name",
                  controller: _createRideCubit.receiverNameController,
                  prefixIcon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, 
                           color: AppColors.primaryDark, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                
                // Receiver phone
                LocationSearchField(
                  hintText: "Receiver phone",
                  controller: _createRideCubit.receiverPhoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_outlined, 
                           color: AppColors.primaryDark, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      
      // Distance and fare info box
      BlocBuilder(
        bloc: _googleMapCubit,
        builder: (context, state) {
          if (_googleMapCubit.routeDistanceInKm > 0) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryDark.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.route_rounded,
                          color: AppColors.whiteColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: "Distance: ${_googleMapCubit.routeDistanceText}",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                            const SizedBox(height: 4),
                            BlocBuilder(
                              bloc: _createRideCubit,
                              builder: (context, state) {
                                return AppTextStyle(
                                  text: _createRideCubit.fareController.text.isNotEmpty
                                      ? "Suggested fare: R${_createRideCubit.fareController.text}"
                                      : "Calculating fare...",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor.withOpacity(0.7),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      
      // Fare field
      LocationSearchField(
        hintText: "Offer your fare",
        readOnly: true,
        controller: _createRideCubit.fareController,
        onTap: () {
          _ridingSectionCubit.togglePayment();
        },
        prefixIcon: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextStyle(
              text: "ZAR",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDark,
            ),
          ],
        ),
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.cashIcon),
          ],
        ),
      ),
      const SizedBox(height: 24), // ✅ Increased spacing for better visibility

      // Find driver button and filter
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder(
              bloc: _createRideCubit,
              builder: (context, state) {
                return GestureContainer(
                  text: _createRideCubit.isParcelDelivery 
                      ? "Find Delivery Driver" 
                      : "Find a driver",
                  onTap: () {
                    // Validate based on type
                    if (_createRideCubit.destinationAddress.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a destination"))
                      );
                      return;
                    }
                    
                    // Validate parcel fields if parcel delivery
                    if (_createRideCubit.isParcelDelivery) {
                      if (_createRideCubit.parcelSizeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter parcel size"))
                        );
                        return;
                      }
                      if (_createRideCubit.receiverNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter receiver name"))
                        );
                        return;
                      }
                      if (_createRideCubit.receiverPhoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter receiver phone"))
                        );
                        return;
                      }
                    }
                    
                    if (_createRideCubit.fareController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter your fare offer"))
                      );
                      return;
                    }
                    
                    // Create ride
                    _createRideCubit.createRide(context).then((value) {
                      value.fold(
                        (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error))
                          );
                        },
                        (rideData) {
                          _ridingSectionCubit.showSearchRiders();
                          DialogHelper.showGeDialog(
                            context: context, 
                            dialog: const UserRideRequestDialoge()
                          );
                        }
                      );
                    });
                  },
                  textColor: AppColors.blackColor,
                  isNeedArrow: false,
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          BlocBuilder(
            bloc: _createRideCubit,
            builder: (context, state) {
              // Don't show filter for parcel delivery (no passengers)
              if (_createRideCubit.isParcelDelivery) {
                return const SizedBox(width: 55);
              }
              
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (_createRideCubit.passengerController.text.isNotEmpty ||
                      _createRideCubit.seatsController.text.isNotEmpty ||
                      _createRideCubit.commentController.text.isNotEmpty)
                    const SizedBox(
                      width: 60,
                      height: 60,
                    ),
                  GestureContainer(
                    text: "",
                    width: 55,
                    textColor: AppColors.blackColor,
                    isNeedArrow: false,
                    onTap: () {
                      _ridingSectionCubit.togglePassenger();
                    },
                    customWidget: SvgPicture.asset(AppImages.filterIcon),
                  ),
                  if (_createRideCubit.passengerController.text.isNotEmpty ||
                      _createRideCubit.seatsController.text.isNotEmpty ||
                      _createRideCubit.commentController.text.isNotEmpty)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.redColor,
                          radius: 7,
                          child: AppTextStyle(
                            text: _createRideCubit
                                        .passengerController.text.isNotEmpty &&
                                    _createRideCubit
                                        .seatsController.text.isNotEmpty &&
                                    _createRideCubit
                                        .commentController.text.isNotEmpty
                                ? "3"
                                : _createRideCubit.passengerController.text
                                            .isNotEmpty ||
                                        _createRideCubit.seatsController.text
                                                .isNotEmpty &&
                                            _createRideCubit
                                                .commentController.text.isNotEmpty
                                    ? "2"
                                    : _createRideCubit.passengerController.text
                                                .isNotEmpty ||
                                            _createRideCubit.seatsController
                                                .text.isNotEmpty ||
                                            _createRideCubit.commentController
                                                .text.isNotEmpty
                                        ? "1"
                                        : "",
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteColor,
                          ),
                        ))
                ],
              );
            },
          ),
        ],
      ),
    ],
  );
}

final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();