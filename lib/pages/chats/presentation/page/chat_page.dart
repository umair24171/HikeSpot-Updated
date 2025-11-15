import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/chats/presentation/widgets/chat_app_bar.dart';
import 'package:hikespot/pages/chats/presentation/widgets/messages_list.dart';
import 'package:hikespot/pages/chats/presentation/widgets/user_input_field.dart';

import '../../../../utils/app_colors.dart';
@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  // Constrain app bar height
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.2, // Max 15% of screen
                    ),
                    child: const ChatAppBar(),
                  ),
                  // Messages area takes remaining space
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: const MessagesList(),
                    ),
                  ),
                  // Constrain input field height
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.15, // Max 15% of screen
                    ),
                    child: const UserInputField(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}