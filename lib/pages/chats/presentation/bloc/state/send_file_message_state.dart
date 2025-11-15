part of '../cubit/send_file_message_cubit.dart';

class SendFileMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendFileMessageInitial extends SendFileMessageState {}

class SendFileMessageLoading extends SendFileMessageState {}

class SendFileMessageSuccess extends SendFileMessageState {}

class SendFileMessageFailure extends SendFileMessageState {}
