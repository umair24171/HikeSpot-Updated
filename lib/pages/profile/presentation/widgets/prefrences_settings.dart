import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/get_chats_cubit.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_setting_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';

import '../../../../blocs/cubits/auth_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'setting_container.dart';

class PreferencesSettings extends StatelessWidget {
  const PreferencesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTextStyle(
          text: "Preferences",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        const SizedBox(
          height: 20,
        ),
        // const SettingContainer(
        //     containerText: "Change Language", icon: AppImages.languageIcon),
        // const SizedBox(
        //   height: 15,
        // ),
        // const SettingContainer(
        //     containerText: "Change Location", icon: AppImages.locationIcon),
        const SizedBox(
          height: 15,
        ),
        // SettingContainer(
        //   containerText: "Refer",
        //   icon: AppImages.referIcon,
        //   onTap: () {
        //     AutoRouter.of(context).push(const ReferPageRoute());
        //   },
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
        SettingContainer(
          containerText: "Live Support Chat",
          icon: AppImages.liveChatIcon,
          onTap: () {
            _getChatsCubit.getChatType(ChatType.chatSupport);
            _getChatsCubit.addChatDataDb();
            _sendMessageCubit.getOtherUserData(_authCubit.authData);
            AutoRouter.of(context).push(const ChatPageRoute());
          },
        ),
        const SizedBox(
          height: 15,
        ),
        SettingContainer(
          containerText: "Logout",
          icon: AppImages.logoutIcon,
          isNeedIcon: false,
          onTap: () {
            authCubit.signOut(context);
          },
          textColor: AppColors.primaryDark,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

final GetChatsCubit _getChatsCubit = Di().sl<GetChatsCubit>();
final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
