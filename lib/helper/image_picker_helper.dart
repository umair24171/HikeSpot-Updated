import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  Future<Either<String, File>> pickImage(ImageSource source);
}

class ImagePickerHelperImpl extends ImagePickerHelper {
  @override
  Future<Either<String, File>> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source:source);
      if (pickedFile != null) {
        return Right(File(pickedFile.path));
      }
      return const Left("No image selected");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
