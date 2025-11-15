import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/editprofile/presentation/bloc/cubit/edit_profile_cubit.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/image_container.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/text_field.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:hikespot/widgets/phone_text_field.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../helper/warning_helper.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  late PhoneController _phoneController;

  @override
  void initState() {
    super.initState();
    _textFieldCubit.nameController.text = _authCubit.authData.username;
    _textFieldCubit.emailController.text = _authCubit.authData.email;
    _textFieldCubit.phoneController.text = _authCubit.authData.phoneNumber;
    
    // ✅ SAFE PHONE NUMBER PARSING
    _initializePhoneController();
  }

  // ✅ Safely initialize phone controller with default country
  void _initializePhoneController() {
    try {
      final phoneText = _textFieldCubit.phoneController.text;
      
      // Check if phone number exists and is not empty
      if (phoneText.isNotEmpty) {
        // Try to find potential phone numbers
        final potentialNumbers = PhoneNumber.findPotentialPhoneNumbers(phoneText);
        
        // Check if any valid phone numbers were found
        if (potentialNumbers.isNotEmpty) {
          _phoneController = PhoneController(
            initialValue: potentialNumbers.first,
          );
          return;
        }
      }
      
      // ✅ Create controller with default Pakistan country code
      _phoneController = PhoneController(
        initialValue: PhoneNumber(
          isoCode: IsoCode.PK, // Pakistan
          nsn: '', // Empty number
        ),
      );
    } catch (e) {
      // If any error occurs, create default controller
      debugPrint('Error parsing phone number: $e');
      _phoneController = PhoneController(
        initialValue: PhoneNumber(
          isoCode: IsoCode.PK,
          nsn: '',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            color: AppColors.primaryDark.withOpacity(0.37),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back,
                            color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const AppTextStyle(
                        text: "Personal Information",
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                const SizedBox(height: 33),
                const Align(
                    alignment: Alignment.center, child: ImageContainer()),
                const SizedBox(height: 28),
                ProfileTextField(
                  hintText: "Enter your name",
                  controller: _textFieldCubit.nameController,
                  heading: "Name",
                  onChanged: (value) {
                    _editProfileCubit.checkIfChanged(
                        controllerValue: _textFieldCubit.nameController.text,
                        authValue: _authCubit.authData.username);
                  },
                ),
                const SizedBox(height: 20),
                ProfileTextField(
                  hintText: "Enter your email",
                  controller: _textFieldCubit.emailController,
                  heading: "Email Address",
                  onChanged: (value) {
                    _editProfileCubit.checkIfChanged(
                        controllerValue: _textFieldCubit.emailController.text,
                        authValue: _authCubit.authData.email);
                  },
                ),
                const SizedBox(height: 20),
                const AppTextStyle(
                  text: "Phone Number",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                const SizedBox(height: 10),
                // ✅ FIXED: Use safely initialized phone controller
                PhoneTextField(
                  phoneController: _phoneController,
                  onChanged: (value) {
                    if (value != null) {
                      // Store the national number (without country code)
                      _textFieldCubit.phoneController.text = value.nsn;
                      _editProfileCubit.checkIfChanged(
                          controllerValue: value.nsn,
                          authValue: _authCubit.authData.phoneNumber);
                    }
                  },
                  fillColor: AppColors.secContainerColor,
                  textColor: AppColors.whiteColor,
                ),
                SizedBox(height: getHeight(context) * 0.2),
                BlocBuilder(
                  bloc: _editProfileCubit,
                  builder: (context, state) {
                    return GestureContainer(
                      text: "Save",
                      isNeedArrow: false,
                      isLoading: state is EditProfileLoading,
                      isValidate: _editProfileCubit.isChanged,
                      onTap: () {
                        if (_editProfileCubit.isChanged) {
                          _editProfileCubit.updateProfile(context);
                        } else {
                          WarningHelper.showToast(context,
                              message: "No changes made");
                        }
                      },
                      textColor: AppColors.blackColor,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final EditProfileCubit _editProfileCubit = Di().sl<EditProfileCubit>();
final TextFieldCubit _textFieldCubit = Di().sl<TextFieldCubit>();