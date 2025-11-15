import 'package:dartz/dartz.dart';
import 'package:hikespot/pages/login/domain/repository/login_create_repository.dart';

class LoginCreateUseCase {
  final LoginCreateRepository _loginRepository;

  LoginCreateUseCase(this._loginRepository);

  Future<Either<String, String>> create(context) {
    return _loginRepository.create(context);
  }
}
