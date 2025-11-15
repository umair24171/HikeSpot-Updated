part of '../cubit/otp_verify_cubit.dart';

class OtpVerifyState extends Equatable {
  @override
  List<Object?> get props => [];
}


class OtpVerifyInitial extends OtpVerifyState {
  @override
  List<Object?> get props => [];
}

class OtpVerifyLoading extends OtpVerifyState {
  @override
  List<Object?> get props => [];
}

class OtpVerifySuccess extends OtpVerifyState {
  final AuthModel authModel;

  OtpVerifySuccess(this.authModel);

  @override
  List<Object?> get props => [authModel];
}

class OtpVerifyFailure extends OtpVerifyState {
  final String message;

  OtpVerifyFailure(this.message);

  @override
  List<Object?> get props => [message];
}