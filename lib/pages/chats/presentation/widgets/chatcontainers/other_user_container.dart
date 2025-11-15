import 'package:flutter/material.dart';
import 'package:hikespot/pages/chats/data/model/message/message_model.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

class OtherUserContainer extends StatelessWidget {
  final MessageModel message;
  const OtherUserContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 31,
            width: 31,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.dialogeColor, width: 1),
                color: AppColors.containerColor.withOpacity(0.17),
                shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryDark.withOpacity(0.37),
              radius: 26,
            ),
          ),
          const SizedBox(
            width: 7.9,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                  color: AppColors.customColor(0xff515862),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                ),
                child: AppTextStyle(
                  text: message.message, // Plain text, no decryption
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
              AppTextStyle(
                  text: message.sent,
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