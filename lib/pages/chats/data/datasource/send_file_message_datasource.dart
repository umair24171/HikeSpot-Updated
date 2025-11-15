import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hikespot/helper/firebase_storage_helper.dart';

import '../../../../app/constants/app_constants.dart';
import '../model/message/message_model.dart';

abstract class SendFileMessageDataSource {
  Future<Either<Exception, MessageModel>> sendFileMessage(
      File file, MessageModel message);
}

class SendFileMessageDataSourceImpl implements SendFileMessageDataSource {
  @override
  Future<Either<Exception, MessageModel>> sendFileMessage(
      File file, MessageModel message) async {
    try {
      final String fileUrl =
          await uploadStorage(file, foldername: AppConstants.chatsKey);
      message = message.copyWith(
        message: fileUrl,
      );
      await AppConstants.firestore
          .collection(AppConstants.chatsKey)
          .doc(message.chatId)
          .collection(AppConstants.messagesKey)
          .doc(message.messageId)
          .set(message.toJson());
      return  Right(message);
    } catch (e) {
      throw Exception("Error while sending message");
    }
  }
}
