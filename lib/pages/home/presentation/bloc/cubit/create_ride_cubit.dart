import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/helper/shared_prefs_helper.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/domain/usecase/create_ride_usecase.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/driver_rides_requests_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:uuid/uuid.dart';
part '../state/create_ride_state.dart';

class CreateRideCubit extends Cubit<CreateRideState> {
  final CreateRideUsecase _createRideUsecase;
  CreateRideCubit(this._createRideUsecase) : super(CreateRideInitial());

  StreamSubscription? ridesSubscription;
  List<AcceptRideModel> driverAcceptedData = [];
  
  AuthModel selectedDriver = const AuthModel();
  TextEditingController commentController = TextEditingController();
  TextEditingController fareController = TextEditingController();
  TextEditingController enteranceController = TextEditingController();
  TextEditingController passengerController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController destinationDisplayController = TextEditingController();
  
  // 🔥 NEW: Parcel delivery fields
  bool isParcelDelivery = false;
  TextEditingController parcelSizeController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();

  DateTime? rideDate;
  DateTime? rideTime;
  String newRideId="";
  RideDataModel?  rideDataMode;
  
  // destination details
  String destinationAddress = "";
  double destinationLatitude = 0.0;
  double destinationLongitude = 0.0;
  
  String stepOverAddress = "";
  double stepOverLatitude = 0.0;
  double stepOverLongitude = 0.0;
  
  String? pickupAddress;
  double? pickupLatitude;
  double? pickupLongitude;

  int passengerCounts = 0;
  int carSeatsBook = 0;
  RideStatus rideStatus = RideStatus.Pending;
  CaptainService selectedService = CaptainService.CARRIDES;

  static const double RATE_PER_KM = 1.35;

  // 🔥 NEW: Toggle between Hitchhiking and Parcel Delivery
  void setRideType(bool isParcel) {
    emit(CreateRideLoading());
    isParcelDelivery = isParcel;
    
    // Clear parcel fields if switching to hitchhiking
    if (!isParcel) {
      parcelSizeController.clear();
      receiverNameController.clear();
      receiverPhoneController.clear();
    }
    // Clear passenger fields if switching to parcel
    else {
      passengerController.clear();
      seatsController.clear();
      passengerCounts = 0;
      carSeatsBook = 0;
    }
    
    emit(CreateRideSuccess());
  }

  void calculateAndSetFare(double distanceInKm) {
    print("🔥 calculateAndSetFare called with distance: $distanceInKm km");
    
    if (distanceInKm <= 0) {
      print("❌ Invalid distance: $distanceInKm, cannot calculate fare");
      return;
    }
    
    double calculatedFare = distanceInKm * RATE_PER_KM;
    
    print("🔥 Calculation: $distanceInKm km × R$RATE_PER_KM = R${calculatedFare.toStringAsFixed(2)}");
    
    int roundedFare = calculatedFare.round();
    
    print("🔥 Rounded fare: R$roundedFare");
    
    fareController.text = roundedFare.toString();
    
    print("✅ Fare set in controller: ${fareController.text}");
    
    emit(CreateRideSuccess());
    
    print("✅ State emitted - CreateRideSuccess");
  }

  void getDestinationDetails(double lat, double long, String address) {
    emit(CreateRideLoading());
    destinationAddress = address;
    destinationLatitude = lat;
    destinationLongitude = long;
    destinationDisplayController.text = address;
    emit(CreateRideSuccess());
  }

  getRideDate(DateTime date) {
    emit(CreateRideLoading());
    rideDate = date;
    emit(CreateRideSuccess());
  }

  changeRideStatus(RideStatus status) {
    emit(CreateRideLoading());
    rideStatus = status;
    emit(CreateRideSuccess());
  }

  getRideTime(TimeOfDay time) {
    emit(CreateRideLoading());
    
    DateTime dateToUse = rideDate ?? DateTime.now();
    
    rideTime = DateTime(
      dateToUse.year,
      dateToUse.month,
      dateToUse.day,
      time.hour,
      time.minute,
    );
    
    if (rideDate == null) {
      rideDate = DateTime.now();
    }
    
    emit(CreateRideSuccess());
  }

