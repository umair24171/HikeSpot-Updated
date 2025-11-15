// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthModelImpl _$$AuthModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthModelImpl(
      uid: json['uid'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      email: json['email'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      username: json['username'] as String? ?? "",
      firstname: json['firstname'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      idCardFront: json['idCardFront'] as String? ?? "",
      idCardBack: json['idCardBack'] as String? ?? "",
      scheduleRides: json['scheduleRides'] as List<dynamic>? ?? const [],
      notificationEnabled: json['notificationEnabled'] as bool? ?? true,
      referCode: json['referCode'] as String? ?? "",
      referedUsers:
          (json['referedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      createdAt: json['createdAt'] as String? ?? "",
      pushToken: json['pushToken'] as String? ?? "",
      ratings: (json['ratings'] as num?)?.toDouble() ?? 0.0,
      totalRides: (json['totalRides'] as num?)?.toInt() ?? 0,
      driverModel: json['driverModel'] == null
          ? const DriverModel()
          : DriverModel.fromJson(json['driverModel'] as Map<String, dynamic>),
      isRequestedDriver: json['isRequestedDriver'] as bool? ?? false,
      cardModel:
          (json['cardModel'] as List<dynamic>?)
              ?.map((e) => CardModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      appStatus: json['appStatus'] as String? ?? "",
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      address: json['address'] as String? ?? "",
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthModelImplToJson(_$AuthModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'idCardFront': instance.idCardFront,
      'idCardBack': instance.idCardBack,
      'scheduleRides': instance.scheduleRides,
      'notificationEnabled': instance.notificationEnabled,
      'referCode': instance.referCode,
      'referedUsers': instance.referedUsers,
      'balance': instance.balance,
      'createdAt': instance.createdAt,
      'pushToken': instance.pushToken,
      'ratings': instance.ratings,
      'totalRides': instance.totalRides,
      'driverModel': instance.driverModel,
      'isRequestedDriver': instance.isRequestedDriver,
      'cardModel': instance.cardModel,
      'appStatus': instance.appStatus,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'isOnline': instance.isOnline,
    };
