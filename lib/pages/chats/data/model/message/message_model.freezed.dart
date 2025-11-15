// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get sent => throw _privateConstructorUsedError;
  String get read => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderUsername => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get receiverUsername => throw _privateConstructorUsedError;
  String get secMessage => throw _privateConstructorUsedError;
  String get senderImage => throw _privateConstructorUsedError;
  String get reciverImage => throw _privateConstructorUsedError;
  bool get userOnlineState => throw _privateConstructorUsedError;

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
    MessageModel value,
    $Res Function(MessageModel) then,
  ) = _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call({
    String sent,
    String read,
    String type,
    String chatId,
    String message,
    double lat,
    double long,
    String senderId,
    String senderUsername,
    String messageId,
    String receiverId,
    String receiverUsername,
    String secMessage,
    String senderImage,
    String reciverImage,
    bool userOnlineState,
  });
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sent = null,
    Object? read = null,
    Object? type = null,
    Object? chatId = null,
    Object? message = null,
    Object? lat = null,
    Object? long = null,
    Object? senderId = null,
    Object? senderUsername = null,
    Object? messageId = null,
    Object? receiverId = null,
    Object? receiverUsername = null,
    Object? secMessage = null,
    Object? senderImage = null,
    Object? reciverImage = null,
    Object? userOnlineState = null,
  }) {
    return _then(
      _value.copyWith(
            sent: null == sent
                ? _value.sent
                : sent // ignore: cast_nullable_to_non_nullable
                      as String,
            read: null == read
                ? _value.read
                : read // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            chatId: null == chatId
                ? _value.chatId
                : chatId // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            long: null == long
                ? _value.long
                : long // ignore: cast_nullable_to_non_nullable
                      as double,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderUsername: null == senderUsername
                ? _value.senderUsername
                : senderUsername // ignore: cast_nullable_to_non_nullable
                      as String,
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverUsername: null == receiverUsername
                ? _value.receiverUsername
                : receiverUsername // ignore: cast_nullable_to_non_nullable
                      as String,
            secMessage: null == secMessage
                ? _value.secMessage
                : secMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            senderImage: null == senderImage
                ? _value.senderImage
                : senderImage // ignore: cast_nullable_to_non_nullable
                      as String,
            reciverImage: null == reciverImage
                ? _value.reciverImage
                : reciverImage // ignore: cast_nullable_to_non_nullable
                      as String,
            userOnlineState: null == userOnlineState
                ? _value.userOnlineState
                : userOnlineState // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
    _$MessageModelImpl value,
    $Res Function(_$MessageModelImpl) then,
  ) = __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sent,
    String read,
    String type,
    String chatId,
    String message,
    double lat,
    double long,
    String senderId,
    String senderUsername,
    String messageId,
    String receiverId,
    String receiverUsername,
    String secMessage,
    String senderImage,
    String reciverImage,
    bool userOnlineState,
  });
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
    _$MessageModelImpl _value,
    $Res Function(_$MessageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sent = null,
    Object? read = null,
    Object? type = null,
    Object? chatId = null,
    Object? message = null,
    Object? lat = null,
    Object? long = null,
    Object? senderId = null,
    Object? senderUsername = null,
    Object? messageId = null,
    Object? receiverId = null,
    Object? receiverUsername = null,
    Object? secMessage = null,
    Object? senderImage = null,
    Object? reciverImage = null,
    Object? userOnlineState = null,
  }) {
    return _then(
      _$MessageModelImpl(
        sent: null == sent
            ? _value.sent
            : sent // ignore: cast_nullable_to_non_nullable
                  as String,
        read: null == read
            ? _value.read
            : read // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        chatId: null == chatId
            ? _value.chatId
            : chatId // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        long: null == long
            ? _value.long
            : long // ignore: cast_nullable_to_non_nullable
                  as double,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderUsername: null == senderUsername
            ? _value.senderUsername
            : senderUsername // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverUsername: null == receiverUsername
            ? _value.receiverUsername
            : receiverUsername // ignore: cast_nullable_to_non_nullable
                  as String,
        secMessage: null == secMessage
            ? _value.secMessage
            : secMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        senderImage: null == senderImage
            ? _value.senderImage
            : senderImage // ignore: cast_nullable_to_non_nullable
                  as String,
        reciverImage: null == reciverImage
            ? _value.reciverImage
            : reciverImage // ignore: cast_nullable_to_non_nullable
                  as String,
        userOnlineState: null == userOnlineState
            ? _value.userOnlineState
            : userOnlineState // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl implements _MessageModel {
  const _$MessageModelImpl({
    this.sent = "",
    this.read = "",
    this.type = "",
    this.chatId = "",
    this.message = "",
    this.lat = 0,
    this.long = 0,
    this.senderId = "",
    this.senderUsername = "",
    this.messageId = "",
    this.receiverId = "",
    this.receiverUsername = "",
    this.secMessage = "",
    this.senderImage = "",
    this.reciverImage = "",
    this.userOnlineState = false,
  });

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  @JsonKey()
  final String sent;
  @override
  @JsonKey()
  final String read;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String chatId;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double long;
  @override
  @JsonKey()
  final String senderId;
  @override
  @JsonKey()
  final String senderUsername;
  @override
  @JsonKey()
  final String messageId;
  @override
  @JsonKey()
  final String receiverId;
  @override
  @JsonKey()
  final String receiverUsername;
  @override
  @JsonKey()
  final String secMessage;
  @override
  @JsonKey()
  final String senderImage;
  @override
  @JsonKey()
  final String reciverImage;
  @override
  @JsonKey()
  final bool userOnlineState;

  @override
  String toString() {
    return 'MessageModel(sent: $sent, read: $read, type: $type, chatId: $chatId, message: $message, lat: $lat, long: $long, senderId: $senderId, senderUsername: $senderUsername, messageId: $messageId, receiverId: $receiverId, receiverUsername: $receiverUsername, secMessage: $secMessage, senderImage: $senderImage, reciverImage: $reciverImage, userOnlineState: $userOnlineState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.long, long) || other.long == long) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderUsername, senderUsername) ||
                other.senderUsername == senderUsername) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverUsername, receiverUsername) ||
                other.receiverUsername == receiverUsername) &&
            (identical(other.secMessage, secMessage) ||
                other.secMessage == secMessage) &&
            (identical(other.senderImage, senderImage) ||
                other.senderImage == senderImage) &&
            (identical(other.reciverImage, reciverImage) ||
                other.reciverImage == reciverImage) &&
            (identical(other.userOnlineState, userOnlineState) ||
                other.userOnlineState == userOnlineState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sent,
    read,
    type,
    chatId,
    message,
    lat,
    long,
    senderId,
    senderUsername,
    messageId,
    receiverId,
    receiverUsername,
    secMessage,
    senderImage,
    reciverImage,
    userOnlineState,
  );

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(this);
  }
}

abstract class _MessageModel implements MessageModel {
  const factory _MessageModel({
    final String sent,
    final String read,
    final String type,
    final String chatId,
    final String message,
    final double lat,
    final double long,
    final String senderId,
    final String senderUsername,
    final String messageId,
    final String receiverId,
    final String receiverUsername,
    final String secMessage,
    final String senderImage,
    final String reciverImage,
    final bool userOnlineState,
  }) = _$MessageModelImpl;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  String get sent;
  @override
  String get read;
  @override
  String get type;
  @override
  String get chatId;
  @override
  String get message;
  @override
  double get lat;
  @override
  double get long;
  @override
  String get senderId;
  @override
  String get senderUsername;
  @override
  String get messageId;
  @override
  String get receiverId;
  @override
  String get receiverUsername;
  @override
  String get secMessage;
  @override
  String get senderImage;
  @override
  String get reciverImage;
  @override
  bool get userOnlineState;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
