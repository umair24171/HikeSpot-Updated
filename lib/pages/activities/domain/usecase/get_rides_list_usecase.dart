import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikespot/pages/activities/domain/repository/get_rides_list_repository.dart';
 

class GetRidesListUsecase {
  final GetRidesListRepository _ridesRepository;

  GetRidesListUsecase(this._ridesRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesList()  {
    return _ridesRepository.getRidesList();
  }
}