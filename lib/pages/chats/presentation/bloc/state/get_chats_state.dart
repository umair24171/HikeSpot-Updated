part of '../cubit/get_chats_cubit.dart';

class GetChatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetChatsInitial extends GetChatsState {}

class GetChatsLoading extends GetChatsState {}

class GetChatsLoaded extends GetChatsState {}

class GetChatsError extends GetChatsState {}
