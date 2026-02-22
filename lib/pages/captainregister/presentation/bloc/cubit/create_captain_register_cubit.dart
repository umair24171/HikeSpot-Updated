import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:email_otp/email_otp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/driver-model/driver_model.dart';
import 'package:hikespot/helper/firebase_storage_helper.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/captain_stepper_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/pages/login/domain/usecase/login_create_usecase.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import '../../../../../helper/loading_dialoge_helper.dart';
import '../../../../../helper/warning_helper.dart';
import '../../../../../routes/routes_imports.gr.dart';
part '../state/create_captain_register_state.dart';

class CreateCaptainRegisterCubit extends Cubit<CreateCaptainRegisterState> {
  final LoginCreateUseCase _loginCreateUseCase;
  CreateCaptainRegisterCubit(this._loginCreateUseCase)
      : super(CreateCaptainRegisterInitial());

  CaptainService? carService;
  Position? locationData;
  geo.Placemark? placemark;
  DriverModel driverData = const DriverModel();
  String carRegistrationBack = "";
  String carRegistrationFront = "";
  String drivingLicence = "";

  // change service type
  changeServiceType(CaptainService service) {
    emit(CreateCaptainRegisterLoading());
    carService = service;
    emit(CreateCaptainRegisterLoaded());
  }

  bool isCreateCaptain = false;

  // Only showing the fixed createCaptain method - replace your existing method with this:

createCaptain(BuildContext context) async {
  emit(CreateCaptainRegisterLoading());
  final TextFieldCubit textFieldCubit = Di().sl<TextFieldCubit>();
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  final CaptainStepperCubit captainStepperCubit =
      Di().sl<CaptainStepperCubit>();
  final MenueCubit menueCubit = Di().sl<MenueCubit>();
  
  isCreateCaptain = true;
  
  // Create driver data
  driverData = DriverModel(
    carModel: textFieldCubit.carModelController.text,
    carNumberPlate: textFieldCubit.carNumberController.text,
    carRegistrationBack: carRegistrationBack,
    carRegistrationFront: carRegistrationFront,
    carService: carService!.name,
    drivingLicence: drivingLicence,
    address:
        "${placemark?.locality}, ${placemark?.subLocality}, ${placemark?.thoroughfare} , ${placemark?.country}",
    captainFirstName: textFieldCubit.firstNameController.text,
    captainLastName: textFieldCubit.lastNameController.text,
    captainNumber: textFieldCubit.phoneController.text,
    carBrand: "",
    isVerified: true,
    latitude: locationData?.latitude ?? 0,
    longitude: locationData?.longitude ?? 0,
    totalRides: 0,
  );
  
  // ✅ CRITICAL FIX: Set isRequestedDriver to true
  authCubit.getAuthData(authCubit.authData.copyWith(
    driverModel: driverData,
    isRequestedDriver: true, // ✅ This was missing!
  ));
  
  // Save to Firebase
  var result = await authCubit.updateUserInfo(context);
  
  if (result.isLeft()) {
    isCreateCaptain = false;
    emit(CreateCaptainRegisterError());
    WarningHelper.showToast(context,
        message: "Error while creating captain", color: AppColors.redColor);
  } else if (result.isRight()) {
    isCreateCaptain = false;
    emit(CreateCaptainRegisterLoaded());
    captainStepperCubit.nextStep(5);
    menueCubit.changeIndex(0);
    WarningHelper.showToast(context,
        message:
            "We Have Received Your Application. Our Team Is Processing Your Application",
        color: AppColors.greenColor);
    menueCubit.changeState(AppState.user, context);
    AutoRouter.of(context).pushAndPopUntil(
      const DashBoardPageRoute(),
      predicate: (route) => false,
    );
  }
  
  emit(CreateCaptainRegisterLoaded());
}
  // get the driver current location and convert address
 // Replace the getDriverLocation method in your CreateCaptainRegisterCubit with this:

Future<void> getDriverLocation(BuildContext context) async {
  print("🔍 Getting driver location...");
  
  emit(CreateCaptainRegisterLoading());

  // If location already exists, no need to fetch again
  if (placemark != null && locationData != null) {
    print("✅ Location already exists");
    emit(CreateCaptainRegisterLoaded());
    return;
  }

  try {
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("❌ Location permission denied");
        WarningHelper.showToast(context,
            message: "Location permission is required",
            color: AppColors.redColor);
        emit(CreateCaptainRegisterError());
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("❌ Location permission permanently denied");
      WarningHelper.showToast(context,
          message: "Please enable location permission in settings",
          color: AppColors.redColor);
      emit(CreateCaptainRegisterError());
      return;
    }

    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("❌ Location service is disabled");
      WarningHelper.showToast(context,
          message: "Please enable location services",
          color: AppColors.redColor);
      emit(CreateCaptainRegisterError());
      return;
    }

