import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/utils/app_text_style.dart';

import '../../../../utils/app_colors.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _menueCubit.changeScreenToSchedule();
      },
      child: Container(
        height: 49,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secContainerColor,
        ),
        child: const AppTextStyle(
          text: "See Schedule Lists",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
