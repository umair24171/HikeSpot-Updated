import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/loadings/chats_loading.dart';
import 'package:hikespot/pages/chats/data/model/chat/chat_model.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/get_chats_cubit.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:hikespot/pages/chats/presentation/widgets/user_container.dart';
import 'package:hikespot/utils/app_text_style.dart';

import '../../../../data/models/auth-model/auth_model.dart';
import '../../../../routes/routes_imports.gr.dart';
import '../../../../utils/app_colors.dart';

class UserChatsList extends StatelessWidget {
  const UserChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getChatsCubit,
      builder: (context, state) {
        return StreamBuilder(
          stream: _getChatsCubit.getChatsDb(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AppTextStyle(
                  text: "Error while fecthing chats",
                  fontSize: 18,
                  fontWeight: FontWeight.w500);
            } else if (snapshot.data?.docs.isEmpty ?? false) {
              return const AppTextStyle(
                  text: "No Chats Available",
                  fontSize: 18,
                  fontWeight: FontWeight.w500);
            } else if (snapshot.data?.docs.isNotEmpty ?? false) {
              var data = snapshot.data?.docs;
              var list = data
                  ?.map(
                    (e) => ChatModel.fromJson(e.data()),
                  )
                  .toList();
              _getChatsCubit.getChatsLocal(list ?? []);
              return Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.containerColor,
                      border: Border.all(color: const Color(0xff8F8484)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(38),
                        topRight: Radius.circular(38),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ListView.builder(
                        itemCount: _getChatsCubit.chats.length,
                        itemBuilder: (context, index) {
                          var chat = _getChatsCubit.chats[index];
                          var userId = chat.participiants.firstWhere(
                            (element) => element != _authCubit.authData.uid,
                            orElse: () => '',
                          );
                          return StreamBuilder(
                              stream: _getChatsCubit.getChatUserData(userId),
                              builder: (context, userSnapshot) {
                                var user = userSnapshot.data;
                                var model =
                                    AuthModel.fromJson(user?.data() ?? {});
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor:
                                        AppColors.primaryDark.withOpacity(0.4),
                                    onTap: () {
                                      _sendMessageCubit
                                          .getOtherUserData(model);
                                      _getChatsCubit.getChatData(chat);
                                      AutoRouter.of(context)
                                          .push(const ChatPageRoute());
                                    },
                                    child: UserContainer(
                                      chat: chat,
                                      model: model,
                                    ));
                              });
                        },
                      ),
                    )),
              );
            } else {
              return const ChatShimmer();
            }
          },
        );
      },
    );
  }
}

final SendMessageCubit _sendMessageCubit = Di().sl<SendMessageCubit>();
final GetChatsCubit _getChatsCubit = Di().sl<GetChatsCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
