import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/app/constants/links.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/get_chats_cubit.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';

import '../../../../utils/app_text_style.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
            color: AppColors.secContainerColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: AppColors.primaryDark.withOpacity(0.37),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                        size: 19,
                      ),
                    ),
                  ),
                  const AppTextStyle(
                      text: "Chat",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                  const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  BlocBuilder(
                    bloc: _getChatsCubit,
                    builder: (context, state) {
                      return Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.dialogeColor, width: 1),
                            color: AppColors.containerColor.withOpacity(0.17),
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryDark.withOpacity(0.37),
                          backgroundImage: NetworkImage(
                            _getChatsCubit.chatData.chatType ==
                                    ChatType.chatSupport.name
                                ? AppLinks.appLogoUrl
                                : _sendMessageCubit.otherUserData.imageUrl,
                          ),
                          radius: 26,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder(
                        bloc: _getChatsCubit,
                        builder: (context, state) {
                          return AppTextStyle(
                              text: _getChatsCubit.chatData.chatType ==
                                      ChatType.chatSupport.name
                                  ? "HikeSpot Support"
                                  : _sendMessageCubit.otherUserData.username,
                              fontSize: 17,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                              text: "Active",
                              fontSize: 11,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500),
                          CircleAvatar(
                            radius: 2,
                            backgroundColor: AppColors.greenColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (_getChatsCubit.chatData.chatType !=
                      ChatType.chatSupport.name)
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.customColor(0xffDDDDDD),
                            blurRadius: 10,
                          )
                        ],
                        shape: BoxShape.circle,
                        color: AppColors.customColor(0xffDDDDDD),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.callIcon),
                        ],
                      ),
                    )
                ],
              ),
            ],
          ),
        ));
  }
}

final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();
final GetChatsCubit _getChatsCubit = Di().sl<GetChatsCubit>();
