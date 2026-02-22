import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/image_picker_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/captain-doc/presentation/widgets/upload_doc_container.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/widgets/choose_uploading.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../widgets/bullet_point_text.dart';


@RoutePage()
class CaptainUploadLicencePage extends StatelessWidget {
  const CaptainUploadLicencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _captainRegisterCubit.isUploadingFiles == false,
      onPopInvoked: (didPop) {
        if (_captainRegisterCubit.isUploadingFiles == true) {
          WarningHelper.showToast(context,
              message: "Please wait while we upload your files.");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_captainRegisterCubit.isUploadingFiles) {
                          WarningHelper.showToast(context,
                              message:
                                  "Please wait while we upload your files.");
                        } else {
                          AutoRouter.of(context).pop();
                        }
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
                    const SizedBox(
                      width: 8,
                    ),
                    const AppTextStyle(
                        text: "Driving License",
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                const AppTextStyle(
                  text: "Upload Driving License",
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                const AppTextStyle(
                  text: "Please upload your driving license.",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return Center(
                      child: UploadRegistrationDocContainer(
                        onTap: () {
                          chooseUploadBottomSheet(context, UploadType.licence);
                        },
                        file: _imagePickerCubit.drivingLicence,
                        text: "Upload Image of frond side of Id card",
                        height: 165,
                        width: 310,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                const AppTextStyle(
                  text: "Important Notes:",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
                const SizedBox(
                  height: 15,
                ),
                const BulletPointText(
                    text: "Make sure your documents are not blurry."),
                const BulletPointText(
                    text: "Documents should be valid for at least 30 days."),
                const BulletPointText(text: "Should not be plastic coated."),
                const BulletPointText(text: "Use a plain background."),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return BlocBuilder(
                      bloc: _captainRegisterCubit,
                      builder: (context, state) {
                        return GestureContainer(
                          text: "Add",
                          isLoading: _captainRegisterCubit.isUploadingFiles,
                          isValidate: _imagePickerCubit.drivingLicence != null,
                          onTap: () {
                            if (_imagePickerCubit.drivingLicence == null)
                              return;
                            _captainRegisterCubit.uploadDrivingLicence(
                                _imagePickerCubit.drivingLicence!);
                                Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final CreateCaptainRegisterCubit _captainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
