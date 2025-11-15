import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/encrypt/.env';
import 'package:hikespot/helper/notification_helper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
part '../states/send_notification_state.dart';

class SendNotificationCubit extends Cubit<SendNotificationState> {
  final NotificationHelper _notificationHelper;
  SendNotificationCubit(this._notificationHelper)
      : super(SendNotificationInitial());

  // // init notification helper
  Future<void> initOneSignal() async {
    OneSignal.initialize(oneSignalAppId);
    await OneSignal.Debug.setLogLevel(OSLogLevel.debug);
    await OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.onNotificationPermissionDidChange(true);
    OneSignal.Notifications.addClickListener(
      (event) {
        debugPrint('OneSignal Clicked: ${event.jsonRepresentation()}');
      },
    );
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (event) {
        debugPrint('OneSignal Foreground: ${event.jsonRepresentation()}');
      },
    );
    OneSignal.User.pushSubscription.addObserver(
      (event) {
        debugPrint(
            'OneSignal User Push Subscription: ${event.jsonRepresentation()}');
      },
    );
  }

  // send the notification
  Future<void> sendNotification({
    required  String title,required String body,required String userId
  }) async {
    emit(SendNotificationLoading());
    if(userId == Di().sl<AuthCubit>().authData.uid){
      emit(SendNotificationError("You can't send notification to yourself"));
      return;
    }
    var result = await _notificationHelper.sendNotification(
        title: title,
        description: body,
        pushId: [userId],
        channelId: 'messages',
        notificationData: {});
    result.fold(
      (error) {
        emit(SendNotificationError(error.toString()));
      },
      (data) {
        emit(SendNotificationLoaded());
      },
    );
  }

  // create the notification channels
  Future<void> createNotificationChannels() async {
    var messagesResult =
        await FlutterNotificationChannel().registerNotificationChannel(
      description: "This channel is for messages",
      id: AppConstants.messagesChannelId,
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: "Messages",
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    var ridesResult =
        await FlutterNotificationChannel().registerNotificationChannel(
      description: "This channel is for messages",
      id: AppConstants.ridesChannelId,
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: "Rides",
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    var paymentResult =
        await FlutterNotificationChannel().registerNotificationChannel(
      description: "This channel is for messages",
      id: AppConstants.paymentChannelId,
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: "Payments",
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    var chatsResult =
        await FlutterNotificationChannel().registerNotificationChannel(
      description: "This channel is for messages",
      id: AppConstants.chatsChannelId,
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: "Chats",
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    var promotionsResult =
        await FlutterNotificationChannel().registerNotificationChannel(
      description: "This channel is for messages",
      id: AppConstants.promotionsChannelId,
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: "Promotions",
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    debugPrint(messagesResult +
        ridesResult +
        paymentResult +
        chatsResult +
        promotionsResult);
  }
}
