
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetRidesListRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesList();
}