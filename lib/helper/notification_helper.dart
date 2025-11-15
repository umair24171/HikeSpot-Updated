import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hikespot/app/constants/links.dart';
import 'package:hikespot/encrypt/.env';

abstract class NotificationHelper {
  Future<Either<Exception, String>> sendNotification(
      {required String title,
      required String description,
      required List<String> pushId,
      String channelId = 'messages',
      Map<String, dynamic>? notificationData});
}

class NotificationHelperImpl extends NotificationHelper {
  final Dio _dio;
  NotificationHelperImpl(this._dio);

  @override
  Future<Either<Exception, String>> sendNotification(
      {required String title,
      required String description,
      Map<String, dynamic>? notificationData,
      String channelId = 'messages',
      required List<String> pushId}) async {
    final Map<String, dynamic> data = {
      "app_id":  oneSignalAppId,
      "contents": {"en": title},
      "headings": {"en": description},
      "target_channel": "push",
      "existing_android_channel_id": channelId,
      "include_aliases": {"external_id": pushId},
      "big_picture": AppLinks.appLogoUrl,
      "android_accent_color": "FFFF0000",
      "priority": 10,
      "data": notificationData,
    };

    final response = await _dio.post(
      AppLinks.notificationUrl,
      data: data,
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully!');
      return right('Notification sent successfully!');
    } else {
      debugPrint('Failed to send notification: ${response.statusCode}');
      debugPrint('Response: ${response.data}');
      return left(Exception('Failed to send notification'));
    }
  }
}
