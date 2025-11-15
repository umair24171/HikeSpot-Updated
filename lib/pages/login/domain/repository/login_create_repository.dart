import 'package:dartz/dartz.dart';

abstract class LoginCreateRepository {
  Future<Either<String, String>> create(context);
}
