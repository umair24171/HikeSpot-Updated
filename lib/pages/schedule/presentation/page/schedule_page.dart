import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/location_add_sheet.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/schedule_container.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/time_container.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../home/presentation/bloc/cubit/menue_cubit.dart';
import '../bloc/cubit/schedule_ride_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/location_add_sheet.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/schedule_container.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/time_container.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/location_add_sheet.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/schedule_container.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/time_container.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';

@RoutePage()
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                ),
                const AppTextStyle(
                    text: "Schedule",
                    fontSize: 20,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500),
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
            ),
            const AppTextStyle(
              text: "When do you want to be picked up?",
              fontSize: 34,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const ScheduleContainer(),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // AutoRouter.of(context).push(MapPageRoute());
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const LocationAddSheet();
                      },
                    );
                  },
                  child: const AppTextStyle(
                      text: "Add location",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.37),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.add,
                        color: AppColors.whiteColor, size: 12))
              ],
            ),
            const SizedBox(
              height: 34,
            ),
            BlocBuilder(
              bloc: _mapControllerCubit,
              builder: (context, state) {
                var time = _mapControllerCubit.selectedTime;
                return TimeContainer(
                  icon: AppImages.timeIcon,
                  text: _mapControllerCubit.selectedTime != null
                      ? "${time?.hour}:${time?.minute}"
                      : "Today",
                  onTap: () {
                    _mapControllerCubit.openTimeOfDayPicker(context);
                  },
                );
              },
            ),
            const SizedBox(
              height: 27,
            ),
            BlocBuilder(
              bloc: _mapControllerCubit,
              builder: (context, state) {
                var time = _mapControllerCubit.selectedDate;
                return TimeContainer(
                  icon: AppImages.calenderIcon,
                  text: _mapControllerCubit.selectedDate != null
                      ? "${time?.day}/${time?.month}/${time?.year}"
                      : "Time",
                  onTap: () {
                    _mapControllerCubit.openDatePicker(context);
                  },
                );
              },
            ),
            const Spacer(),
            GestureContainer(
              text: "Confirm Pickup Time",
              isValidate: true,
              textColor: AppColors.blackColor,
              isNeedArrow: false,
              onTap: () {
                // Validate selections without using MediaQuery-dependent toasts
                if (_mapControllerCubit.selectedDate == null) {
                  // Use ScaffoldMessenger instead of WarningHelper
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a date"))
                  );
                  return;
                }
                if (_mapControllerCubit.selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a time"))
                  );
                  return;
                }
                
                // Save to CreateRideCubit (following your pattern)
                _createRideCubit.getRideDate(_mapControllerCubit.selectedDate!);
                _createRideCubit.getRideTime(_mapControllerCubit.selectedTime!);
                
                // Navigate back to Home screen (index 0) through menu system
                _menueCubit.changeIndex(0);
                
                // Create ride with scheduled date automatically
                _createRideCubit.createRide(context).then((value) {
                  // Use ScaffoldMessenger for success message too
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Scheduled ride created successfully"))
                  );
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

final ScheduleRideCubit _mapControllerCubit = Di().sl<ScheduleRideCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();