import 'package:freezed_annotation/freezed_annotation.dart';
part 'driver_model.g.dart';
part 'driver_model.freezed.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    @Default("") String captainNumber,
    @Default("") String captainFirstName,
    @Default("") String captainLastName,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default("") String address,
    @Default("") String carBrand,
    @Default("") String carService,
    @Default("") String carModel,
    @Default("") String carNumberPlate,
    @Default("") String carRegistrationFront,
    @Default("") String carRegistrationBack,
    @Default("") String drivingLicence,
    @Default(false) bool isVerified,
    @Default(false) bool isOnDuty,
    @Default(0) int totalRides,
    @Default(0.0) double ratings,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) => _$DriverModelFromJson(json);
}
