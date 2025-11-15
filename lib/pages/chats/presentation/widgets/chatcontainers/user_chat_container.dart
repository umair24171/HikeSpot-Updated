import 'package:flutter/material.dart';
import 'package:hikespot/helper/time_formater.dart';
import 'package:hikespot/pages/chats/data/model/message/message_model.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class UserChatContainer extends StatelessWidget {
  final MessageModel message;
  const UserChatContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  border: Border.all(
                    color: AppColors.primaryDark.withOpacity(0.5),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                ),
                child: AppTextStyle(
                  text: message.message, // Plain text, no decryption
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.containerColor.withOpacity(0.9),
                ),
              ),
              AppTextStyle(
                  text: MyDateUtil.getLastMessageTime(
                      context: context, time: message.sent),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.customColor(0xff717171))
            ],
          ),
        ],
      ),
    );
  }
}