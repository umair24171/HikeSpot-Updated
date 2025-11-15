import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/activities/presentation/bloc/cubit/get_rides_list_cubit.dart';
import 'package:hikespot/pages/activities/presentation/widget/rides_list.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/utils/app_text_style.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';

@RoutePage()
class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

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
                    text: "Activities",
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
            BlocBuilder(
              bloc: _getRidesListCubit,
              builder: (context, state) {
                return AppTextStyle(
                  text: "${_getRidesListCubit.historyMonth} History",
                  fontSize: 20,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const RidesList()
          ],
        ),
      ),
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final GetRidesListCubit _getRidesListCubit = Di().sl<GetRidesListCubit>();
