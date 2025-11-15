import 'package:dartz/dartz.dart';

import '../../domain/repository/send_message_repository.dart';
import '../datasource/send_message_datasource.dart';
import '../model/message/message_model.dart';

class SendMessageRepositoryImpl extends SendMessageRepository {
  final SendMessageDataSource _sendMessageDataSource;

  SendMessageRepositoryImpl(this._sendMessageDataSource);

  @override
  Future<Either<Exception, String>> sendMessage(
      MessageModel chatModel, String chatId) {
    return _sendMessageDataSource.sendMessage(chatModel, chatId);
  }
}
