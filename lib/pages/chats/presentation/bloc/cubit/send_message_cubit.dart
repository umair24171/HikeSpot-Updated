import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/send_notification_cubit.dart';
import 'package:uuid/uuid.dart';
import '../../../../../app/constants/encrypt_helper.dart';
import '../../../../../blocs/cubits/auth_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../data/models/auth-model/auth_model.dart';
import '../../../data/model/message/message_model.dart';
import '../../../domain/usecase/send_message_usecase.dart';
import 'get_chats_cubit.dart';
import 'get_messages_cubit.dart';
part '../state/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUsecase _messageUsecase;
  SendMessageCubit(this._messageUsecase) : super(SendMessageIntial());

  TextEditingController textEditingController = TextEditingController();
  String messageId = "";
  List<String> sendingMessages = [];
  List<String> errorMessages = [];
  MessageType messageType = MessageType.text;
  AuthModel otherUserData = const AuthModel();
  double latitude = 0.0;
  double longitude = 0.0;

  // get address
  getAddress(double lat, double long) {
    emit(SendMessageLoading());
    latitude = lat;
    longitude = long;
    emit(SendMessageLoaded());
  }

  // get the message Id
  getMessageId(String messageId) {
    emit(SendMessageLoading());
    this.messageId = messageId;
    emit(SendMessageLoaded());
  }

  // get the message type
  getMessageType(MessageType messageType) {
    emit(SendMessageLoading());
    this.messageType = messageType;
    emit(SendMessageLoaded());
  }

  // get the other user data
  getOtherUserData(AuthModel otherUserData) {
    emit(GettingChatData());
    this.otherUserData = otherUserData;
    emit(GettedChatData());
  }

  // make the message - NO ENCRYPTION
  MessageModel get message => MessageModel(
        chatId: Di().sl<GetChatsCubit>().chatData.chatId,
        message: textEditingController.text, // Send plain text - NO ENCRYPTION
        messageId: messageId,
        read: "",
        receiverId: otherUserData.uid,
        receiverUsername: otherUserData.username,
        secMessage: "",
        lat: latitude,
        long: longitude,
        reciverImage: otherUserData.imageUrl,
        senderId: Di().sl<AuthCubit>().authData.uid,
        senderUsername: Di().sl<AuthCubit>().authData.username,
        senderImage: Di().sl<AuthCubit>().authData.imageUrl,
        sent: DateTime.now().millisecondsSinceEpoch.toString(),
        type: messageType.name,
        userOnlineState: false,
      );

// send message
  Future<void> sendMessage(context) async {
    final GetMessagesCubit getMessagesCubit = Di().sl<GetMessagesCubit>();
    final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    var uid = const Uuid().v4();
    messageId = uid;
    log("Generated UID: $uid");
    emit(GettingChatData());
    addSendingMessages(messageId);
    MessageModel message = this.message.copyWith(
        sent: DateTime.now().millisecondsSinceEpoch.toString(), messageId: uid);
    getMessagesCubit.getSignleMessageData(message);

    textEditingController.clear();
    log(message.toString());
    var result = await _messageUsecase.sendMessage(
        message, Di().sl<GetChatsCubit>().chatData.chatId);
    sendNotificationCubit.sendNotification(
        title: message.message, // Plain text - NO DECRYPTION NEEDED
        body: message.senderUsername,
        userId: otherUserData.uid,
    );
    result.fold((l) {
      log("Error Occurred: $l");
      addErrorMessages(messageId);
      emit(SendMessageError());
    }, (r) {
      removeSendingMessage(messageId);
      messageId = "";
      log("Message Sent Successfully: $r ${sendingMessages.toString()}");
      emit(SendMessageLoaded());
    });
  }

  /// add the data in the sending messages
  void addSendingMessages(String messageId) {
    emit(GettingChatData());
    if (!sendingMessages.contains(messageId)) {
      sendingMessages.add(messageId);
    }
    emit(SendMessageLoaded());
  }

  /// remove the data from the sending messages
  void removeSendingMessage(String messageId) {
    emit(GettingChatData());
    sendingMessages.remove(messageId);
    emit(SendMessageLoaded());
  }

// add the error messages
  void addErrorMessages(String messageId) {
    emit(GettingChatData());
    if (!errorMessages.contains(messageId)) {
      errorMessages.add(messageId);
    }
    emit(SendMessageLoaded());
  }

}