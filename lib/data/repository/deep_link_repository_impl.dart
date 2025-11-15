import 'package:dartz/dartz.dart';
import 'package:hikespot/data/datsource/deep_link_datasource.dart';
import 'package:hikespot/domain/repository/deep_link_repository.dart';

class DeepLinkRepositoryImpl extends DeepLinkRepository{
  final DeepLinkDatasource _datasource;

  DeepLinkRepositoryImpl(this._datasource);
  @override
  Future<Either<String, dynamic>> createDeepLink(String endPoint, String data) {
    return _datasource.createDeepLink(endPoint, data);
  }

  @override
  void handleDeepLink(Uri uri, context) {
   return _datasource.handleDeepLink(uri, context);
  }
  
}