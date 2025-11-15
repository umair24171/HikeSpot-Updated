import 'package:dartz/dartz.dart';

abstract class DeepLinkRepository {
  Future<Either<String, dynamic>> createDeepLink(String endPoint, String data);
  void handleDeepLink(Uri uri, context);
}
