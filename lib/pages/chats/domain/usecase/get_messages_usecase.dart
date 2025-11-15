import 'package:cloud_firestore/cloud_firestore.dart';

import '../repository/get_messages_repository.dart';

class GetMessagesUsecase {
  final GetMessagesRepository _chatRepository;

  GetMessagesUsecase(this._chatRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> call() {
    return _chatRepository.getMessages();
  }
}
