import 'dart:developer';
// import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/domain/usecase/auth_usecase.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/auth-model/auth_model.dart';
part '../states/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase _authUseCase;
  AuthCubit(this._authUseCase) : super(AuthInitial());

  AuthModel authData = const AuthModel();
  // final appLinks = AppLinks();

  Future<void> getSelfInfo(BuildContext context) async {
    emit(AuthLoading());
    final result = await _authUseCase.getSelfInfo(context);
    log("hk-auth-cubit: getSelfInfo: $result");
    result.fold(
      (error) => emit(AuthFailure(error)),
      (authModel) {
        authData = authModel;
        print("user data is ${authData.driverModel}");
        emit(AuthSuccess(authModel));
      },
    );
  }

  // update location
  Future<void> updateLocation(BuildContext context) async {
    
    emit(AuthLoading());
    authData = authData.copyWith(
      latitude: Di().sl<GoogleMapCubit>().currentLocation?.latitude ?? 0,
      longitude: Di().sl<GoogleMapCubit>().currentLocation?.longitude ?? 0,
      address: Di().sl<GoogleMapCubit>().getAddressFromPlacemark(),
    );
    if(authData.address=="null,null,null, null"){

    }else{
updateUserInfo(context);
    }
    
    emit(AuthSuccess(authData));
  }



  //change the app state
  void changeState(AppState state, context) {
    emit(AuthLoading());
    authData = authData.copyWith(appStatus: state.name);
    updateUserInfo(context);
    emit(AuthSuccess(authData));
  }



  getAuthData(AuthModel authData) {
    emit(AuthLoading());
    this.authData = authData;
    emit(AuthSuccess(authData));
  }



  /// get the image url
  getImageUrl(String url) {
    emit(AuthLoading());
    authData = authData.copyWith(
      imageUrl: url,
    );
    emit(AuthSuccess(authData));
  }



  /// get the id card front image url and back image url
  getIdCardImageUrl(String frontUrl, String backUrl) {
    emit(AuthLoading());
    authData = authData.copyWith(
      idCardFront: frontUrl,
      idCardBack: backUrl,
    );
    emit(AuthSuccess(authData));
  }



  /// update the user info
  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context) async {
    emit(AuthLoading());
    final result =
        await _authUseCase.updateUserInfo(context, authModel: authData);
        
    result.fold(
      (error) => emit(AuthFailure(error)),
      (authModel) {
        authData = authModel;
        emit(AuthSuccess(authModel));
      },
    );
    return result;
  }



  // init function
  Future<void> init(BuildContext context) async {
    emit(AuthInitial());
    await getSelfInfo(context);
    if (authData.uid.isEmpty) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          AutoRouter.of(context).replace(const GetStartedPageRoute());
        },
      );
    }
    //  else if ((authData.imageUrl.isEmpty)) {
    //   AutoRouter.of(context).replace(VerifiedPageRoute(
    //     heading: "Phone Number Verified",
    //     subHeading:
    //         "Congratulations 🎊 your phone\nnumber has been successfully verified.",
    //     user: NewUser.newUser,
    //   ));
    // } 
    else if (authData.isRequestedDriver &&(authData.idCardBack.isEmpty || authData.idCardFront.isEmpty)) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          AutoRouter.of(context).replace(const UploadIdPageRoute());
        },
      );
    } else {
      AutoRouter.of(context).replace(const DashBoardPageRoute());
    }
  }

  // update the notification status
  updateNotificationStatus(bool value, BuildContext context) async {
       
    emit(AuthInitial());
    authData = authData.copyWith(notificationEnabled: value);
    emit(AuthSuccess(authData));
    var result = await updateUserInfo(context);
    result.fold(
      (l) => authData = authData.copyWith(notificationEnabled: false),
      (r) => "",
    );
  }

  Future<void> checkInitialDeepLink(context) async {
    try {
      // final initialUri = await appLinks.getInitialLink();
      // log("Initial deep link: $initialUri");
      // if (initialUri != null) {
      //   handleDeepLink(initialUri, context);
      // } else {
        init(context);
      // }
    } catch (e) {
      log("Error getting initial deep link: $e");
    }
  }


  void handleDeepLink(Uri uri, context) {
    log("Handling deep link: ${uri.toString()}");
    if (uri.fragment == "refer") {
      log("refer code: ${uri.queryParameters['code']}");
      AutoRouter.of(context).push(const ReferPageRoute());
    }
  }

  // sign out
  signOut(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await OneSignal.logout();
      AutoRouter.of(context).pushAndPopUntil(
        const GetStartedPageRoute(),
        predicate: (route) => false,
      );
    } catch (e) {
      log("error while logout");
    }
  }

  // check if the captain is verified in db
  checkCaptainStatus(BuildContext context) async {
    emit(AuthLoading());
    if (authData.isRequestedDriver == false) {
      emit(AuthSuccess(authData));
      return;
    }


    await AppConstants.firestore
        .collection("users")
        .doc(authData.uid)
        .get()
        .then(
      (value) {
        if (value.exists) {
          AuthModel user = AuthModel.fromJson(value.data()!);
          if (user.isRequestedDriver &&
              user.driverModel.isVerified == true &&
              authData.driverModel.isVerified == false) {
            debugPrint("hk-auth-cubit: checkCaptainStatus: user: $user");
            authData = user;
            updateUserInfo(context);
            emit(AuthSuccess(user));
          }
        }
      },
    );
  }

  ///>>>>>>>>>>>>> driver data handel <<<<<<<<<<<<<<<<<<<///

  // turn on duty
  void turnOnDuty(BuildContext context) {
    emit(AuthLoading());
    authData = (authData.copyWith(
        driverModel: authData.driverModel.copyWith(isOnDuty: !authData.driverModel.isOnDuty)));
    updateUserInfo(context);
    emit(AuthSuccess(authData));
  }
}
