// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  String get chatId => throw _privateConstructorUsedError;
  List<dynamic> get participiants => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  String get lastMessageTime => throw _privateConstructorUsedError;
  String get lastMessageSenderId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get chatType => throw _privateConstructorUsedError;
  String get chatName => throw _privateConstructorUsedError;
  String get chatAdmin => throw _privateConstructorUsedError;
  String get chatImage => throw _privateConstructorUsedError;

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call({
    String chatId,
    List<dynamic> participiants,
    String lastMessage,
    String lastMessageTime,
    String lastMessageSenderId,
    String createdAt,
    String chatType,
    String chatName,
    String chatAdmin,
    String chatImage,
  });
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? participiants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageSenderId = null,
    Object? createdAt = null,
    Object? chatType = null,
    Object? chatName = null,
    Object? chatAdmin = null,
    Object? chatImage = null,
  }) {
    return _then(
      _value.copyWith(
            chatId: null == chatId
                ? _value.chatId
                : chatId // ignore: cast_nullable_to_non_nullable
                      as String,
            participiants: null == participiants
                ? _value.participiants
                : participiants // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            lastMessage: null == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            lastMessageTime: null == lastMessageTime
                ? _value.lastMessageTime
                : lastMessageTime // ignore: cast_nullable_to_non_nullable
                      as String,
            lastMessageSenderId: null == lastMessageSenderId
                ? _value.lastMessageSenderId
                : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            chatType: null == chatType
                ? _value.chatType
                : chatType // ignore: cast_nullable_to_non_nullable
                      as String,
            chatName: null == chatName
                ? _value.chatName
                : chatName // ignore: cast_nullable_to_non_nullable
                      as String,
            chatAdmin: null == chatAdmin
                ? _value.chatAdmin
                : chatAdmin // ignore: cast_nullable_to_non_nullable
                      as String,
            chatImage: null == chatImage
                ? _value.chatImage
                : chatImage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
    _$ChatModelImpl value,
    $Res Function(_$ChatModelImpl) then,
  ) = __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String chatId,
    List<dynamic> participiants,
    String lastMessage,
    String lastMessageTime,
    String lastMessageSenderId,
    String createdAt,
    String chatType,
    String chatName,
    String chatAdmin,
    String chatImage,
  });
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
    _$ChatModelImpl _value,
    $Res Function(_$ChatModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? participiants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageSenderId = null,
    Object? createdAt = null,
    Object? chatType = null,
    Object? chatName = null,
    Object? chatAdmin = null,
    Object? chatImage = null,
  }) {
    return _then(
      _$ChatModelImpl(
        chatId: null == chatId
            ? _value.chatId
            : chatId // ignore: cast_nullable_to_non_nullable
                  as String,
        participiants: null == participiants
            ? _value._participiants
            : participiants // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        lastMessage: null == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        lastMessageTime: null == lastMessageTime
            ? _value.lastMessageTime
            : lastMessageTime // ignore: cast_nullable_to_non_nullable
                  as String,
        lastMessageSenderId: null == lastMessageSenderId
            ? _value.lastMessageSenderId
            : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        chatType: null == chatType
            ? _value.chatType
            : chatType // ignore: cast_nullable_to_non_nullable
                  as String,
        chatName: null == chatName
            ? _value.chatName
            : chatName // ignore: cast_nullable_to_non_nullable
                  as String,
        chatAdmin: null == chatAdmin
            ? _value.chatAdmin
            : chatAdmin // ignore: cast_nullable_to_non_nullable
                  as String,
        chatImage: null == chatImage
            ? _value.chatImage
            : chatImage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatModelImpl implements _ChatModel {
  _$ChatModelImpl({
    this.chatId = "",
    final List<dynamic> participiants = const [],
    this.lastMessage = "",
    this.lastMessageTime = "",
    this.lastMessageSenderId = "",
    this.createdAt = "",
    this.chatType = "",
    this.chatName = "",
    this.chatAdmin = "",
    this.chatImage = "",
  }) : _participiants = participiants;

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

  @override
  @JsonKey()
  final String chatId;
  final List<dynamic> _participiants;
  @override
  @JsonKey()
  List<dynamic> get participiants {
    if (_participiants is EqualUnmodifiableListView) return _participiants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participiants);
  }

  @override
  @JsonKey()
  final String lastMessage;
  @override
  @JsonKey()
  final String lastMessageTime;
  @override
  @JsonKey()
  final String lastMessageSenderId;
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String chatType;
  @override
  @JsonKey()
  final String chatName;
  @override
  @JsonKey()
  final String chatAdmin;
  @override
  @JsonKey()
  final String chatImage;

  @override
  String toString() {
    return 'ChatModel(chatId: $chatId, participiants: $participiants, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, lastMessageSenderId: $lastMessageSenderId, createdAt: $createdAt, chatType: $chatType, chatName: $chatName, chatAdmin: $chatAdmin, chatImage: $chatImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            const DeepCollectionEquality().equals(
              other._participiants,
              _participiants,
            ) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.chatName, chatName) ||
                other.chatName == chatName) &&
            (identical(other.chatAdmin, chatAdmin) ||
                other.chatAdmin == chatAdmin) &&
            (identical(other.chatImage, chatImage) ||
                other.chatImage == chatImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    chatId,
    const DeepCollectionEquality().hash(_participiants),
    lastMessage,
    lastMessageTime,
    lastMessageSenderId,
    createdAt,
    chatType,
    chatName,
    chatAdmin,
    chatImage,
  );

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(this);
  }
}

abstract class _ChatModel implements ChatModel {
  factory _ChatModel({
    final String chatId,
    final List<dynamic> participiants,
    final String lastMessage,
    final String lastMessageTime,
    final String lastMessageSenderId,
    final String createdAt,
    final String chatType,
    final String chatName,
    final String chatAdmin,
    final String chatImage,
  }) = _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  String get chatId;
  @override
  List<dynamic> get participiants;
  @override
  String get lastMessage;
  @override
  String get lastMessageTime;
  @override
  String get lastMessageSenderId;
  @override
  String get createdAt;
  @override
  String get chatType;
  @override
  String get chatName;
  @override
  String get chatAdmin;
  @override
  String get chatImage;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
