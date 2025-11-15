import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repository/get_rides_list_repository.dart';
import '../datasources/get_rides_list_datasource.dart';

class GetRidesListRepositoryImpl implements GetRidesListRepository {
  final GetRidesListDatasource dataSource;

  GetRidesListRepositoryImpl(  this.dataSource);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesList()  {
    return dataSource.getRidesList();
  }
}
