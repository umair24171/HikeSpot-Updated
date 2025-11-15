import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
part 'accept_ride_model.freezed.dart';
part 'accept_ride_model.g.dart';

@freezed
class AcceptRideModel with _$AcceptRideModel {
  factory AcceptRideModel({
    @Default(AuthModel()) AuthModel driverData,
    @Default(0.0) double distance,
    @Default(0.0) double duration,
    @Default(0.0) double fare,
    @Default(false) bool isAccepted,
    @Default(false) bool isRejected,
    @Default("") String rideId,
  }) = _AcceptRideModel;

  factory AcceptRideModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptRideModelFromJson(json);
}
