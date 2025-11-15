import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../blocs/cubits/auth_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../model/chat/chat_model.dart';

abstract class GetChatsDatasource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
  Future<Either<String, ChatModel>> addChat(ChatModel chatData);
}

class GetChatsDatasourceImpl extends GetChatsDatasource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    return AppConstants.firestore
        .collection(AppConstants.chatsKey)
        .where("participiants", arrayContains: authCubit.authData.uid)
        .snapshots();
  }

  @override
  Future<Either<String, ChatModel>> addChat(ChatModel chatData) async {
    try {
     await AppConstants
          .firestore
          .collection(AppConstants.chatsKey)
          .doc(chatData.chatId).set(chatData.toJson());
      return Right(chatData);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
