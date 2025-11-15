import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/login/domain/usecase/login_create_usecase.dart';
import 'package:hikespot/utils/app_colors.dart';

import '../../../../../routes/routes_imports.gr.dart';
import '../../../../../utils/enums.dart';
part '../state/login_create_state.dart';

class LoginCreateCubit extends Cubit<LoginCreateState> {
  final LoginCreateUseCase _loginCreateUseCase;
  LoginCreateCubit(this._loginCreateUseCase) : super(LoginCreateInitial());

  Future<void> loginCreate(BuildContext context) async {
    emit(LoginCreateLoading());
    final result = await _loginCreateUseCase.create(context);
    if (result.isLeft()) {
      String error = result.fold((l) => l, (r) => r);
      WarningHelper.showToast(context, message: "Error while sending OTP",color: AppColors.redColor);
      emit(LoginCreateFailure(error));
    } else if (result.isRight()) {
      WarningHelper.showToast(context,
          color: AppColors.greenColor, message: "OTP sent to your email");
      AutoRouter.of(context).replace(OtpPageRoute(state: AppState.user));
      emit(LoginCreateSuccess());
    }
  }
}