    // Get current position
    print("📍 Fetching current position...");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    locationData = position;
    print("✅ Position fetched: ${position.latitude}, ${position.longitude}");

    // Get address from coordinates
    print("📍 Getting address from coordinates...");
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      placemark = placemarks.first;
      print("✅ Address: ${placemark?.locality}, ${placemark?.country}");
      
      WarningHelper.showToast(context,
          message: "Location fetched successfully",
          color: AppColors.greenColor);
      
      emit(CreateCaptainRegisterLoaded());
    } else {
      print("❌ No address found");
      emit(CreateCaptainRegisterError());
    }
  } catch (e) {
    print("❌ Error getting location: ${e.toString()}");
    WarningHelper.showToast(context,
        message: "Failed to get location. Please try again.",
        color: AppColors.redColor);
    emit(CreateCaptainRegisterError());
  }
}
  // send otp
  Future<void> sendOtp(BuildContext context) async {
    emit(CreateCaptainRegisterLoading());
    showLoadingDialoge(context);
    final result = await _loginCreateUseCase.create(context);
    if (result.isLeft()) {
      result.fold((l) => l, (r) => r);
      context.router.pop();
      WarningHelper.showToast(context,
          message: "Error while sending OTP", color: AppColors.redColor);
      emit(CreateCaptainRegisterError());
    } else if (result.isRight()) {
      context.router.pop();
      WarningHelper.showToast(context,
          color: AppColors.greenColor, message: "OTP sent to your email");
      AutoRouter.of(context).push(OtpPageRoute(state: AppState.captain));
      emit(CreateCaptainRegisterLoaded());
    }
  }

  //verify otp
  Future<void> verifyOtp(
    BuildContext context,
  ) async {
    final TextFieldCubit fieldCubit = Di().sl<TextFieldCubit>();
    emit(CreateCaptainRegisterLoading());

    showLoadingDialoge(context);
    final result = EmailOTP.verifyOTP(otp: fieldCubit.otpController.text);
    if (result) {
      context.router.pop();
      AutoRouter.of(context).push(const CaptainServicePageRoute());
      emit(CreateCaptainRegisterLoaded());
    } else {
      context.router.pop();
      WarningHelper.showToast(context,
          message: "Invalid OTP, Please try again", color: AppColors.redColor);
      emit(CreateCaptainRegisterError());
    }
  }

  // upload driver documents
  Future<bool> uploadCarRegistrationFront(File file) async {
    emit(CreateCaptainRegisterLoading());
    String image = await uploadStorage(
      file,
      foldername: AppConstants.carRegistrationImages,
    );
    if (image.isNotEmpty) {
      carRegistrationFront = image;
      emit(CreateCaptainRegisterLoaded());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadCarRegistrationBack(File file) async {
    emit(CreateCaptainRegisterLoading());
    String image = await uploadStorage(
      file,
      foldername: AppConstants.carRegistrationImages,
    );
    if (image.isNotEmpty) {
      carRegistrationBack = image;
      emit(CreateCaptainRegisterLoaded());
      return true;
    } else {
      return false;
    }
  }

  // upload registration files both
  bool isUploadingFiles = false;
  uploadFiles(
    File vF,
    File vB,
    BuildContext context,
  ) async {
    isUploadingFiles = true;
    await Future.wait(
        [uploadCarRegistrationBack(vB), uploadCarRegistrationFront(vF)]).then(
      (value) {
        if (value[0] && value[1]) {
          isUploadingFiles = false;
          AutoRouter.of(context).pop();
          emit(CreateCaptainRegisterLoaded());
        } else {
          WarningHelper.showToast(context,
              message: "Error while uploading files",
              color: AppColors.redColor);
          isUploadingFiles = false;
          emit(CreateCaptainRegisterError());
        }
        emit(CreateCaptainRegisterLoaded());
      },
    );
  }

  uploadDrivingLicence(File file) async {
    isUploadingFiles = true;
    emit(CreateCaptainRegisterLoading());
    String image = await uploadStorage(
      file,
      foldername: AppConstants.drivingLicence,
    );
    drivingLicence = image;
    isUploadingFiles = false;
    emit(CreateCaptainRegisterLoaded());
  }
}
