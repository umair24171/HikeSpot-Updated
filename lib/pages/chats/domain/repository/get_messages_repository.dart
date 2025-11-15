import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetMessagesRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages();
}