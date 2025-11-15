import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/otp/domain/usecase/otp_verify_usecase.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../data/models/driver-model/driver_model.dart';
part '../state/otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  final OtpVerifyUseCase otpVerifyUseCase;
  OtpVerifyCubit(this.otpVerifyUseCase) : super(OtpVerifyLoading());

  bool isValidatingOtp = false;

  Future<void> otpVerify(AppState appstate, BuildContext context) async {
    final TextFieldCubit phoneTextFieldCubit = Di().sl<TextFieldCubit>();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    emit(OtpVerifyLoading());
    int randomRefer = Random().nextInt(900) + 100;
    List<String> referLinkCode =
        phoneTextFieldCubit.emailController.text.split("");
    String refer = "HKUA${referLinkCode[0] + referLinkCode[1]}$randomRefer";
    isValidatingOtp = true;
    AuthModel authModel = AuthModel(
        appStatus: appstate.name,
        createdAt: DateTime.now().toString(),
        email: phoneTextFieldCubit.emailController.text,
        phoneNumber: phoneTextFieldCubit.phoneController.text,
        ratings: 0,
        address: "",
        isRequestedDriver: false,
        totalRides: 0,
        uid: '',
        firstname: "",
        latitude: 0,
        longitude: 0,
        imageUrl: "",
        isOnline: false,
        notificationEnabled: true,
        referCode: refer,
        idCardBack: "",
        driverModel: const DriverModel(),
        pushToken: "",
        referedUsers: [],
        scheduleRides: [],
        lastname: "",
        username: "",
        idCardFront: "",
        cardModel: []);
    debugPrint(authModel.toJson().toString());
    final response = await otpVerifyUseCase.execute(
        phoneTextFieldCubit.otpController.text, authModel, context);
    if (response.isLeft()) {
      String error = response.foldLeft(
          "", (previousValue, element) => previousValue + element.toString());
      isValidatingOtp = false;
      emit(OtpVerifyFailure(error));
    } else {
      AuthModel authModel = response.foldRight(
          const AuthModel(), (first, previousValue) => first);
      isValidatingOtp = false;
      await OneSignal.login(authModel.uid);
      authCubit.getAuthData(authModel);
      emit(OtpVerifySuccess(authModel));
    }
  }

  // resent otp
  Future<void> resentOtp(BuildContext context) async {
    emit(OtpVerifyLoading());
    final response = await otpVerifyUseCase.resentOtp(context);
    if (response.isLeft()) {
      String error = response.foldLeft(
          "", (previousValue, element) => previousValue + element.toString());
      emit(OtpVerifyFailure(error));
    } else {
      response.foldRight("", (first, previousValue) => first);
      emit(OtpVerifyLoading());
    }
  }
}
