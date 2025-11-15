import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/styles.dart';

class UserInputField extends StatefulWidget {
  const UserInputField({super.key});

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  bool _isFieldEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 33),
      decoration: BoxDecoration(
          color: AppColors.messageContainer,
          border: Border(
              top: BorderSide(color: AppColors.whiteColor.withOpacity(0.25)))),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _sendMessageCubit.textEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _isFieldEmpty = false;
                  });
                }
              },
              style: Styles.textStyle.copyWith(
                    color: AppColors.whiteColor.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                fillColor: AppColors.customColor(0xffEBEBEB).withOpacity(0.34),
                filled: true,
                hintText: 'Write your message',
                
                hintStyle: Styles.textStyle.copyWith(
                    color: AppColors.whiteColor.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: Styles.textFieldBorder.copyWith(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.37),
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () {
                  if (_isFieldEmpty == false) {
                    _sendMessageCubit.sendMessage(context);
                  }
                },
                icon: _isFieldEmpty == false
                    ? const Icon(
                        Icons.send_rounded,
                        color: AppColors.whiteColor,
                      )
                    : SvgPicture.asset(AppImages.micIcon)),
          ),
        ],
      ),
    );
  }
}

final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();
