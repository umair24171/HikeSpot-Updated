import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/image_picker_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/styles.dart';
import 'package:image_picker/image_picker.dart';

void chooseUploadBottomSheet(context,UploadType imageTypeProfile) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      barrierColor: AppColors.transparent.withOpacity(0),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              BottomContainer(
                containerName: 'Upload from gallery',
                onPressed: () async {
                  Navigator.of(context).pop();
                  Di().sl<ImagePickerCubit>().pickImage(ImageSource.gallery,type: imageTypeProfile);
                },
                radiusTop: const Radius.circular(10),
                radiusBottom: const Radius.circular(0),
                radiusLeft: const Radius.circular(10),
                radiusRight: const Radius.circular(0),
                color: const Color(0xff3B3B43),
              ),
              BottomContainer(
                containerName: 'Upload from camera',
                onPressed: () async {
                  Navigator.of(context).pop();
                  Di().sl<ImagePickerCubit>().pickImage(ImageSource.camera,type: imageTypeProfile);
                },
                radiusTop: const Radius.circular(0),
                radiusBottom: const Radius.circular(10),
                radiusLeft: const Radius.circular(0),
                radiusRight: const Radius.circular(10),
                color: const Color(0xff3B3B43),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: BottomContainer(
                  containerName: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  radiusTop: const Radius.circular(10),
                  radiusBottom: const Radius.circular(10),
                  radiusLeft: const Radius.circular(10),
                  radiusRight: const Radius.circular(10),
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        );
      });
}

class BottomContainer extends StatelessWidget {
  final String containerName;
  final Radius radiusTop;
  final Radius radiusBottom;
  final Radius radiusLeft;
  final Radius radiusRight;
  final VoidCallback onPressed;
  final Color color;
  const BottomContainer(
      {super.key,
      required this.containerName,
      required this.radiusTop,
      required this.radiusBottom,
      required this.radiusLeft,
      required this.onPressed,
      required this.radiusRight,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
          height: 61,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: radiusLeft,
                topRight: radiusTop,
                bottomLeft: radiusBottom,
                bottomRight: radiusRight,
              ),
              color: color),
          child: TextButton(
              onPressed: () => onPressed(),
              child: Text(containerName,
                  style:
                      Styles.textStyle.copyWith(color: AppColors.whiteColor)))),
    );
  }
}
