part of '../cubits/image_picker_cubit.dart';

class ImagePickerState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {
  ImagePickerInitial();
}

class ImagePickerLoading extends ImagePickerState {
  ImagePickerLoading();
}

class ImagePickerLoaded extends ImagePickerState {
  final File image;
  ImagePickerLoaded(this.image);
}

class ImagePickerError extends ImagePickerState {
  final String message;
  ImagePickerError(this.message);
}

class ImagePickerUploading extends ImagePickerState {
  ImagePickerUploading();
}

class ImagePickerUploaded extends ImagePickerState {
  ImagePickerUploaded();
}