  changeCarService(CaptainService service) {
    emit(CreateRideLoading());
    selectedService = service;
    emit(CreateRideSuccess());
  }

  increasePassengers() {
    emit(CreateRideLoading());
    passengerCounts++;
    passengerController.text = passengerCounts.toString();
    emit(CreateRideSuccess());
  }

  decreasePassengers() {
    if(passengerCounts>0){
      emit(CreateRideLoading());
      passengerCounts--;
      passengerController.text = passengerCounts.toString();
      emit(CreateRideSuccess());
    }
  }

  increaseSeatsBooked() {
    emit(CreateRideLoading());
    carSeatsBook++;
    seatsController.text = carSeatsBook.toString();
    emit(CreateRideSuccess());
  }

  decreaseSeatsBooked() {
    if(carSeatsBook>0){
      emit(CreateRideLoading());
      carSeatsBook--;
      seatsController.text = carSeatsBook.toString();
      emit(CreateRideSuccess());
    }
  }

  getStepOverDetails(double lat, double long, String address) {
    emit(CreateRideLoading());
    stepOverAddress = address;
    stepOverLatitude = lat;
    stepOverLongitude = long;
    emit(CreateRideSuccess());
  }

  /// create the ride
  Future<Either<String, RideDataModel>> createRide(BuildContext context) async {
    RideDataModel rideData = RideDataModel(
      // user data
      userId: Di().sl<AuthCubit>().authData.uid,
      userimage: Di().sl<AuthCubit>().authData.imageUrl,
      username: Di().sl<AuthCubit>().authData.username,
      usernumber: Di().sl<AuthCubit>().authData.phoneNumber,
      userRatings: Di().sl<AuthCubit>().authData.ratings.toString(),
      userRideCounts: Di().sl<AuthCubit>().authData.totalRides.toString(),
      comment: commentController.text,
      distance: 0,
      driverId: rideStatus == RideStatus.Pending ? "" : selectedDriver.uid,
      driverImage:
          rideStatus == RideStatus.Pending ? "" : selectedDriver.imageUrl,
      driverName: rideStatus == RideStatus.Pending
          ? ""
          : selectedDriver.driverModel.captainFirstName,
      driverPhone: rideStatus == RideStatus.Pending
          ? ""
          : selectedDriver.driverModel.captainNumber,
      driverRatings: rideStatus == RideStatus.Pending
          ? ""
          : selectedDriver.driverModel.totalRides.toString(),
      driverRideCounts: rideStatus == RideStatus.Pending
          ? ""
          : selectedDriver.driverModel.totalRides.toString(),
      duration: 0,
      entranceDetail: enteranceController.text,
      fare: fareController.text.isNotEmpty
          ? double.parse(fareController.text)
          : 0,
      passengerCounts: passengerCounts,
      paymentDate: "",
      paymentId: "",
      paymentMethod: "",
      paymentStatus: PaymentStatus.Pending.name,
      rating: 0,
      rideDate: rideDate != null ? rideDate!.toIso8601String() : DateTime.now().toIso8601String(),
      rideEndDate: "",
      rideId: const Uuid().v4(),
      rideStartDate: DateTime.now().toIso8601String(),
      rideStatus: rideStatus.name,
      rideTime: rideTime != null
          ? formatedTime(rideTime!)
          : formatedTime(DateTime.now()),
      rideType: selectedService.name,
      seatsBooked: carSeatsBook,
      destinationAddress: destinationAddress,
      destinationLatitude: destinationLatitude,
      destinationLongitude: destinationLongitude,
      pickupAddress: pickupAddress ??
          Di().sl<GoogleMapCubit>().getAddressFromPlacemark(),
      pickupLatitude: pickupLatitude ??
          Di().sl<GoogleMapCubit>().currentLocation?.latitude ??
          0.0,
      pickupLongitude: pickupLongitude ??
          Di().sl<GoogleMapCubit>().currentLocation?.longitude ??
          0.0,
      stepOverAddress: stepOverAddress,
      stepOverLatitude: stepOverLatitude,
      stepOverLongitude: stepOverLongitude,
      
      // 🔥 NEW: Parcel delivery fields
      isParcelDelivery: isParcelDelivery,
      parcelSize: isParcelDelivery ? parcelSizeController.text : "",
      receiverName: isParcelDelivery ? receiverNameController.text : "",
      receiverPhone: isParcelDelivery ? receiverPhoneController.text : "",
    );
    
    emit(CreateRideLoading());
    
    if (rideData.fare == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the fare"))
      );
      emit(CreateRideFailure());
      return const Left("Fare Error");
    }
    
