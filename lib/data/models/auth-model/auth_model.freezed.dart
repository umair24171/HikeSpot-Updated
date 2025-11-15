// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) {
  return _AuthModel.fromJson(json);
}

/// @nodoc
mixin _$AuthModel {
  // user data
  String get uid => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get firstname => throw _privateConstructorUsedError;
  String get lastname => throw _privateConstructorUsedError;
  String get idCardFront => throw _privateConstructorUsedError;
  String get idCardBack => throw _privateConstructorUsedError;
  List<dynamic> get scheduleRides => throw _privateConstructorUsedError;
  bool get notificationEnabled => throw _privateConstructorUsedError;
  String get referCode => throw _privateConstructorUsedError;
  List<String> get referedUsers => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError; // data
  String get createdAt => throw _privateConstructorUsedError;
  String get pushToken => throw _privateConstructorUsedError;
  double get ratings => throw _privateConstructorUsedError;
  int get totalRides => throw _privateConstructorUsedError; // driver data
  DriverModel get driverModel => throw _privateConstructorUsedError;
  bool get isRequestedDriver =>
      throw _privateConstructorUsedError; // card details
  List<CardModel> get cardModel => throw _privateConstructorUsedError;
  String get appStatus => throw _privateConstructorUsedError; // location
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;

  /// Serializes this AuthModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthModelCopyWith<AuthModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthModelCopyWith<$Res> {
  factory $AuthModelCopyWith(AuthModel value, $Res Function(AuthModel) then) =
      _$AuthModelCopyWithImpl<$Res, AuthModel>;
  @useResult
  $Res call({
    String uid,
    String phoneNumber,
    String email,
    String imageUrl,
    String username,
    String firstname,
    String lastname,
    String idCardFront,
    String idCardBack,
    List<dynamic> scheduleRides,
    bool notificationEnabled,
    String referCode,
    List<String> referedUsers,
    double balance,
    String createdAt,
    String pushToken,
    double ratings,
    int totalRides,
    DriverModel driverModel,
    bool isRequestedDriver,
    List<CardModel> cardModel,
    String appStatus,
    double latitude,
    double longitude,
    String address,
    bool isOnline,
  });

  $DriverModelCopyWith<$Res> get driverModel;
}

