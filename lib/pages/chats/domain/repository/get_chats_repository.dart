import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/chat/chat_model.dart';


abstract class GetChatsRepository {

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats();
  Future<Either<String, ChatModel>> addChat(ChatModel chatData);
}