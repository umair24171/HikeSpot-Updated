import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/utils/styles.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../utils/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  final Color? textColor;
  final String? errorText;
  final PhoneController? phoneController;
  final Function(PhoneNumber)? onChanged;
  final Function(String)? onSubmit;
  final Color? fillColor;
  const PhoneTextField({
    super.key,
    this.textColor,
    this.onChanged,
    this.errorText,
    this.onSubmit,
    this.fillColor,
    this.phoneController,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final PhoneController _phoneController = PhoneController();
  final FocusNode _focusNode = FocusNode();
  String isEmpty = "";

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fillColor ?? AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: widget.fillColor != null
            ? null
            : [
                BoxShadow(
                  color: isEmpty.isNotEmpty
                      ? AppColors.primaryDark.withOpacity(0.25)
                      : AppColors.primaryGreyColor.withOpacity(0.25),
                  spreadRadius: 3.62,
                  blurRadius: 3.62,
                ),
              ],
      ),
      child: PhoneFormField(
        controller: widget.phoneController ?? _phoneController,
        focusNode: _focusNode,
        showFlagInInput: true,
        countryCodeStyle: Styles.textStyle.copyWith(color: widget.textColor),
        cursorColor: AppColors.primaryDark,
        countryButtonPadding: const EdgeInsets.only(left: 10),
        countrySelectorNavigator: const CountrySelectorNavigator.page(),
        onChanged: (phoneNumber) {
          _phoneTextFieldCubit.phoneController.text =
              '+${phoneNumber.countryCode}${phoneNumber.nsn}';
          log(_phoneTextFieldCubit.phoneController.text);
          _phoneTextFieldCubit.checkField();
          setState(() {
            isEmpty = phoneNumber.nsn;
          });
        },
        isCountrySelectionEnabled: true,
        isCountryButtonPersistent: true,
        countryButtonStyle: const CountryButtonStyle(
          showDialCode: true,
          showIsoCode: true,
          showFlag: true,
          flagSize: 16,
        ),
        style: Styles.textStyle.copyWith(color: widget.textColor),
        decoration: InputDecoration(
          fillColor: widget.fillColor ?? AppColors.whiteColor,
          contentPadding: const EdgeInsets.only(bottom: 3),
          constraints: const BoxConstraints(
            maxHeight: 44,
            minHeight: 44,
          ),
          suffixIcon: isEmpty.isEmpty || !_focusNode.hasFocus
              ? null
              : IconButton(
                  onPressed: () {
                    _phoneController.value =
                        const PhoneNumber(isoCode: IsoCode.US, nsn: '');
                  },
                  icon: const Icon(
                    Icons.cancel,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
          border: Styles.textFieldBorder.copyWith(
            borderSide: widget.fillColor != null ? null : BorderSide.none,
          ),
          enabledBorder: Styles.textFieldBorder.copyWith(
            borderSide: widget.fillColor != null
                ? BorderSide.none
                : BorderSide(
                    color: isEmpty.isNotEmpty
                        ? AppColors.primaryDark
                        : AppColors.primaryGreyColor,
                    width: 1),
          ),
          focusedBorder: Styles.textFieldBorder.copyWith(
            borderSide: widget.fillColor != null
                ? BorderSide.none
                : const BorderSide(color: AppColors.primaryDark, width: 1),
          ),
        ),
      ),
    );
  }
}

final TextFieldCubit _phoneTextFieldCubit = Di().sl<TextFieldCubit>();
