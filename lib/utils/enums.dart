// ignore_for_file: constant_identifier_names

enum NewUser {
  newUser,
  oldUser,
}

enum ContainerType { schedule, activities }

enum AppState { user, captain }

enum UploadType {
  idCardFront,
  idCardBack,
  profile,
  licence,
  vehicleDocF,
  vehicleDocB
}

enum ChatType { chatSupport, driverChat }

enum CaptainService {
  CARRIDES,
  CARBUSSINESSRIDES,
  CARRIDESWITHAC,
  CITYTOCITYRIDES,
  BIKERIDES,
  SUVRIDES,
  HEAVYDUITYTRACKRIDES,
  TUKTUKRIDES,
  UTILITYRIDES,
  DOUBLECABRIDES,
  TAXIRIDES,
}

enum RideStatus {
  Pending,
  Accepted,
  Started,
  Completed,
  Cancelled,
  Rejected,
  Waiting,
  Arrived,
  OnTheWay,
  Scheduled
}

enum PaymentStatus{
  Pending,
  Paid,
  Failed,
  Refunded,
}

enum MapPageType{
  CreatingRide,
  RideDetails,
}