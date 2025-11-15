import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/blocs/cubits/image_picker_cubit.dart';
import 'package:hikespot/helper/firebase_storage_helper.dart';
import 'package:hikespot/helper/warning_helper.dart';

import '../../../../blocs/cubits/text_field_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';

abstract class EditingProfileDataSource {
  Future<Either<String, String>> updateProfile(BuildContext context);
}

class EditingProfileDataSourceImpl implements EditingProfileDataSource {
  EditingProfileDataSourceImpl();

  @override
  Future<Either<String, String>> updateProfile(BuildContext context) async {
    final TextFieldCubit textFieldCubit = Di().sl<TextFieldCubit>();
    final ImagePickerCubit imagePickerCubit = Di().sl<ImagePickerCubit>();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    
    try {
      // ✅ Check if user is authenticated
      if (authCubit.authData.uid.isEmpty) {
        return const Left("User not authenticated");
      }

      // ✅ Handle image upload if new image selected
      if (imagePickerCubit.image != null) {
        // Upload new image
        String newImageUrl = await imagePickerCubit
            .uploadImage(imagePickerCubit.image ?? File(""));
        
        // ✅ Check if upload was successful
        if (newImageUrl.isEmpty) {
          WarningHelper.showToast(context,
              message: "Failed to upload image. Please try again.",
              color: Colors.red);
          return const Left("Image upload failed");
        }
        
        // ✅ Delete old image ONLY if it exists and is valid
        if (authCubit.authData.imageUrl.isNotEmpty) {
          await deleteStorage(authCubit.authData.imageUrl);
        }
        
        // Update image URL in auth data
        authCubit.getImageUrl(newImageUrl);
      }
      
      // ✅ Update profile fields
      authCubit.authData = authCubit.authData.copyWith(
        username: textFieldCubit.nameController.text.trim(),
        email: textFieldCubit.emailController.text.trim(),
        phoneNumber: textFieldCubit.phoneController.text.trim(),
      );
      
      // ✅ Save to Firebase
      var result = await authCubit.updateUserInfo(context);
      
      return result.fold(
        (error) {
          WarningHelper.showToast(context,
              message: "Failed to update profile: $error",
              color: Colors.red);
          return Left(error);
        },
        (authModel) {
          WarningHelper.showToast(context,
              message: "Profile Updated Successfully", 
              color: Colors.green);
          
          // ✅ Clear the selected image after successful upload
          imagePickerCubit.clearImage();
          
          return const Right("Success");
        },
      );
    } catch (e) {
      WarningHelper.showToast(context,
          message: "Error updating profile: ${e.toString()}",
          color: Colors.red);
      return Left("error ${e.toString()}");
    }
  }
}