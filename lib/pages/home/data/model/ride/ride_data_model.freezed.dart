// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RideDataModel _$RideDataModelFromJson(Map<String, dynamic> json) {
  return _RideDataModel.fromJson(json);
}

/// @nodoc
mixin _$RideDataModel {
  String get rideType => throw _privateConstructorUsedError;
  String get rideStatus => throw _privateConstructorUsedError;
  String get rideId => throw _privateConstructorUsedError; // driver data
  String get driverId => throw _privateConstructorUsedError;
  String get driverName => throw _privateConstructorUsedError;
  String get driverPhone => throw _privateConstructorUsedError;
  String get driverImage => throw _privateConstructorUsedError;
  String get driverRatings => throw _privateConstructorUsedError;
  String get driverRideCounts =>
      throw _privateConstructorUsedError; // user data
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get usernumber => throw _privateConstructorUsedError;
  String get userimage => throw _privateConstructorUsedError;
  String get userRatings => throw _privateConstructorUsedError;
  String get userRideCounts =>
      throw _privateConstructorUsedError; // location coordinates
  double get pickupLatitude => throw _privateConstructorUsedError;
  double get pickupLongitude => throw _privateConstructorUsedError;
  double get destinationLatitude => throw _privateConstructorUsedError;
  double get destinationLongitude => throw _privateConstructorUsedError;
  double get stepOverLatitude => throw _privateConstructorUsedError;
  double get stepOverLongitude =>
      throw _privateConstructorUsedError; // location steps
  String get pickupAddress => throw _privateConstructorUsedError;
  String get destinationAddress => throw _privateConstructorUsedError;
  String get stepOverAddress =>
      throw _privateConstructorUsedError; // ride details
  double get distance => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  double get fare => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  String get paymentDate => throw _privateConstructorUsedError;
  String get rideDate => throw _privateConstructorUsedError;
  String get rideTime => throw _privateConstructorUsedError;
  String get rideStartDate => throw _privateConstructorUsedError;
  String get rideEndDate => throw _privateConstructorUsedError;
  String get entranceDetail =>
      throw _privateConstructorUsedError; // filter passenger details
  int get passengerCounts => throw _privateConstructorUsedError;
  int get seatsBooked => throw _privateConstructorUsedError; // comments
  String get comment =>
      throw _privateConstructorUsedError; // 🔥 NEW: Parcel Delivery Fields
  bool get isParcelDelivery => throw _privateConstructorUsedError;
  String get parcelSize => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String get receiverPhone => throw _privateConstructorUsedError;

  /// Serializes this RideDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RideDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RideDataModelCopyWith<RideDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RideDataModelCopyWith<$Res> {
  factory $RideDataModelCopyWith(
    RideDataModel value,
    $Res Function(RideDataModel) then,
  ) = _$RideDataModelCopyWithImpl<$Res, RideDataModel>;
  @useResult
  $Res call({
    String rideType,
    String rideStatus,
    String rideId,
    String driverId,
    String driverName,
    String driverPhone,
    String driverImage,
    String driverRatings,
    String driverRideCounts,
    String userId,
    String username,
    String usernumber,
    String userimage,
    String userRatings,
    String userRideCounts,
    double pickupLatitude,
    double pickupLongitude,
    double destinationLatitude,
    double destinationLongitude,
    double stepOverLatitude,
    double stepOverLongitude,
    String pickupAddress,
    String destinationAddress,
    String stepOverAddress,
    double distance,
    double duration,
    double fare,
    double rating,
    String paymentMethod,
    String paymentStatus,
    String paymentId,
    String paymentDate,
    String rideDate,
    String rideTime,
    String rideStartDate,
    String rideEndDate,
    String entranceDetail,
    int passengerCounts,
    int seatsBooked,
    String comment,
    bool isParcelDelivery,
    String parcelSize,
    String receiverName,
    String receiverPhone,
  });
}

