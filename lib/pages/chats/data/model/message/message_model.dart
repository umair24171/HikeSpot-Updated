import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_model.freezed.dart';
part 'message_model.g.dart';

@Freezed()
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default("") String sent,
    @Default("") String read,
    @Default("") String type,
    @Default("") String chatId, 
    @Default("") String message,
    @Default(0) double lat,
    @Default(0) double long,
    @Default("") String senderId,
    @Default("") String senderUsername,
    @Default("") String messageId,
    @Default("") String receiverId,
    @Default("") String receiverUsername,
    @Default("") String secMessage,
    @Default("") String senderImage,
    @Default("") String reciverImage,
    @Default(false) bool userOnlineState,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

enum MessageType { text, image, video, audio, file ,location }
