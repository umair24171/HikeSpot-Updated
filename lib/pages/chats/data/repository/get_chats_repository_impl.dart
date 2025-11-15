import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/get_chats_repository.dart';
import '../datasource/get_chats_datasource.dart';
import '../model/chat/chat_model.dart';

class GetChatsRepositoryImpl extends GetChatsRepository {
  final GetChatsDatasource _chatsDatasource;

  GetChatsRepositoryImpl(this._chatsDatasource);
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    return _chatsDatasource.getChats();
  }

  @override
  Future<Either<String, ChatModel>> addChat(ChatModel chatData) {
    return _chatsDatasource.addChat(chatData);
  }
}
