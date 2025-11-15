// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      chatId: json['chatId'] as String? ?? "",
      participiants: json['participiants'] as List<dynamic>? ?? const [],
      lastMessage: json['lastMessage'] as String? ?? "",
      lastMessageTime: json['lastMessageTime'] as String? ?? "",
      lastMessageSenderId: json['lastMessageSenderId'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      chatType: json['chatType'] as String? ?? "",
      chatName: json['chatName'] as String? ?? "",
      chatAdmin: json['chatAdmin'] as String? ?? "",
      chatImage: json['chatImage'] as String? ?? "",
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'participiants': instance.participiants,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'lastMessageSenderId': instance.lastMessageSenderId,
      'createdAt': instance.createdAt,
      'chatType': instance.chatType,
      'chatName': instance.chatName,
      'chatAdmin': instance.chatAdmin,
      'chatImage': instance.chatImage,
    };
