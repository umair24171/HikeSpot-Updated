import 'package:dartz/dartz.dart';

import '../../data/model/message/message_model.dart';
import '../repository/send_message_repository.dart';

class SendMessageUsecase {
  final SendMessageRepository _messageRepository;

  SendMessageUsecase(this._messageRepository);

  Future<Either<Exception, String>> sendMessage(
      MessageModel chatModel, String chatId) {
    return _messageRepository.sendMessage(chatModel, chatId);
  }
}
