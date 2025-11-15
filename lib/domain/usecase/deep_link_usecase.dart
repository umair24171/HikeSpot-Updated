import 'package:dartz/dartz.dart';
import 'package:hikespot/domain/repository/deep_link_repository.dart';

class DeepLinkUsecase {
  final DeepLinkRepository _repository;

  DeepLinkUsecase(this._repository);

  Future<Either<String, dynamic>> createDeepLink(String endPoint, String data) {
    return _repository.createDeepLink(endPoint, data);
  }

  void handleDeepLink(Uri uri, context) {
    return _repository.handleDeepLink(uri, context);
  }
}
