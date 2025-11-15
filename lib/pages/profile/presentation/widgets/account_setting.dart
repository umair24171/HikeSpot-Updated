import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_setting_container.dart';
import 'package:hikespot/pages/profile/presentation/widgets/setting_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';

import '../../../../core/di/service_locator_imports.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  void initState() {
    _authCubit.checkCaptainStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTextStyle(
          text: "Your Account",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 20,
        ),
        SettingContainer(
          containerText: "Personal Information",
          icon: AppImages.personIcon,
          onTap: () async {
            AutoRouter.of(context).push(const EditPageRoute());
          },
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder(
          bloc: _authCubit,
          builder: (context, state) {
            return SettingContainer(
                containerText: authCubit.authData.appStatus ==
                            AppState.user.name &&
                        authCubit.authData.isRequestedDriver == false
                    ? "Become a Captain or Driver"
                    : authCubit.authData.isRequestedDriver == true &&
                            authCubit.authData.driverModel.isVerified &&
                            authCubit.authData.appStatus == AppState.user.name
                        ? "Switch to Captain"
                        : "Switch to User",
                onTap: () {
                  if (authCubit.authData.isRequestedDriver == true &&
                      authCubit.authData.driverModel.isVerified == false) {
                    AutoRouter.of(context).push(VerifiedPageRoute(
                        user: NewUser.oldUser,
                        heading: "Captain AppLication Status",
                        needButton: false,
                        subHeading:
                            "We Have Recived Your Application And Our Team is Working On It After Proccessing We Will Notify you!"));
                  } else if (authCubit.authData.isRequestedDriver == true &&
                      authCubit.authData.driverModel.isVerified == true) {
                    AutoRouter.of(context).push(const SwitchPageRoute());
                  } else {
                    AutoRouter.of(context)
                        .push(const CaptainRegisterPageRoute());
                  }
                },
                isNeedIcon: false,
                suffixIxon: authCubit.authData.isRequestedDriver &&
                        authCubit.authData.driverModel.isVerified
                    ? SvgPicture.asset(AppImages.switchIcon)
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColors.primaryDark,
                      ),
                icon: authCubit.authData.isRequestedDriver &&
                        authCubit.authData.driverModel.isVerified
                    ? AppImages.personStandIcon
                    : AppImages.driverIcon);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        SettingContainer(
            onTap: () {
              AutoRouter.of(context).push(const NotificationPageRoute());
            },
            containerText: "Notifications",
            icon: AppImages.notificationIcon),
        const SizedBox(
          height: 25,
        ),
        const AppTextStyle(
          text: "Security",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 15,
        ),
        SettingContainer(
            containerText: "Safety",
            onTap: () async {
              AutoRouter.of(context).push(const SafetyPageRoute());
              // sendNotification();
            },
            icon: AppImages.securityIcon),
      ],
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
