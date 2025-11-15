// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      sent: json['sent'] as String? ?? "",
      read: json['read'] as String? ?? "",
      type: json['type'] as String? ?? "",
      chatId: json['chatId'] as String? ?? "",
      message: json['message'] as String? ?? "",
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      long: (json['long'] as num?)?.toDouble() ?? 0,
      senderId: json['senderId'] as String? ?? "",
      senderUsername: json['senderUsername'] as String? ?? "",
      messageId: json['messageId'] as String? ?? "",
      receiverId: json['receiverId'] as String? ?? "",
      receiverUsername: json['receiverUsername'] as String? ?? "",
      secMessage: json['secMessage'] as String? ?? "",
      senderImage: json['senderImage'] as String? ?? "",
      reciverImage: json['reciverImage'] as String? ?? "",
      userOnlineState: json['userOnlineState'] as bool? ?? false,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'sent': instance.sent,
      'read': instance.read,
      'type': instance.type,
      'chatId': instance.chatId,
      'message': instance.message,
      'lat': instance.lat,
      'long': instance.long,
      'senderId': instance.senderId,
      'senderUsername': instance.senderUsername,
      'messageId': instance.messageId,
      'receiverId': instance.receiverId,
      'receiverUsername': instance.receiverUsername,
      'secMessage': instance.secMessage,
      'senderImage': instance.senderImage,
      'reciverImage': instance.reciverImage,
      'userOnlineState': instance.userOnlineState,
    };
