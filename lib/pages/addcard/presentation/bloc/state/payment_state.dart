part of '../cubit/payment_cubit.dart';

class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {}

class PaymentError extends PaymentState {}
