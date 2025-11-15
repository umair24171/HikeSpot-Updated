import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../presentation/bloc/cubit/get_chats_cubit.dart';

abstract class GetMessagesDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages();
}

class GetMessagesDatasourceImpl extends GetMessagesDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    final GetChatsCubit getChatsCubit = Di().sl<GetChatsCubit>();
    return AppConstants.firestore
        .collection(AppConstants.chatsKey)
        .doc(getChatsCubit.chatData.chatId)
        .collection(AppConstants.messagesKey)
        .orderBy("sent", descending: true)
        .snapshots();
  }
}
