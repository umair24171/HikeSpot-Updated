import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/message/message_model.dart';
import '../../../domain/usecase/get_messages_usecase.dart';
part '../state/get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  final GetMessagesUsecase _getMessagesUsecase;
  GetMessagesCubit(this._getMessagesUsecase) : super(GetMessagesInitial());

  List<MessageModel> messages = [];
  getMessagesLocal(List<MessageModel> messages) {
    emit(GetMessagesLoading());
    messages.sort((a, b) => a.sent.compareTo(b.sent));
    this.messages = messages;
    emit(GetMessagesLoded());
  }

  // get the chat data
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesDb() {
    return _getMessagesUsecase.call();
  }

  // get the single message data
  MessageModel addMessageData = const MessageModel();

  getSignleMessageData(MessageModel message) {
    emit(GetMessagesLoading());
    addMessageData = message;
    messages.add(message);
    log("what-get-messages-cubit: getSignleMessageData: $message , lenght ${messages.length}");
    emit(GetMessagesLoded());
  }
}
