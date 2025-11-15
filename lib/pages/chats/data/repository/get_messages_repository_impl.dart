import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/get_messages_repository.dart';
import '../datasource/get_messages_datasource.dart';

class GetMessagesRepositoryImpl extends GetMessagesRepository {
  final GetMessagesDataSource _chatsDatasource;

  GetMessagesRepositoryImpl(this._chatsDatasource);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return _chatsDatasource.getMessages();
  }
}
