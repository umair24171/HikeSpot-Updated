import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/chats/data/model/message/message_model.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/get_messages_cubit.dart';

import '../../../../utils/app_text_style.dart';
import 'chatcontainers/other_user_container.dart';
import 'chatcontainers/user_chat_container.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _getMessagesCubit.getMessagesDb(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: AppTextStyle(
              text: "Error while fetching chats",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          );
        } else if (snapshot.data?.docs.isEmpty ?? false) {
          return const Center(
            child: AppTextStyle(
              text: "No Chats Available",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          );
        } else if (snapshot.data?.docs.isNotEmpty ?? false) {
          var data = snapshot.data?.docs;
          var list = data
              ?.map(
                (e) => MessageModel.fromJson(e.data()),
              )
              .toList();
          _getMessagesCubit.getMessagesLocal(list ?? []);
          
          return BlocBuilder(
            bloc: _getMessagesCubit,
            builder: (context, state) {
              // 🔥 REMOVED Expanded - it's already wrapped in parent
              bool shouldScroll = _getMessagesCubit.messages.length > 2;
              
              if (!shouldScroll) {
                _getMessagesCubit.messages.sort(
                  (a, b) => a.sent.compareTo(b.sent),
                );
              } else {
                _getMessagesCubit.messages.sort(
                  (a, b) => b.sent.compareTo(a.sent),
                );
              }
              
              return ListView.builder(
                itemCount: _getMessagesCubit.messages.length,
                shrinkWrap: true,
                reverse: shouldScroll,
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  var message = _getMessagesCubit.messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        message.senderId == _authCubit.authData.uid
                            ? UserChatContainer(
                                message: message,
                              )
                            : OtherUserContainer(
                                message: message,
                              ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

final GetMessagesCubit _getMessagesCubit = Di().sl<GetMessagesCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();