/// @nodoc
class _$RideDataModelCopyWithImpl<$Res, $Val extends RideDataModel>
    implements $RideDataModelCopyWith<$Res> {
  _$RideDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RideDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideType = null,
    Object? rideStatus = null,
    Object? rideId = null,
    Object? driverId = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? driverImage = null,
    Object? driverRatings = null,
    Object? driverRideCounts = null,
    Object? userId = null,
    Object? username = null,
    Object? usernumber = null,
    Object? userimage = null,
    Object? userRatings = null,
    Object? userRideCounts = null,
    Object? pickupLatitude = null,
    Object? pickupLongitude = null,
    Object? destinationLatitude = null,
    Object? destinationLongitude = null,
    Object? stepOverLatitude = null,
    Object? stepOverLongitude = null,
    Object? pickupAddress = null,
    Object? destinationAddress = null,
    Object? stepOverAddress = null,
    Object? distance = null,
    Object? duration = null,
    Object? fare = null,
    Object? rating = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? paymentId = null,
    Object? paymentDate = null,
    Object? rideDate = null,
    Object? rideTime = null,
    Object? rideStartDate = null,
    Object? rideEndDate = null,
    Object? entranceDetail = null,
    Object? passengerCounts = null,
    Object? seatsBooked = null,
    Object? comment = null,
    Object? isParcelDelivery = null,
    Object? parcelSize = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
  }) {
    return _then(
      _value.copyWith(
            rideType: null == rideType
                ? _value.rideType
                : rideType // ignore: cast_nullable_to_non_nullable
                      as String,
            rideStatus: null == rideStatus
                ? _value.rideStatus
                : rideStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            rideId: null == rideId
                ? _value.rideId
                : rideId // ignore: cast_nullable_to_non_nullable
                      as String,
            driverId: null == driverId
                ? _value.driverId
                : driverId // ignore: cast_nullable_to_non_nullable
                      as String,
            driverName: null == driverName
                ? _value.driverName
                : driverName // ignore: cast_nullable_to_non_nullable
                      as String,
            driverPhone: null == driverPhone
                ? _value.driverPhone
                : driverPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            driverImage: null == driverImage
                ? _value.driverImage
                : driverImage // ignore: cast_nullable_to_non_nullable
                      as String,
            driverRatings: null == driverRatings
                ? _value.driverRatings
                : driverRatings // ignore: cast_nullable_to_non_nullable
                      as String,
            driverRideCounts: null == driverRideCounts
                ? _value.driverRideCounts
                : driverRideCounts // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            usernumber: null == usernumber
                ? _value.usernumber
                : usernumber // ignore: cast_nullable_to_non_nullable
                      as String,
            userimage: null == userimage
                ? _value.userimage
                : userimage // ignore: cast_nullable_to_non_nullable
                      as String,
            userRatings: null == userRatings
                ? _value.userRatings
                : userRatings // ignore: cast_nullable_to_non_nullable
                      as String,
            userRideCounts: null == userRideCounts
                ? _value.userRideCounts
                : userRideCounts // ignore: cast_nullable_to_non_nullable
                      as String,
            pickupLatitude: null == pickupLatitude
                ? _value.pickupLatitude
                : pickupLatitude // ignore: cast_nullable_to_non_nullable
                      as double,
            pickupLongitude: null == pickupLongitude
                ? _value.pickupLongitude
                : pickupLongitude // ignore: cast_nullable_to_non_nullable
                      as double,
            destinationLatitude: null == destinationLatitude
                ? _value.destinationLatitude
                : destinationLatitude // ignore: cast_nullable_to_non_nullable
                      as double,
            destinationLongitude: null == destinationLongitude
                ? _value.destinationLongitude
                : destinationLongitude // ignore: cast_nullable_to_non_nullable
                      as double,
            stepOverLatitude: null == stepOverLatitude
                ? _value.stepOverLatitude
                : stepOverLatitude // ignore: cast_nullable_to_non_nullable
                      as double,
            stepOverLongitude: null == stepOverLongitude
                ? _value.stepOverLongitude
                : stepOverLongitude // ignore: cast_nullable_to_non_nullable
                      as double,
            pickupAddress: null == pickupAddress
                ? _value.pickupAddress
                : pickupAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationAddress: null == destinationAddress
                ? _value.destinationAddress
                : destinationAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            stepOverAddress: null == stepOverAddress
                ? _value.stepOverAddress
                : stepOverAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as double,
            fare: null == fare
                ? _value.fare
                : fare // ignore: cast_nullable_to_non_nullable
                      as double,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentStatus: null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentId: null == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentDate: null == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                      as String,
            rideDate: null == rideDate
                ? _value.rideDate
                : rideDate // ignore: cast_nullable_to_non_nullable
                      as String,
            rideTime: null == rideTime
                ? _value.rideTime
                : rideTime // ignore: cast_nullable_to_non_nullable
                      as String,
            rideStartDate: null == rideStartDate
                ? _value.rideStartDate
                : rideStartDate // ignore: cast_nullable_to_non_nullable
                      as String,
            rideEndDate: null == rideEndDate
                ? _value.rideEndDate
                : rideEndDate // ignore: cast_nullable_to_non_nullable
                      as String,
            entranceDetail: null == entranceDetail
                ? _value.entranceDetail
                : entranceDetail // ignore: cast_nullable_to_non_nullable
                      as String,
            passengerCounts: null == passengerCounts
                ? _value.passengerCounts
                : passengerCounts // ignore: cast_nullable_to_non_nullable
                      as int,
            seatsBooked: null == seatsBooked
                ? _value.seatsBooked
                : seatsBooked // ignore: cast_nullable_to_non_nullable
                      as int,
            comment: null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String,
            isParcelDelivery: null == isParcelDelivery
                ? _value.isParcelDelivery
                : isParcelDelivery // ignore: cast_nullable_to_non_nullable
                      as bool,
            parcelSize: null == parcelSize
                ? _value.parcelSize
                : parcelSize // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: null == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverPhone: null == receiverPhone
                ? _value.receiverPhone
                : receiverPhone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RideDataModelImplCopyWith<$Res>
    implements $RideDataModelCopyWith<$Res> {
  factory _$$RideDataModelImplCopyWith(
    _$RideDataModelImpl value,
    $Res Function(_$RideDataModelImpl) then,
  ) = __$$RideDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String rideType,
    String rideStatus,
    String rideId,
    String driverId,
    String driverName,
    String driverPhone,
    String driverImage,
    String driverRatings,
    String driverRideCounts,
    String userId,
    String username,
    String usernumber,
    String userimage,
    String userRatings,
    String userRideCounts,
    double pickupLatitude,
    double pickupLongitude,
    double destinationLatitude,
    double destinationLongitude,
    double stepOverLatitude,
    double stepOverLongitude,
    String pickupAddress,
    String destinationAddress,
    String stepOverAddress,
    double distance,
    double duration,
    double fare,
    double rating,
    String paymentMethod,
    String paymentStatus,
    String paymentId,
    String paymentDate,
    String rideDate,
    String rideTime,
    String rideStartDate,
    String rideEndDate,
    String entranceDetail,
    int passengerCounts,
    int seatsBooked,
    String comment,
    bool isParcelDelivery,
    String parcelSize,
    String receiverName,
    String receiverPhone,
  });
}

/// @nodoc
class __$$RideDataModelImplCopyWithImpl<$Res>
    extends _$RideDataModelCopyWithImpl<$Res, _$RideDataModelImpl>
    implements _$$RideDataModelImplCopyWith<$Res> {
  __$$RideDataModelImplCopyWithImpl(
    _$RideDataModelImpl _value,
    $Res Function(_$RideDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RideDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideType = null,
    Object? rideStatus = null,
    Object? rideId = null,
    Object? driverId = null,
    Object? driverName = null,
    Object? driverPhone = null,
    Object? driverImage = null,
    Object? driverRatings = null,
    Object? driverRideCounts = null,
    Object? userId = null,
    Object? username = null,
    Object? usernumber = null,
    Object? userimage = null,
    Object? userRatings = null,
    Object? userRideCounts = null,
    Object? pickupLatitude = null,
    Object? pickupLongitude = null,
    Object? destinationLatitude = null,
    Object? destinationLongitude = null,
    Object? stepOverLatitude = null,
    Object? stepOverLongitude = null,
    Object? pickupAddress = null,
    Object? destinationAddress = null,
    Object? stepOverAddress = null,
    Object? distance = null,
    Object? duration = null,
    Object? fare = null,
    Object? rating = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? paymentId = null,
    Object? paymentDate = null,
    Object? rideDate = null,
    Object? rideTime = null,
    Object? rideStartDate = null,
    Object? rideEndDate = null,
    Object? entranceDetail = null,
    Object? passengerCounts = null,
    Object? seatsBooked = null,
    Object? comment = null,
    Object? isParcelDelivery = null,
    Object? parcelSize = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
  }) {
    return _then(
      _$RideDataModelImpl(
        rideType: null == rideType
            ? _value.rideType
            : rideType // ignore: cast_nullable_to_non_nullable
                  as String,
        rideStatus: null == rideStatus
            ? _value.rideStatus
            : rideStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        rideId: null == rideId
            ? _value.rideId
            : rideId // ignore: cast_nullable_to_non_nullable
                  as String,
        driverId: null == driverId
            ? _value.driverId
            : driverId // ignore: cast_nullable_to_non_nullable
                  as String,
        driverName: null == driverName
            ? _value.driverName
            : driverName // ignore: cast_nullable_to_non_nullable
                  as String,
        driverPhone: null == driverPhone
            ? _value.driverPhone
            : driverPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        driverImage: null == driverImage
            ? _value.driverImage
            : driverImage // ignore: cast_nullable_to_non_nullable
                  as String,
        driverRatings: null == driverRatings
            ? _value.driverRatings
            : driverRatings // ignore: cast_nullable_to_non_nullable
                  as String,
        driverRideCounts: null == driverRideCounts
            ? _value.driverRideCounts
            : driverRideCounts // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        usernumber: null == usernumber
            ? _value.usernumber
            : usernumber // ignore: cast_nullable_to_non_nullable
                  as String,
        userimage: null == userimage
            ? _value.userimage
            : userimage // ignore: cast_nullable_to_non_nullable
                  as String,
        userRatings: null == userRatings
            ? _value.userRatings
            : userRatings // ignore: cast_nullable_to_non_nullable
                  as String,
        userRideCounts: null == userRideCounts
            ? _value.userRideCounts
            : userRideCounts // ignore: cast_nullable_to_non_nullable
                  as String,
        pickupLatitude: null == pickupLatitude
            ? _value.pickupLatitude
            : pickupLatitude // ignore: cast_nullable_to_non_nullable
                  as double,
        pickupLongitude: null == pickupLongitude
            ? _value.pickupLongitude
            : pickupLongitude // ignore: cast_nullable_to_non_nullable
                  as double,
        destinationLatitude: null == destinationLatitude
            ? _value.destinationLatitude
            : destinationLatitude // ignore: cast_nullable_to_non_nullable
                  as double,
        destinationLongitude: null == destinationLongitude
            ? _value.destinationLongitude
            : destinationLongitude // ignore: cast_nullable_to_non_nullable
                  as double,
        stepOverLatitude: null == stepOverLatitude
            ? _value.stepOverLatitude
            : stepOverLatitude // ignore: cast_nullable_to_non_nullable
                  as double,
        stepOverLongitude: null == stepOverLongitude
            ? _value.stepOverLongitude
            : stepOverLongitude // ignore: cast_nullable_to_non_nullable
                  as double,
        pickupAddress: null == pickupAddress
            ? _value.pickupAddress
            : pickupAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationAddress: null == destinationAddress
            ? _value.destinationAddress
            : destinationAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        stepOverAddress: null == stepOverAddress
            ? _value.stepOverAddress
            : stepOverAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        fare: null == fare
            ? _value.fare
            : fare // ignore: cast_nullable_to_non_nullable
                  as double,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentDate: null == paymentDate
            ? _value.paymentDate
            : paymentDate // ignore: cast_nullable_to_non_nullable
                  as String,
        rideDate: null == rideDate
            ? _value.rideDate
            : rideDate // ignore: cast_nullable_to_non_nullable
                  as String,
        rideTime: null == rideTime
            ? _value.rideTime
            : rideTime // ignore: cast_nullable_to_non_nullable
                  as String,
        rideStartDate: null == rideStartDate
            ? _value.rideStartDate
            : rideStartDate // ignore: cast_nullable_to_non_nullable
                  as String,
        rideEndDate: null == rideEndDate
            ? _value.rideEndDate
            : rideEndDate // ignore: cast_nullable_to_non_nullable
                  as String,
        entranceDetail: null == entranceDetail
            ? _value.entranceDetail
            : entranceDetail // ignore: cast_nullable_to_non_nullable
                  as String,
        passengerCounts: null == passengerCounts
            ? _value.passengerCounts
            : passengerCounts // ignore: cast_nullable_to_non_nullable
                  as int,
        seatsBooked: null == seatsBooked
            ? _value.seatsBooked
            : seatsBooked // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
        isParcelDelivery: null == isParcelDelivery
            ? _value.isParcelDelivery
            : isParcelDelivery // ignore: cast_nullable_to_non_nullable
                  as bool,
        parcelSize: null == parcelSize
            ? _value.parcelSize
            : parcelSize // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: null == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverPhone: null == receiverPhone
            ? _value.receiverPhone
            : receiverPhone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RideDataModelImpl implements _RideDataModel {
  const _$RideDataModelImpl({
    this.rideType = "",
    this.rideStatus = "",
    this.rideId = "",
    this.driverId = "",
    this.driverName = "",
    this.driverPhone = "",
    this.driverImage = "",
    this.driverRatings = "",
    this.driverRideCounts = "",
    this.userId = "",
    this.username = "",
    this.usernumber = "",
    this.userimage = "",
    this.userRatings = "",
    this.userRideCounts = "",
    this.pickupLatitude = 0,
    this.pickupLongitude = 0,
    this.destinationLatitude = 0,
    this.destinationLongitude = 0,
    this.stepOverLatitude = 0,
    this.stepOverLongitude = 0,
    this.pickupAddress = "",
    this.destinationAddress = "",
    this.stepOverAddress = "",
    this.distance = 0,
    this.duration = 0,
    this.fare = 0,
    this.rating = 0,
    this.paymentMethod = "",
    this.paymentStatus = "",
    this.paymentId = "",
    this.paymentDate = "",
    this.rideDate = "",
    this.rideTime = "",
    this.rideStartDate = "",
    this.rideEndDate = "",
    this.entranceDetail = "",
    this.passengerCounts = 0,
    this.seatsBooked = 0,
    this.comment = "",
    this.isParcelDelivery = false,
    this.parcelSize = "",
    this.receiverName = "",
    this.receiverPhone = "",
  });

  factory _$RideDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RideDataModelImplFromJson(json);

  @override
  @JsonKey()
  final String rideType;
  @override
  @JsonKey()
  final String rideStatus;
  @override
  @JsonKey()
  final String rideId;
  // driver data
  @override
  @JsonKey()
  final String driverId;
  @override
  @JsonKey()
  final String driverName;
  @override
  @JsonKey()
  final String driverPhone;
  @override
  @JsonKey()
  final String driverImage;
  @override
  @JsonKey()
  final String driverRatings;
  @override
  @JsonKey()
  final String driverRideCounts;
  // user data
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String usernumber;
  @override
  @JsonKey()
  final String userimage;
  @override
  @JsonKey()
  final String userRatings;
  @override
  @JsonKey()
  final String userRideCounts;
  // location coordinates
  @override
  @JsonKey()
  final double pickupLatitude;
  @override
  @JsonKey()
  final double pickupLongitude;
  @override
  @JsonKey()
  final double destinationLatitude;
  @override
  @JsonKey()
  final double destinationLongitude;
  @override
  @JsonKey()
  final double stepOverLatitude;
  @override
  @JsonKey()
  final double stepOverLongitude;
  // location steps
  @override
  @JsonKey()
  final String pickupAddress;
  @override
  @JsonKey()
  final String destinationAddress;
  @override
  @JsonKey()
  final String stepOverAddress;
  // ride details
  @override
  @JsonKey()
  final double distance;
  @override
  @JsonKey()
  final double duration;
  @override
  @JsonKey()
  final double fare;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final String paymentMethod;
  @override
  @JsonKey()
  final String paymentStatus;
  @override
  @JsonKey()
  final String paymentId;
  @override
  @JsonKey()
  final String paymentDate;
  @override
  @JsonKey()
  final String rideDate;
  @override
  @JsonKey()
  final String rideTime;
  @override
  @JsonKey()
  final String rideStartDate;
  @override
  @JsonKey()
  final String rideEndDate;
  @override
  @JsonKey()
  final String entranceDetail;
  // filter passenger details
  @override
  @JsonKey()
  final int passengerCounts;
  @override
  @JsonKey()
  final int seatsBooked;
  // comments
  @override
  @JsonKey()
  final String comment;
  // 🔥 NEW: Parcel Delivery Fields
  @override
  @JsonKey()
  final bool isParcelDelivery;
  @override
  @JsonKey()
  final String parcelSize;
  @override
  @JsonKey()
  final String receiverName;
  @override
  @JsonKey()
  final String receiverPhone;

  @override
  String toString() {
    return 'RideDataModel(rideType: $rideType, rideStatus: $rideStatus, rideId: $rideId, driverId: $driverId, driverName: $driverName, driverPhone: $driverPhone, driverImage: $driverImage, driverRatings: $driverRatings, driverRideCounts: $driverRideCounts, userId: $userId, username: $username, usernumber: $usernumber, userimage: $userimage, userRatings: $userRatings, userRideCounts: $userRideCounts, pickupLatitude: $pickupLatitude, pickupLongitude: $pickupLongitude, destinationLatitude: $destinationLatitude, destinationLongitude: $destinationLongitude, stepOverLatitude: $stepOverLatitude, stepOverLongitude: $stepOverLongitude, pickupAddress: $pickupAddress, destinationAddress: $destinationAddress, stepOverAddress: $stepOverAddress, distance: $distance, duration: $duration, fare: $fare, rating: $rating, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, paymentId: $paymentId, paymentDate: $paymentDate, rideDate: $rideDate, rideTime: $rideTime, rideStartDate: $rideStartDate, rideEndDate: $rideEndDate, entranceDetail: $entranceDetail, passengerCounts: $passengerCounts, seatsBooked: $seatsBooked, comment: $comment, isParcelDelivery: $isParcelDelivery, parcelSize: $parcelSize, receiverName: $receiverName, receiverPhone: $receiverPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RideDataModelImpl &&
            (identical(other.rideType, rideType) ||
                other.rideType == rideType) &&
            (identical(other.rideStatus, rideStatus) ||
                other.rideStatus == rideStatus) &&
            (identical(other.rideId, rideId) || other.rideId == rideId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            (identical(other.driverImage, driverImage) ||
                other.driverImage == driverImage) &&
            (identical(other.driverRatings, driverRatings) ||
                other.driverRatings == driverRatings) &&
            (identical(other.driverRideCounts, driverRideCounts) ||
                other.driverRideCounts == driverRideCounts) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.usernumber, usernumber) ||
                other.usernumber == usernumber) &&
            (identical(other.userimage, userimage) ||
                other.userimage == userimage) &&
            (identical(other.userRatings, userRatings) ||
                other.userRatings == userRatings) &&
            (identical(other.userRideCounts, userRideCounts) ||
                other.userRideCounts == userRideCounts) &&
            (identical(other.pickupLatitude, pickupLatitude) ||
                other.pickupLatitude == pickupLatitude) &&
            (identical(other.pickupLongitude, pickupLongitude) ||
                other.pickupLongitude == pickupLongitude) &&
            (identical(other.destinationLatitude, destinationLatitude) ||
                other.destinationLatitude == destinationLatitude) &&
            (identical(other.destinationLongitude, destinationLongitude) ||
                other.destinationLongitude == destinationLongitude) &&
            (identical(other.stepOverLatitude, stepOverLatitude) ||
                other.stepOverLatitude == stepOverLatitude) &&
            (identical(other.stepOverLongitude, stepOverLongitude) ||
                other.stepOverLongitude == stepOverLongitude) &&
            (identical(other.pickupAddress, pickupAddress) ||
                other.pickupAddress == pickupAddress) &&
            (identical(other.destinationAddress, destinationAddress) ||
                other.destinationAddress == destinationAddress) &&
            (identical(other.stepOverAddress, stepOverAddress) ||
                other.stepOverAddress == stepOverAddress) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.fare, fare) || other.fare == fare) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.rideDate, rideDate) ||
                other.rideDate == rideDate) &&
            (identical(other.rideTime, rideTime) ||
                other.rideTime == rideTime) &&
            (identical(other.rideStartDate, rideStartDate) ||
                other.rideStartDate == rideStartDate) &&
            (identical(other.rideEndDate, rideEndDate) ||
                other.rideEndDate == rideEndDate) &&
            (identical(other.entranceDetail, entranceDetail) ||
                other.entranceDetail == entranceDetail) &&
            (identical(other.passengerCounts, passengerCounts) ||
                other.passengerCounts == passengerCounts) &&
            (identical(other.seatsBooked, seatsBooked) ||
                other.seatsBooked == seatsBooked) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isParcelDelivery, isParcelDelivery) ||
                other.isParcelDelivery == isParcelDelivery) &&
            (identical(other.parcelSize, parcelSize) ||
                other.parcelSize == parcelSize) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPhone, receiverPhone) ||
                other.receiverPhone == receiverPhone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    rideType,
    rideStatus,
    rideId,
    driverId,
    driverName,
    driverPhone,
    driverImage,
    driverRatings,
    driverRideCounts,
    userId,
    username,
    usernumber,
    userimage,
    userRatings,
    userRideCounts,
    pickupLatitude,
    pickupLongitude,
    destinationLatitude,
    destinationLongitude,
    stepOverLatitude,
    stepOverLongitude,
    pickupAddress,
    destinationAddress,
    stepOverAddress,
    distance,
    duration,
    fare,
    rating,
    paymentMethod,
    paymentStatus,
    paymentId,
    paymentDate,
    rideDate,
    rideTime,
    rideStartDate,
    rideEndDate,
    entranceDetail,
    passengerCounts,
    seatsBooked,
    comment,
    isParcelDelivery,
    parcelSize,
    receiverName,
    receiverPhone,
  ]);

  /// Create a copy of RideDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RideDataModelImplCopyWith<_$RideDataModelImpl> get copyWith =>
      __$$RideDataModelImplCopyWithImpl<_$RideDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RideDataModelImplToJson(this);
  }
}

