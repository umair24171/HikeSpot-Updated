import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

import '../../../../../core/di/service_locator_imports.dart';

class MenueItem extends StatelessWidget {
  final String icon;
  final String text;
  final int index;
  const MenueItem(
      {super.key, required this.icon, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _menueCubit,
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.primaryDark.withOpacity(0.5),
          highlightColor: AppColors.primaryDark.withOpacity(0.5),
          hoverColor: AppColors.primaryDark.withOpacity(0.5),
          focusColor: AppColors.primaryDark.withOpacity(0.5),
          onTap: () {
            _menueCubit.changeMenuVisibility(false);
            _menueCubit.changeIndex(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                SvgPicture.asset(
                  icon,
                  color: index != _menueCubit.currentIndex
                      ? AppColors.whiteColor
                      : AppColors.primaryDark,
                ),
                const SizedBox(height: 5),
                AppTextStyle(
                  text: text,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: index != _menueCubit.currentIndex
                      ? AppColors.whiteColor
                      : AppColors.primaryDark,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
