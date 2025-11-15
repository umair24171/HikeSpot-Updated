import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

class NotificationSettingContainer extends StatefulWidget {
  const NotificationSettingContainer({super.key});

  @override
  State<NotificationSettingContainer> createState() =>
      _NotificationSettingContainerState();
}

class _NotificationSettingContainerState
    extends State<NotificationSettingContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: authCubit,
      builder: (context, state) {
        bool isNotificationOn = authCubit.authData.notificationEnabled;
        return Container(
            height: getHeight(context) * 0.060,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secContainerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTextStyle(
                  text: "Push notifications",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
                InkWell(
                    onTap: () {
                      authCubit.updateNotificationStatus(!isNotificationOn, context);
                    },
                    child: SvgPicture.asset(isNotificationOn
                        ? AppImages.switchOn
                        : AppImages.switchOff)),
              ],
            ));
      },
    );
  }
}

final AuthCubit authCubit = Di().sl<AuthCubit>();
