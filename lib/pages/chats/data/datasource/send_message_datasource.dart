import 'dart:developer';
import 'package:dartz/dartz.dart';

import '../../../../app/constants/app_constants.dart';
import '../model/message/message_model.dart';
abstract class SendMessageDataSource {
  Future<Either<Exception, String>> sendMessage(
      MessageModel chatModel, String chatId);
}

class SendMessageDataSourceImpl implements SendMessageDataSource {
  @override
  Future<Either<Exception, String>> sendMessage(
      MessageModel chatModel, String chatId) async {
    try {
      await AppConstants.firestore
          .collection(AppConstants.chatsKey)
          .doc(chatId)
          .update({
        "lastMessage": chatModel.message,
        "lastMessageTime": chatModel.sent,
        "lastMessageSenderId": chatModel.senderId,
      });
      return await AppConstants.firestore
          .collection(AppConstants.chatsKey)
          .doc(chatId)
          .collection(AppConstants.messagesKey)
          .doc(chatModel.messageId)
          .set(chatModel.toJson())
          .onError(
        (error, stackTrace) {
          log(error.toString());
        },
      ).then(
        (value) async {
          return const Right("Message Sented Successfully");
        },
      );
    } catch (e) {
      return Left(Exception("Error while sending message"));
    }
  }
}
