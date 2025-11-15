import 'package:dartz/dartz.dart';

import '../../data/model/message/message_model.dart';


abstract class SendMessageRepository {
  Future<Either<Exception, String>> sendMessage(
      MessageModel chatModel, String chatId);
}
