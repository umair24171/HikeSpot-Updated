part of '../cubit/login_create_cubit.dart';

class LoginCreateState extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoginCreateInitial extends LoginCreateState {
  @override
  List<Object?> get props => [];
}

class LoginCreateLoading extends LoginCreateState {
  @override
  List<Object?> get props => [];
}

class LoginCreateSuccess extends LoginCreateState {
  @override
  List<Object?> get props => [];
}

class LoginCreateFailure extends LoginCreateState {
  final String message;

  LoginCreateFailure(this.message);

  @override
  List<Object?> get props => [message];
}