abstract class _RideDataModel implements RideDataModel {
  const factory _RideDataModel({
    final String rideType,
    final String rideStatus,
    final String rideId,
    final String driverId,
    final String driverName,
    final String driverPhone,
    final String driverImage,
    final String driverRatings,
    final String driverRideCounts,
    final String userId,
    final String username,
    final String usernumber,
    final String userimage,
    final String userRatings,
    final String userRideCounts,
    final double pickupLatitude,
    final double pickupLongitude,
    final double destinationLatitude,
    final double destinationLongitude,
    final double stepOverLatitude,
    final double stepOverLongitude,
    final String pickupAddress,
    final String destinationAddress,
    final String stepOverAddress,
    final double distance,
    final double duration,
    final double fare,
    final double rating,
    final String paymentMethod,
    final String paymentStatus,
    final String paymentId,
    final String paymentDate,
    final String rideDate,
    final String rideTime,
    final String rideStartDate,
    final String rideEndDate,
    final String entranceDetail,
    final int passengerCounts,
    final int seatsBooked,
    final String comment,
    final bool isParcelDelivery,
    final String parcelSize,
    final String receiverName,
    final String receiverPhone,
  }) = _$RideDataModelImpl;

  factory _RideDataModel.fromJson(Map<String, dynamic> json) =
      _$RideDataModelImpl.fromJson;

