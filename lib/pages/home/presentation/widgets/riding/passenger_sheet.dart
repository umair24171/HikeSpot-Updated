import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/images_paths.dart';
import '../../bloc/cubit/create_ride_cubit.dart';

class PassengerSheet extends StatelessWidget {
  const PassengerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              _ridingSectionCubit.toggleContent();
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
        ),
        const SizedBox(
          height: 42,
        ),
        const AppTextStyle(
          text: "More than 3 passengers",
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder(
          bloc: _createBookingCubit,
          builder: (context, state) {
            return LocationSearchField(
              hintText: "",
              readOnly: true,
              inCenterText: true,
              controller: _createBookingCubit.passengerController,
              keyboardType: TextInputType.number,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _createBookingCubit.decreasePassengers();
                      },
                      icon: SvgPicture.asset(AppImages.subtractionIcon)),
                ],
              ),
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _createBookingCubit.increasePassengers();
                      },
                      icon: SvgPicture.asset(AppImages.additionIcon)),
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const AppTextStyle(
          text: "Car seats to book",
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder(
          bloc: _createBookingCubit,
          builder: (context, state) {
            return LocationSearchField(
              hintText: "",
              readOnly: true,
              inCenterText: true,
              controller: _createBookingCubit.seatsController,
              keyboardType: TextInputType.number,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _createBookingCubit.decreaseSeatsBooked();
                      },
                      icon: SvgPicture.asset(AppImages.subtractionIcon)),
                ],
              ),
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _createBookingCubit.increaseSeatsBooked();
                      },
                      icon: SvgPicture.asset(AppImages.additionIcon)),
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        LocationSearchField(
          hintText: "Comments",
          controller: _createBookingCubit.commentController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 20,
        ),
        const GestureContainer(
          text: "Apply",
          textColor: AppColors.blackColor,
          isNeedArrow: false,
        ),
      ],
    );
  }
}

final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final CreateRideCubit _createBookingCubit = Di().sl<CreateRideCubit>();
