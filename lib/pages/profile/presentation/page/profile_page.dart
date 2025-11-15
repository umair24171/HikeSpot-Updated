import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/profile/presentation/widgets/account_setting.dart';
import 'package:hikespot/pages/profile/presentation/widgets/prefrences_settings.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../home/presentation/bloc/cubit/menue_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      text: "Profile",
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
                height: 39,
              ),
              const AccountSettings(),
              const SizedBox(
                height: 25,
              ),
              const PreferencesSettings(),
          
            ],
          ),
        ),
      ),
    );
  }
}

final MenueCubit _menueCubit = Di().sl<MenueCubit>();
