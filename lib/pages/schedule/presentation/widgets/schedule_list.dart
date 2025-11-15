import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/activities/presentation/bloc/cubit/get_rides_list_cubit.dart';
import 'package:hikespot/pages/activities/presentation/widget/activity_widget.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

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
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.37),
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      _menueCubit.changeScreenToSchedulePage();
                    },
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.whiteColor),
                  ),
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
                ),
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            const AppTextStyle(
                text: "Pickup List",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _menueCubit.changeScreenToSchedulePage();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppTextStyle(
                        text: "Add Schedule",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                            color: AppColors.primaryDark.withOpacity(0.37),
                            shape: BoxShape.circle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.calenderIcon,
                              height: 12,
                              width: 12,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            BlocBuilder(
              bloc: _getRidesListCubit,
              builder: (context, state) {
                if(_getRidesListCubit.scheduledRides.isEmpty){
                  return const Center(
                    child: AppTextStyle(
                      text: "No Scheduled Rides",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: _getRidesListCubit.scheduledRides.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var ride = _getRidesListCubit.scheduledRides[index];
                        return   Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ActivityWidget(
                            containerType: ContainerType.schedule,
                            rideData: ride,
                          ),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final GetRidesListCubit _getRidesListCubit = Di().sl<GetRidesListCubit>();
