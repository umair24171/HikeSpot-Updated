part of '../cubits/text_field_cubit.dart';

sealed class PhoneTextFieldState extends Equatable {
  const PhoneTextFieldState();
}

final class PhoneTextFieldInitial extends PhoneTextFieldState {
  @override
  List<Object> get props => [];
}


final class PhoneTextFieldGetting extends PhoneTextFieldState {
  @override
  List<Object> get props => [];
}

final class PhoneTextFieldGetted extends PhoneTextFieldState {
  @override
  List<Object> get props => [];
}

