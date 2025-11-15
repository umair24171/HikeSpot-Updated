// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      captainNumber: json['captainNumber'] as String? ?? "",
      captainFirstName: json['captainFirstName'] as String? ?? "",
      captainLastName: json['captainLastName'] as String? ?? "",
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      address: json['address'] as String? ?? "",
      carBrand: json['carBrand'] as String? ?? "",
      carService: json['carService'] as String? ?? "",
      carModel: json['carModel'] as String? ?? "",
      carNumberPlate: json['carNumberPlate'] as String? ?? "",
      carRegistrationFront: json['carRegistrationFront'] as String? ?? "",
      carRegistrationBack: json['carRegistrationBack'] as String? ?? "",
      drivingLicence: json['drivingLicence'] as String? ?? "",
      isVerified: json['isVerified'] as bool? ?? false,
      isOnDuty: json['isOnDuty'] as bool? ?? false,
      totalRides: (json['totalRides'] as num?)?.toInt() ?? 0,
      ratings: (json['ratings'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'captainNumber': instance.captainNumber,
      'captainFirstName': instance.captainFirstName,
      'captainLastName': instance.captainLastName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'carBrand': instance.carBrand,
      'carService': instance.carService,
      'carModel': instance.carModel,
      'carNumberPlate': instance.carNumberPlate,
      'carRegistrationFront': instance.carRegistrationFront,
      'carRegistrationBack': instance.carRegistrationBack,
      'drivingLicence': instance.drivingLicence,
      'isVerified': instance.isVerified,
      'isOnDuty': instance.isOnDuty,
      'totalRides': instance.totalRides,
      'ratings': instance.ratings,
    };
