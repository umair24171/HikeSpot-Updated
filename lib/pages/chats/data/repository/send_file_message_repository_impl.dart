import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/repository/send_file_message_repository.dart';
import '../datasource/send_file_message_datasource.dart';
import '../model/message/message_model.dart';

class SendFileMessageRepositoryImpl implements SendFileMessageRepository {
  final SendFileMessageDataSource chatDataSource;

  SendFileMessageRepositoryImpl(this.chatDataSource);

  @override
  Future<Either<Exception, MessageModel>> sendFileMessage(
      File file, MessageModel message) async {
    return await chatDataSource.sendFileMessage(file, message);
  }
}
