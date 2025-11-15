import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/activities/presentation/bloc/cubit/get_rides_list_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/menue/menue_item.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

class DownMenue extends StatefulWidget {
  const DownMenue({super.key});

  @override
  State<DownMenue> createState() => _DownMenueState();
}

class _DownMenueState extends State<DownMenue> {
  @override
  void initState() {
    _getRidesListCubit.getRidesList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<MenueItem> userMenue = [
      const MenueItem(icon: AppImages.homeIcon, text: "Home", index: 0),
      const MenueItem(
          icon: AppImages.activitiesIcon, text: "Activities", index: 1),
      const MenueItem(icon: AppImages.scheduleIcon, text: "Schedule", index: 2),
      const MenueItem(icon: AppImages.chatsIcon, text: "Chats", index: 3),
      const MenueItem(icon: AppImages.profileIcon, text: "Profile", index: 4),
    ];
    final List<MenueItem> captainMenue = [
      const MenueItem(icon: AppImages.homeIcon, text: "Home", index: 0),
      const MenueItem(
          icon: AppImages.activitiesIcon, text: "Activities", index: 1),
      const MenueItem(icon: AppImages.chatsIcon, text: "Chats", index: 2),
      const MenueItem(icon: AppImages.profileIcon, text: "Profile", index: 3),
    ];
    return Container(
      width: getWidth(context),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withOpacity(0.19),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 29,
                    width: 29,
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.65),
                        shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          _menueCubit.changeMenuVisibility(false);
                        },
                        icon: SvgPicture.asset(AppImages.cancelIcon)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _menueCubit.userState == AppState.captain
                          ? captainMenue
                          : userMenue),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
final GetRidesListCubit _getRidesListCubit = Di().sl<GetRidesListCubit>();