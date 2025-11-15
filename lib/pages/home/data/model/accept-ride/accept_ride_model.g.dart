// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_ride_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcceptRideModelImpl _$$AcceptRideModelImplFromJson(
  Map<String, dynamic> json,
) => _$AcceptRideModelImpl(
  driverData: json['driverData'] == null
      ? const AuthModel()
      : AuthModel.fromJson(json['driverData'] as Map<String, dynamic>),
  distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
  duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
  fare: (json['fare'] as num?)?.toDouble() ?? 0.0,
  isAccepted: json['isAccepted'] as bool? ?? false,
  isRejected: json['isRejected'] as bool? ?? false,
  rideId: json['rideId'] as String? ?? "",
);

Map<String, dynamic> _$$AcceptRideModelImplToJson(
  _$AcceptRideModelImpl instance,
) => <String, dynamic>{
  'driverData': instance.driverData,
  'distance': instance.distance,
  'duration': instance.duration,
  'fare': instance.fare,
  'isAccepted': instance.isAccepted,
  'isRejected': instance.isRejected,
  'rideId': instance.rideId,
};
