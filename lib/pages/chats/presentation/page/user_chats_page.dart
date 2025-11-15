import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:hikespot/pages/chats/presentation/widgets/user_chat_list.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class UserChatsPage extends StatelessWidget {
  const UserChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
            const SizedBox(
            height: 20,
          ),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                ),
                const AppTextStyle(
                    text: "Chats",
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
          ),
          const SizedBox(
            height: 60,
          ),
         const UserChatsList(),
        ],
      ),
    );
  }
}

final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();
final MenueCubit _menueCubit = Di().sl<MenueCubit>();