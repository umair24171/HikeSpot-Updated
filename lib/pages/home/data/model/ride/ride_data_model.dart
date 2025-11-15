import 'package:freezed_annotation/freezed_annotation.dart';
part 'ride_data_model.freezed.dart';
part 'ride_data_model.g.dart';

@freezed
class RideDataModel with _$RideDataModel {
  const factory RideDataModel({
    @Default("") String rideType,
    @Default("") String rideStatus,
    @Default("") String rideId,
    
    // driver data 
    @Default("") String driverId,
    @Default("") String driverName,
    @Default("") String driverPhone,
    @Default("") String driverImage,
    @Default("") String driverRatings,
    @Default("") String driverRideCounts,
    
    // user data 
    @Default("") String userId,
    @Default("") String username,
    @Default("") String usernumber,
    @Default("") String userimage,
    @Default("") String userRatings,
    @Default("") String userRideCounts,
    
    // location coordinates
    @Default(0) double pickupLatitude,
    @Default(0) double pickupLongitude,
    @Default(0) double destinationLatitude,
    @Default(0) double destinationLongitude,
    @Default(0) double stepOverLatitude,
    @Default(0) double stepOverLongitude,
    
    // location steps
    @Default("") String pickupAddress,
    @Default("") String destinationAddress,
    @Default("") String stepOverAddress,
    
    // ride details
    @Default(0) double distance,
    @Default(0) double duration,
    @Default(0) double fare,
    @Default(0) double rating,
    @Default("") String paymentMethod,
    @Default("") String paymentStatus,
    @Default("") String paymentId,
    @Default("") String paymentDate,
    @Default("") String rideDate,
    @Default("") String rideTime,
    @Default("") String rideStartDate,
    @Default("") String rideEndDate,
    @Default("") String entranceDetail,
    
    // filter passenger details
    @Default(0) int passengerCounts,
    @Default(0) int seatsBooked,
    
    // comments
    @Default("") String comment,
    
    // 🔥 NEW: Parcel Delivery Fields
    @Default(false) bool isParcelDelivery,
    @Default("") String parcelSize,
    @Default("") String receiverName,
    @Default("") String receiverPhone,
  }) = _RideDataModel;

  factory RideDataModel.fromJson(Map<String, dynamic> json) =>
      _$RideDataModelFromJson(json);
}