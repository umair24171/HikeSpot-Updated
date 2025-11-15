import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/model/message/message_model.dart';

abstract class SendFileMessageRepository {
  Future<Either<Exception, MessageModel>> sendFileMessage(File file, MessageModel message);
}
