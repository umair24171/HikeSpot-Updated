// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accept_ride_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AcceptRideModel _$AcceptRideModelFromJson(Map<String, dynamic> json) {
  return _AcceptRideModel.fromJson(json);
}

/// @nodoc
mixin _$AcceptRideModel {
  AuthModel get driverData => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  double get fare => throw _privateConstructorUsedError;
  bool get isAccepted => throw _privateConstructorUsedError;
  bool get isRejected => throw _privateConstructorUsedError;
  String get rideId => throw _privateConstructorUsedError;

  /// Serializes this AcceptRideModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcceptRideModelCopyWith<AcceptRideModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptRideModelCopyWith<$Res> {
  factory $AcceptRideModelCopyWith(
    AcceptRideModel value,
    $Res Function(AcceptRideModel) then,
  ) = _$AcceptRideModelCopyWithImpl<$Res, AcceptRideModel>;
  @useResult
  $Res call({
    AuthModel driverData,
    double distance,
    double duration,
    double fare,
    bool isAccepted,
    bool isRejected,
    String rideId,
  });

  $AuthModelCopyWith<$Res> get driverData;
}

/// @nodoc
class _$AcceptRideModelCopyWithImpl<$Res, $Val extends AcceptRideModel>
    implements $AcceptRideModelCopyWith<$Res> {
  _$AcceptRideModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverData = null,
    Object? distance = null,
    Object? duration = null,
    Object? fare = null,
    Object? isAccepted = null,
    Object? isRejected = null,
    Object? rideId = null,
  }) {
    return _then(
      _value.copyWith(
            driverData: null == driverData
                ? _value.driverData
                : driverData // ignore: cast_nullable_to_non_nullable
                      as AuthModel,
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
            isAccepted: null == isAccepted
                ? _value.isAccepted
                : isAccepted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRejected: null == isRejected
                ? _value.isRejected
                : isRejected // ignore: cast_nullable_to_non_nullable
                      as bool,
            rideId: null == rideId
                ? _value.rideId
                : rideId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthModelCopyWith<$Res> get driverData {
    return $AuthModelCopyWith<$Res>(_value.driverData, (value) {
      return _then(_value.copyWith(driverData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AcceptRideModelImplCopyWith<$Res>
    implements $AcceptRideModelCopyWith<$Res> {
  factory _$$AcceptRideModelImplCopyWith(
    _$AcceptRideModelImpl value,
    $Res Function(_$AcceptRideModelImpl) then,
  ) = __$$AcceptRideModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthModel driverData,
    double distance,
    double duration,
    double fare,
    bool isAccepted,
    bool isRejected,
    String rideId,
  });

  @override
  $AuthModelCopyWith<$Res> get driverData;
}

/// @nodoc
class __$$AcceptRideModelImplCopyWithImpl<$Res>
    extends _$AcceptRideModelCopyWithImpl<$Res, _$AcceptRideModelImpl>
    implements _$$AcceptRideModelImplCopyWith<$Res> {
  __$$AcceptRideModelImplCopyWithImpl(
    _$AcceptRideModelImpl _value,
    $Res Function(_$AcceptRideModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverData = null,
    Object? distance = null,
    Object? duration = null,
    Object? fare = null,
    Object? isAccepted = null,
    Object? isRejected = null,
    Object? rideId = null,
  }) {
    return _then(
      _$AcceptRideModelImpl(
        driverData: null == driverData
            ? _value.driverData
            : driverData // ignore: cast_nullable_to_non_nullable
                  as AuthModel,
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
        isAccepted: null == isAccepted
            ? _value.isAccepted
            : isAccepted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRejected: null == isRejected
            ? _value.isRejected
            : isRejected // ignore: cast_nullable_to_non_nullable
                  as bool,
        rideId: null == rideId
            ? _value.rideId
            : rideId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AcceptRideModelImpl implements _AcceptRideModel {
  _$AcceptRideModelImpl({
    this.driverData = const AuthModel(),
    this.distance = 0.0,
    this.duration = 0.0,
    this.fare = 0.0,
    this.isAccepted = false,
    this.isRejected = false,
    this.rideId = "",
  });

  factory _$AcceptRideModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcceptRideModelImplFromJson(json);

  @override
  @JsonKey()
  final AuthModel driverData;
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
  final bool isAccepted;
  @override
  @JsonKey()
  final bool isRejected;
  @override
  @JsonKey()
  final String rideId;

  @override
  String toString() {
    return 'AcceptRideModel(driverData: $driverData, distance: $distance, duration: $duration, fare: $fare, isAccepted: $isAccepted, isRejected: $isRejected, rideId: $rideId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptRideModelImpl &&
            (identical(other.driverData, driverData) ||
                other.driverData == driverData) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.fare, fare) || other.fare == fare) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            (identical(other.isRejected, isRejected) ||
                other.isRejected == isRejected) &&
            (identical(other.rideId, rideId) || other.rideId == rideId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    driverData,
    distance,
    duration,
    fare,
    isAccepted,
    isRejected,
    rideId,
  );

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptRideModelImplCopyWith<_$AcceptRideModelImpl> get copyWith =>
      __$$AcceptRideModelImplCopyWithImpl<_$AcceptRideModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AcceptRideModelImplToJson(this);
  }
}

abstract class _AcceptRideModel implements AcceptRideModel {
  factory _AcceptRideModel({
    final AuthModel driverData,
    final double distance,
    final double duration,
    final double fare,
    final bool isAccepted,
    final bool isRejected,
    final String rideId,
  }) = _$AcceptRideModelImpl;

  factory _AcceptRideModel.fromJson(Map<String, dynamic> json) =
      _$AcceptRideModelImpl.fromJson;

  @override
  AuthModel get driverData;
  @override
  double get distance;
  @override
  double get duration;
  @override
  double get fare;
  @override
  bool get isAccepted;
  @override
  bool get isRejected;
  @override
  String get rideId;

  /// Create a copy of AcceptRideModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptRideModelImplCopyWith<_$AcceptRideModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
