import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/editprofile/domain/usecase/editing_profile_usecase.dart';
part '../state/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditingProfileUsecase _editingProfileUsecase;
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  final TextFieldCubit _textFieldCubit = Di().sl<TextFieldCubit>();
  
  EditProfileCubit(this._editingProfileUsecase) : super(EditProfile());

  Future<Either<String, String>> updateProfile(BuildContext context) async {
    emit(EditProfileLoading());
    
    // Update profile in Firebase
    var result = await _editingProfileUsecase.execute(context);
    
    result.fold(
      (failure) {
        emit(EditProfileFailure(failure));
      }, 
      (success) async {
        // ✅ CRITICAL FIX: Update AuthCubit.authData with new values
        _authCubit.authData = _authCubit.authData.copyWith(
          username: _textFieldCubit.nameController.text,
          email: _textFieldCubit.emailController.text,
          phoneNumber: _textFieldCubit.phoneController.text,
        );
        
        // ✅ Update in Firebase and emit new state
        await _authCubit.updateUserInfo(context);
        
        // ✅ Alternatively, refresh from Firebase to get latest data
        // await _authCubit.getSelfInfo(context);
        
        emit(EditProfileSuccess());
      }
    );
    
    return result;
  }

  bool isChanged = false;

  /// check that if the user changed the value in the controller 
  checkIfChanged({required String? controllerValue, required String? authValue}) {
    if (controllerValue != authValue) {
      isChanged = true;
      emit(EditProfileSuccess());
    } else {
      isChanged = false;
      emit(EditProfileSuccess());
    }
  }
}