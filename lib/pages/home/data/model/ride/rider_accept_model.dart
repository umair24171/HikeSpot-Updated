class RiderAcceptModel{
  String customerId;
  String driverId;
  String rideId;
  bool confirmRequest;
  double driverFare;
  String customerName;
  String customerImage;
  String customerNumber;
  double customerFare;
  String destinationAddress;
  double destinationLatitude;
  double destinationLongitude;
  String pickupAddress;
  double pickupLatitude;
  double pickupLongitude;
  String stepOverAddress;
  double stepOverLatitude;
  double stepOverLongitude;

  RiderAcceptModel({
    required this.customerId,
    required this.driverId,
    required this.rideId,
    required this.confirmRequest,
    required this.driverFare,
    required this.customerName,
    required this.customerImage,
    required this.customerNumber,
    required this.customerFare,
    required this.destinationAddress,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.stepOverAddress,
    required this.stepOverLatitude,
    required this.stepOverLongitude,
  });

  // Convert AcceptRide instance to a map
  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      "driverId": driverId,
      "rideId": rideId,
      "confirmRequest": confirmRequest,
      "driverFare": driverFare,
      "customerName": customerName,
      "customerImage": customerImage,
      "customerNumber": customerNumber,
      "customerFare": customerFare,
      "destinationAddress": destinationAddress,
      "destinationLatitude": destinationLatitude,
      "destinationLongitude": destinationLongitude,
      "pickupAddress": pickupAddress,
      "pickupLatitude": pickupLatitude,
      "pickupLongitude": pickupLongitude,
      "stepOverAddress": stepOverAddress,
      "stepOverLatitude": stepOverLatitude,
      "stepOverLongitude": stepOverLongitude,
    };
  }

  // Create an AcceptRide instance from a map
  factory RiderAcceptModel.fromMap(Map<String, dynamic> map) {
    return RiderAcceptModel(
      customerId: map["customerId"] ?? '',
      driverId: map["driverId"] ?? '',
      rideId: map["rideId"] ?? '',
      confirmRequest: map["confirmRequest"] ?? false,
      driverFare: map["driverFare"] ?? 0.0,
      customerName: map["customerName"] ?? '',
      customerImage: map["customerImage"] ?? '',
      customerNumber: map["customerNumber"] ?? '',
      customerFare: map["customerFare"] ?? 0.0,
      destinationAddress: map["destinationAddress"] ?? '',
      destinationLatitude: map["destinationLatitude"] ?? 0.0,
      destinationLongitude: map["destinationLongitude"] ?? 0.0,
      pickupAddress: map["pickupAddress"] ?? '',
      pickupLatitude: map["pickupLatitude"] ?? 0.0,
      pickupLongitude: map["pickupLongitude"] ?? 0.0,
      stepOverAddress: map["stepOverAddress"] ?? '',
      stepOverLatitude: map["stepOverLatitude"] ?? 0.0,
      stepOverLongitude: map["stepOverLongitude"] ?? 0.0,
    );
  }
}
