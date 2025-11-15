import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@Freezed()
class ChatModel with _$ChatModel {
  factory ChatModel({
    @Default("") String chatId,
    @Default([]) List participiants,
    @Default("") String lastMessage,
    @Default("") String lastMessageTime,
    @Default("") String lastMessageSenderId,
    @Default("") String createdAt,
    @Default("") String chatType,
    @Default("") String chatName,
    @Default("") String chatAdmin,
    @Default("") String chatImage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
