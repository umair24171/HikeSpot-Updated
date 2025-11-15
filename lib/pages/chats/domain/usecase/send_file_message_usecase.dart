import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/model/message/message_model.dart';
import '../repository/send_file_message_repository.dart';


class SendFileMessageUseCase {
  final SendFileMessageRepository _messageRepository;

  SendFileMessageUseCase(this._messageRepository);

 Future<Either<Exception, MessageModel>> sendFileMessage(File file, MessageModel message) async {
    return await _messageRepository.sendFileMessage(file, message);
  }
}
