part of '../cubits/send_notification_cubit.dart';

class SendNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendNotificationInitial extends SendNotificationState {}

class SendNotificationLoading extends SendNotificationState {}

class SendNotificationLoaded extends SendNotificationState {}

class SendNotificationError extends SendNotificationState {
  final String message;
  SendNotificationError(this.message);
}
