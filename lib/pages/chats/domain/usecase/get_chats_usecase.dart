import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/chat/chat_model.dart';
import '../repository/get_chats_repository.dart';

class GetChatsUsecase{
  final GetChatsRepository _chatsRepository;

  GetChatsUsecase(this._chatsRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(){
    return _chatsRepository.getChats();
  } 

  Future<Either<String, ChatModel>> addChat(ChatModel chatData) {
    return _chatsRepository.addChat(chatData);
  }
}