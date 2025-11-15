import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../../../../blocs/cubits/send_notification_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../data/model/message/message_model.dart';
import '../../../domain/usecase/send_file_message_usecase.dart';
import 'get_messages_cubit.dart';
import 'send_message_cubit.dart';

part '../state/send_file_message_state.dart';

class SendFileMessageCubit extends Cubit<SendFileMessageState> {
  final SendFileMessageUseCase sendFileMessageUseCase;
  SendFileMessageCubit(this.sendFileMessageUseCase)
      : super(SendFileMessageInitial());

  // send the file message
  Future<void> sendFileMessage(
      File file, MessageType messageType, context) async {
    final SendMessageCubit sendMessageCubit = Di().sl<SendMessageCubit>();
    final GetMessagesCubit getMessagesCubit = Di().sl<GetMessagesCubit>();
        final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    emit(SendFileMessageLoading());
    try {
      log("what-send-file-message-cubit: sendFileMessage: $file");
      var uid = const Uuid().v4();
      log("Generated UID: $uid");

      sendMessageCubit.getMessageType(messageType);
      log("Message Type Set");

      sendMessageCubit.getMessageId(uid);
      log("Message ID Set");

      sendMessageCubit.addSendingMessages(uid);
      log("Message Added to Sending");
      MessageModel message = sendMessageCubit.message
          .copyWith(message: file.path, type: messageType.name, messageId: uid);
      log("MessageModel Created: ${message.toString()}");

      getMessagesCubit.getSignleMessageData(message);
      log("Single Message Data Retrieved");

      var result = await sendFileMessageUseCase.sendFileMessage(file, message);
      sendNotificationCubit.sendNotification(
        title: "New Message Received",
        body: message.senderUsername,
        userId: sendMessageCubit.otherUserData.uid,
    );
      log("File Message Use Case Result Received");
      result.fold(
        (error) {
          log("Error Occurred: $error");
          sendMessageCubit.addErrorMessages(message.messageId);
          emit(SendFileMessageFailure());
        },
        (url) {
          log("File Uploaded Successfully: $url, id: ${message.messageId}");
          getMessagesCubit.messages
              .where((element) => element.messageId == message.messageId)
              .first;
          message = message;
          sendMessageCubit.removeSendingMessage(message.messageId);
          emit(SendFileMessageSuccess());
        },
      );
    } catch (e) {
      log("Exception Caught: $e");
      sendMessageCubit.removeSendingMessage(sendMessageCubit.messageId);
      sendMessageCubit.addErrorMessages(sendMessageCubit.messageId);
      emit(SendFileMessageFailure());
    }
  }
}
