import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/helper/text_validator.dart';

part '../states/text_field_state.dart';

class TextFieldCubit extends Cubit<PhoneTextFieldState> {
  TextFieldCubit() : super(PhoneTextFieldInitial());

  String selectedCountryCode = "+1";
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String getFullPhoneNumber() {
    return '$selectedCountryCode${phoneController.text}';
  }

  // validate if the phone number and email is valid
  bool checkField() {
    if (phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        StringValidator.emailRegex.hasMatch(emailController.text)) {
      emit(PhoneTextFieldGetting());
      return true;
    } else {
      emit(PhoneTextFieldGetted());
      return false;
    }
  }

  selectCountryCode(String code) {
    emit(PhoneTextFieldGetting());
    selectedCountryCode = code;
    emit(PhoneTextFieldGetted());
  }
}
