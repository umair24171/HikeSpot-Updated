import 'package:dartz/dartz.dart';
import 'package:hikespot/pages/login/data/datasource/login_create_datasource.dart';
import 'package:hikespot/pages/login/domain/repository/login_create_repository.dart';

class LoginCreateRepositoryImpl extends LoginCreateRepository {
  final LoginCreateDataSource dataSource;

  LoginCreateRepositoryImpl(this.dataSource);
  @override
  Future<Either<String, String>> create(context) {
    return dataSource.create(context);
  }
}
