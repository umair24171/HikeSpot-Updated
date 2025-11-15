part of '../cubits/auth_cubit.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}


class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final AuthModel authModel;
  AuthSuccess(this.authModel);
  @override
  List<Object?> get props => [authModel];
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}