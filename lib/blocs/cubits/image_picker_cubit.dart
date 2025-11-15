import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/helper/firebase_storage_helper.dart';
import 'package:hikespot/helper/image_picker_helper.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:image_picker/image_picker.dart';

part '../states/image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePickerHelper _imagePickerHelper;
  ImagePickerCubit(this._imagePickerHelper) : super(ImagePickerInitial());

  File? image;
  File? idCardBack;
  File? idCardFront;
  File? vehicleDocFront;
  File? vehicleDocBack;
  File? drivingLicence;

  Future<void> pickImage(ImageSource source,
      {UploadType type = UploadType.profile}) async {
    emit(ImagePickerLoading());
    var result = await _imagePickerHelper.pickImage(source);
    result.fold(
      (error) => emit(ImagePickerError(error)),
      (image) {
        // ✅ Validate file exists
        if (!image.existsSync()) {
          emit(ImagePickerError("Selected file does not exist"));
          return;
        }

        if (type == UploadType.idCardFront) {
          idCardFront = image;
        } else if (type == UploadType.idCardBack) {
          idCardBack = image;
        } else if (type == UploadType.vehicleDocB) {
          vehicleDocBack = image;
        } else if (type == UploadType.vehicleDocF) {
          vehicleDocFront = image;
        } else if (type == UploadType.licence) {
          drivingLicence = image;
        } else {
          this.image = image;
        }

        emit(ImagePickerLoaded(image));
      },
    );
  }

  // Clear the image
  void clearImage() {
    image = null;
    emit(ImagePickerInitial());
  }

  // Upload the image
  Future<String> uploadImage(File data) async {
    try {
      // ✅ Validate file before upload
      if (!data.existsSync()) {
        emit(ImagePickerError("File does not exist"));
        return "";
      }

      emit(ImagePickerUploading());
      String url = await uploadStorage(data, foldername: AppConstants.profileKey);
      
      // ✅ Check if upload was successful
      if (url.isEmpty) {
        emit(ImagePickerError("Failed to upload image"));
        return "";
      }

      emit(ImagePickerUploaded());
      return url;
    } catch (e) {
      emit(ImagePickerError("Upload error: ${e.toString()}"));
      return "";
    }
  }
}