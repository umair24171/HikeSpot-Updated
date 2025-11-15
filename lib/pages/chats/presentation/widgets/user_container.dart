import 'package:flutter/material.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/helper/time_formater.dart';
import 'package:hikespot/pages/chats/data/model/chat/chat_model.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class UserContainer extends StatelessWidget {
  final ChatModel chat;
  final AuthModel model;
  const UserContainer({super.key, required this.chat, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.transparent,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryGreyColor,
                  backgroundImage: NetworkImage(model.imageUrl),
                ),
                const Positioned(
                  bottom: 0,
                  right: 2,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: AppColors.greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppTextStyle(
                        text: model.username,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      const Spacer(),
                      if(chat.lastMessageTime.isNotEmpty)
                       AppTextStyle(
                        text: MyDateUtil.getLastMessageTime(context: context, time: chat.lastMessageTime),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGreyColor,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  AppTextStyle(
                    text: chat.lastMessage, // Plain text, no decryption
                    fontSize: 12,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreyColor,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}