/// @nodoc
class _$AuthModelCopyWithImpl<$Res, $Val extends AuthModel>
    implements $AuthModelCopyWith<$Res> {
  _$AuthModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? imageUrl = null,
    Object? username = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? idCardFront = null,
    Object? idCardBack = null,
    Object? scheduleRides = null,
    Object? notificationEnabled = null,
    Object? referCode = null,
    Object? referedUsers = null,
    Object? balance = null,
    Object? createdAt = null,
    Object? pushToken = null,
    Object? ratings = null,
    Object? totalRides = null,
    Object? driverModel = null,
    Object? isRequestedDriver = null,
    Object? cardModel = null,
    Object? appStatus = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? isOnline = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            firstname: null == firstname
                ? _value.firstname
                : firstname // ignore: cast_nullable_to_non_nullable
                      as String,
            lastname: null == lastname
                ? _value.lastname
                : lastname // ignore: cast_nullable_to_non_nullable
                      as String,
            idCardFront: null == idCardFront
                ? _value.idCardFront
                : idCardFront // ignore: cast_nullable_to_non_nullable
                      as String,
            idCardBack: null == idCardBack
                ? _value.idCardBack
                : idCardBack // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduleRides: null == scheduleRides
                ? _value.scheduleRides
                : scheduleRides // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            notificationEnabled: null == notificationEnabled
                ? _value.notificationEnabled
                : notificationEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            referCode: null == referCode
                ? _value.referCode
                : referCode // ignore: cast_nullable_to_non_nullable
                      as String,
            referedUsers: null == referedUsers
                ? _value.referedUsers
                : referedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            pushToken: null == pushToken
                ? _value.pushToken
                : pushToken // ignore: cast_nullable_to_non_nullable
                      as String,
            ratings: null == ratings
                ? _value.ratings
                : ratings // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRides: null == totalRides
                ? _value.totalRides
                : totalRides // ignore: cast_nullable_to_non_nullable
                      as int,
            driverModel: null == driverModel
                ? _value.driverModel
                : driverModel // ignore: cast_nullable_to_non_nullable
                      as DriverModel,
            isRequestedDriver: null == isRequestedDriver
                ? _value.isRequestedDriver
                : isRequestedDriver // ignore: cast_nullable_to_non_nullable
                      as bool,
            cardModel: null == cardModel
                ? _value.cardModel
                : cardModel // ignore: cast_nullable_to_non_nullable
                      as List<CardModel>,
            appStatus: null == appStatus
                ? _value.appStatus
                : appStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            isOnline: null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverModelCopyWith<$Res> get driverModel {
    return $DriverModelCopyWith<$Res>(_value.driverModel, (value) {
      return _then(_value.copyWith(driverModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthModelImplCopyWith<$Res>
    implements $AuthModelCopyWith<$Res> {
  factory _$$AuthModelImplCopyWith(
    _$AuthModelImpl value,
    $Res Function(_$AuthModelImpl) then,
  ) = __$$AuthModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String phoneNumber,
    String email,
    String imageUrl,
    String username,
    String firstname,
    String lastname,
    String idCardFront,
    String idCardBack,
    List<dynamic> scheduleRides,
    bool notificationEnabled,
    String referCode,
    List<String> referedUsers,
    double balance,
    String createdAt,
    String pushToken,
    double ratings,
    int totalRides,
    DriverModel driverModel,
    bool isRequestedDriver,
    List<CardModel> cardModel,
    String appStatus,
    double latitude,
    double longitude,
    String address,
    bool isOnline,
  });

  @override
  $DriverModelCopyWith<$Res> get driverModel;
}

/// @nodoc
class __$$AuthModelImplCopyWithImpl<$Res>
    extends _$AuthModelCopyWithImpl<$Res, _$AuthModelImpl>
    implements _$$AuthModelImplCopyWith<$Res> {
  __$$AuthModelImplCopyWithImpl(
    _$AuthModelImpl _value,
    $Res Function(_$AuthModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? imageUrl = null,
    Object? username = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? idCardFront = null,
    Object? idCardBack = null,
    Object? scheduleRides = null,
    Object? notificationEnabled = null,
    Object? referCode = null,
    Object? referedUsers = null,
    Object? balance = null,
    Object? createdAt = null,
    Object? pushToken = null,
    Object? ratings = null,
    Object? totalRides = null,
    Object? driverModel = null,
    Object? isRequestedDriver = null,
    Object? cardModel = null,
    Object? appStatus = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? isOnline = null,
  }) {
    return _then(
      _$AuthModelImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        firstname: null == firstname
            ? _value.firstname
            : firstname // ignore: cast_nullable_to_non_nullable
                  as String,
        lastname: null == lastname
            ? _value.lastname
            : lastname // ignore: cast_nullable_to_non_nullable
                  as String,
        idCardFront: null == idCardFront
            ? _value.idCardFront
            : idCardFront // ignore: cast_nullable_to_non_nullable
                  as String,
        idCardBack: null == idCardBack
            ? _value.idCardBack
            : idCardBack // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduleRides: null == scheduleRides
            ? _value._scheduleRides
            : scheduleRides // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        notificationEnabled: null == notificationEnabled
            ? _value.notificationEnabled
            : notificationEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        referCode: null == referCode
            ? _value.referCode
            : referCode // ignore: cast_nullable_to_non_nullable
                  as String,
        referedUsers: null == referedUsers
            ? _value._referedUsers
            : referedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        pushToken: null == pushToken
            ? _value.pushToken
            : pushToken // ignore: cast_nullable_to_non_nullable
                  as String,
        ratings: null == ratings
            ? _value.ratings
            : ratings // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRides: null == totalRides
            ? _value.totalRides
            : totalRides // ignore: cast_nullable_to_non_nullable
                  as int,
        driverModel: null == driverModel
            ? _value.driverModel
            : driverModel // ignore: cast_nullable_to_non_nullable
                  as DriverModel,
        isRequestedDriver: null == isRequestedDriver
            ? _value.isRequestedDriver
            : isRequestedDriver // ignore: cast_nullable_to_non_nullable
                  as bool,
        cardModel: null == cardModel
            ? _value._cardModel
            : cardModel // ignore: cast_nullable_to_non_nullable
                  as List<CardModel>,
        appStatus: null == appStatus
            ? _value.appStatus
            : appStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        isOnline: null == isOnline
            ? _value.isOnline
            : isOnline // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthModelImpl implements _AuthModel {
  const _$AuthModelImpl({
    this.uid = "",
    this.phoneNumber = "",
    this.email = "",
    this.imageUrl = "",
    this.username = "",
    this.firstname = "",
    this.lastname = "",
    this.idCardFront = "",
    this.idCardBack = "",
    final List<dynamic> scheduleRides = const [],
    this.notificationEnabled = true,
    this.referCode = "",
    final List<String> referedUsers = const [],
    this.balance = 0,
    this.createdAt = "",
    this.pushToken = "",
    this.ratings = 0.0,
    this.totalRides = 0,
    this.driverModel = const DriverModel(),
    this.isRequestedDriver = false,
    final List<CardModel> cardModel = const [],
    this.appStatus = "",
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.isOnline = false,
  }) : _scheduleRides = scheduleRides,
       _referedUsers = referedUsers,
       _cardModel = cardModel;

  factory _$AuthModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthModelImplFromJson(json);

  // user data
  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String firstname;
  @override
  @JsonKey()
  final String lastname;
  @override
  @JsonKey()
  final String idCardFront;
  @override
  @JsonKey()
  final String idCardBack;
  final List<dynamic> _scheduleRides;
  @override
  @JsonKey()
  List<dynamic> get scheduleRides {
    if (_scheduleRides is EqualUnmodifiableListView) return _scheduleRides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduleRides);
  }

  @override
  @JsonKey()
  final bool notificationEnabled;
  @override
  @JsonKey()
  final String referCode;
  final List<String> _referedUsers;
  @override
  @JsonKey()
  List<String> get referedUsers {
    if (_referedUsers is EqualUnmodifiableListView) return _referedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_referedUsers);
  }

  @override
  @JsonKey()
  final double balance;
  // data
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String pushToken;
  @override
  @JsonKey()
  final double ratings;
  @override
  @JsonKey()
  final int totalRides;
  // driver data
  @override
  @JsonKey()
  final DriverModel driverModel;
  @override
  @JsonKey()
  final bool isRequestedDriver;
  // card details
  final List<CardModel> _cardModel;
  // card details
  @override
  @JsonKey()
  List<CardModel> get cardModel {
    if (_cardModel is EqualUnmodifiableListView) return _cardModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardModel);
  }

  @override
  @JsonKey()
  final String appStatus;
  // location
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final bool isOnline;

  @override
  String toString() {
    return 'AuthModel(uid: $uid, phoneNumber: $phoneNumber, email: $email, imageUrl: $imageUrl, username: $username, firstname: $firstname, lastname: $lastname, idCardFront: $idCardFront, idCardBack: $idCardBack, scheduleRides: $scheduleRides, notificationEnabled: $notificationEnabled, referCode: $referCode, referedUsers: $referedUsers, balance: $balance, createdAt: $createdAt, pushToken: $pushToken, ratings: $ratings, totalRides: $totalRides, driverModel: $driverModel, isRequestedDriver: $isRequestedDriver, cardModel: $cardModel, appStatus: $appStatus, latitude: $latitude, longitude: $longitude, address: $address, isOnline: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.idCardFront, idCardFront) ||
                other.idCardFront == idCardFront) &&
            (identical(other.idCardBack, idCardBack) ||
                other.idCardBack == idCardBack) &&
            const DeepCollectionEquality().equals(
              other._scheduleRides,
              _scheduleRides,
            ) &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.referCode, referCode) ||
                other.referCode == referCode) &&
            const DeepCollectionEquality().equals(
              other._referedUsers,
              _referedUsers,
            ) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.ratings, ratings) || other.ratings == ratings) &&
            (identical(other.totalRides, totalRides) ||
                other.totalRides == totalRides) &&
            (identical(other.driverModel, driverModel) ||
                other.driverModel == driverModel) &&
            (identical(other.isRequestedDriver, isRequestedDriver) ||
                other.isRequestedDriver == isRequestedDriver) &&
            const DeepCollectionEquality().equals(
              other._cardModel,
              _cardModel,
            ) &&
            (identical(other.appStatus, appStatus) ||
                other.appStatus == appStatus) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    uid,
    phoneNumber,
    email,
    imageUrl,
    username,
    firstname,
    lastname,
    idCardFront,
    idCardBack,
    const DeepCollectionEquality().hash(_scheduleRides),
    notificationEnabled,
    referCode,
    const DeepCollectionEquality().hash(_referedUsers),
    balance,
    createdAt,
    pushToken,
    ratings,
    totalRides,
    driverModel,
    isRequestedDriver,
    const DeepCollectionEquality().hash(_cardModel),
    appStatus,
    latitude,
    longitude,
    address,
    isOnline,
  ]);

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthModelImplCopyWith<_$AuthModelImpl> get copyWith =>
      __$$AuthModelImplCopyWithImpl<_$AuthModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthModelImplToJson(this);
  }
}

