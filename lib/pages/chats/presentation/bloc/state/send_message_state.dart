part of '../cubit/send_message_cubit.dart';

class SendMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessageIntial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageLoaded extends SendMessageState {}

class SendMessageError extends SendMessageState {}


class GettingChatData extends SendMessageState{}
class GettedChatData extends SendMessageState{}