    if (rideData.destinationAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the destination detail"))
      );
      emit(CreateRideFailure());
      return const Left("Destination Error");
    }
    
    final result = await _createRideUsecase.execute(context, rideData);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l))
        );
        emit(CreateRideFailure());
      },
      (r) {
        rideDataMode = rideData;
        newRideId = rideData.rideId; 
        Di().sl<DriverRidesRequestsCubit>().buildCircles(AppColors.redColor);
        getDriversInEntrance(newRideId);
        emit(CreateRideSuccess());
        log("Ride created, fetching drivers in entrance...");
        emit(CreateRideSuccess());
      },
    );
    
    return result;
  }

  getDriversInEntrance(String id) {
    emit(CreateRideLoading());
    ridesSubscription = AppConstants.firestore
        .collection(AppConstants.ridesKey)
        .doc(id)
        .collection(AppConstants.ridesRequest)
        .snapshots()
        .listen((event) {
      debugPrint(event.docs.length.toString());
      driverAcceptedData =
          event.docs.map((e) => AcceptRideModel.fromJson(e.data())).toList();
      emit(CreateRideSuccess());
    });
  }

  bool isSearchingFromLocation = false;
  bool isSearchingToLocation = false;
  bool isSearchingStepOverLocation = false;

  getAddressAccording(double lat, double long, String address) {
    emit(CreateRideLoading());
    if (isSearchingFromLocation) {
      emit(CreateRideLoading());
      pickupAddress = address;
      pickupLatitude = lat;
      pickupLongitude = long;
      log("Pickup Address: $address");
      emit(CreateRideSuccess());
    } else if (isSearchingToLocation) {
      log("Destination Address: $address");
      getDestinationDetails(lat, long, address);
    } else if (isSearchingStepOverLocation) {
      log("Step Over Address: $address");
      getStepOverDetails(lat, long, address);
    }
  }

  setSearchingLocation(
      {bool isFrom = false, bool isTo = false, bool isStepOver = false}) {
    emit(CreateRideLoading());
    isSearchingFromLocation = isFrom;
    isSearchingToLocation = isTo;
    isSearchingStepOverLocation = isStepOver;
    emit(CreateRideSuccess());
  }

  String formatedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String formatedTime(DateTime date) {
    return "${date.hour}:${date.minute}";
  }

  Future<void> acceptRide(AcceptRideModel model) async {
    emit(CreateRideLoading());
    await AppConstants.firestore
        .collection(AppConstants.ridesKey)
        .doc(model.rideId)
        .set({
      "rideStatus": RideStatus.Accepted.name,
      "driverId": model.driverData.uid,
      "driverImage": model.driverData.imageUrl,
      "driverName": model.driverData.phoneNumber,
      "driverPhone": model.driverData.phoneNumber,
      "driverRatings": model.driverData.totalRides,
      "driverRideCounts": model.driverData.totalRides,
    });
    await AppConstants.firestore
        .collection(AppConstants.ridesKey)
        .doc(model.rideId)
        .collection(AppConstants.ridesRequest)
        .doc(model.driverData.uid)
        .delete();
    emit(CreateRideSuccess());
  }

  StreamSubscription? ridesStreamSubscription;
  List<AcceptRideModel> ridesRequestsList = [];
  getRidesRequests() async {
    String rideId =
        await SharedPrefsHelper.getData(key: AppConstants.ridesKey) ?? "";
    AppConstants.firestore
        .collection(AppConstants.ridesKey)
        .doc(rideId)
        .collection(AppConstants.ridesRequest)
        .snapshots()
        .listen(
      (event) {
        emit(CreateRideLoading());
        ridesRequestsList = event.docs
            .map(
              (e) => AcceptRideModel.fromJson(e.data()),
            )
            .toList();
        emit(CreateRideSuccess());
      },
    );
  }
}