abstract class _AuthModel implements AuthModel {
  const factory _AuthModel({
    final String uid,
    final String phoneNumber,
    final String email,
    final String imageUrl,
    final String username,
    final String firstname,
    final String lastname,
    final String idCardFront,
    final String idCardBack,
    final List<dynamic> scheduleRides,
    final bool notificationEnabled,
    final String referCode,
    final List<String> referedUsers,
    final double balance,
    final String createdAt,
    final String pushToken,
    final double ratings,
    final int totalRides,
    final DriverModel driverModel,
    final bool isRequestedDriver,
    final List<CardModel> cardModel,
    final String appStatus,
    final double latitude,
    final double longitude,
    final String address,
    final bool isOnline,
  }) = _$AuthModelImpl;

  factory _AuthModel.fromJson(Map<String, dynamic> json) =
      _$AuthModelImpl.fromJson;

  // user data
  @override
  String get uid;
  @override
  String get phoneNumber;
  @override
  String get email;
  @override
  String get imageUrl;
  @override
  String get username;
  @override
  String get firstname;
  @override
  String get lastname;
  @override
  String get idCardFront;
  @override
  String get idCardBack;
  @override
  List<dynamic> get scheduleRides;
  @override
  bool get notificationEnabled;
  @override
  String get referCode;
  @override
  List<String> get referedUsers;
  @override
  double get balance; // data
  @override
  String get createdAt;
  @override
  String get pushToken;
  @override
  double get ratings;
  @override
  int get totalRides; // driver data
  @override
  DriverModel get driverModel;
  @override
  bool get isRequestedDriver; // card details
  @override
  List<CardModel> get cardModel;
  @override
  String get appStatus; // location
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  bool get isOnline;

  /// Create a copy of AuthModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthModelImplCopyWith<_$AuthModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
