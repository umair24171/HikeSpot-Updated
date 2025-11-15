import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hikespot/data/models/card-model/card_model.dart';
import 'package:hikespot/data/models/driver-model/driver_model.dart';
part "auth_model.g.dart";
part 'auth_model.freezed.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    // user data
    @Default("") String uid,
    @Default("") String phoneNumber,
    @Default("") String email,
    @Default("") String imageUrl,
    @Default("") String username,
    @Default("") String firstname,
    @Default("") String lastname,
    @Default("") String idCardFront,
    @Default("") String idCardBack,
    @Default([]) List scheduleRides,
    @Default(true) bool notificationEnabled,
    @Default("") String referCode,
    @Default([]) List<String> referedUsers,
    @Default(0) double balance,
     // data
    @Default("") String createdAt,
    @Default("") String pushToken,
    @Default(0.0) double ratings,
    @Default(0) int totalRides,
    // driver data
    @Default(DriverModel()) DriverModel driverModel,
    @Default(false) bool isRequestedDriver,
    // card details
    @Default([]) List<CardModel> cardModel,
    @Default("") String appStatus,
    // location
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default("") String address,
    @Default(false) bool isOnline,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