  @override
  String get rideType;
  @override
  String get rideStatus;
  @override
  String get rideId; // driver data
  @override
  String get driverId;
  @override
  String get driverName;
  @override
  String get driverPhone;
  @override
  String get driverImage;
  @override
  String get driverRatings;
  @override
  String get driverRideCounts; // user data
  @override
  String get userId;
  @override
  String get username;
  @override
  String get usernumber;
  @override
  String get userimage;
  @override
  String get userRatings;
  @override
  String get userRideCounts; // location coordinates
  @override
  double get pickupLatitude;
  @override
  double get pickupLongitude;
  @override
  double get destinationLatitude;
  @override
  double get destinationLongitude;
  @override
  double get stepOverLatitude;
  @override
  double get stepOverLongitude; // location steps
  @override
  String get pickupAddress;
  @override
  String get destinationAddress;
  @override
  String get stepOverAddress; // ride details
  @override
  double get distance;
  @override
  double get duration;
  @override
  double get fare;
  @override
  double get rating;
  @override
  String get paymentMethod;
  @override
  String get paymentStatus;
  @override
  String get paymentId;
  @override
  String get paymentDate;
  @override
  String get rideDate;
  @override
  String get rideTime;
  @override
  String get rideStartDate;
  @override
  String get rideEndDate;
  @override
  String get entranceDetail; // filter passenger details
  @override
  int get passengerCounts;
  @override
  int get seatsBooked; // comments
  @override
  String get comment; // 🔥 NEW: Parcel Delivery Fields
  @override
  bool get isParcelDelivery;
  @override
  String get parcelSize;
  @override
  String get receiverName;
  @override
  String get receiverPhone;

  /// Create a copy of RideDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RideDataModelImplCopyWith<_$RideDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
