import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/image_picker_cubit.dart';
import 'package:hikespot/blocs/cubits/text_field_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/captain-doc/presentation/widgets/bullet_point_text.dart';
import 'package:hikespot/pages/editprofile/presentation/bloc/cubit/edit_profile_cubit.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/text_field.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_setting_container.dart';
import 'package:hikespot/pages/upload/presentation/widgets/upload_profile_image_container.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class CaptainUploadProfilePage extends StatefulWidget {
  const CaptainUploadProfilePage({super.key});

  @override
  State<CaptainUploadProfilePage> createState() =>
      _CaptainUploadProfilePageState();
}

class _CaptainUploadProfilePageState extends State<CaptainUploadProfilePage> {
  @override
  void initState() {
    _fieldCubit.firstNameController.text = authCubit.authData.username;
    super.initState();
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
              const SizedBox(
                height: 20,
              ),
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
                  const SizedBox(
                    width: 8,
                  ),
                  const AppTextStyle(
                      text: "Profile Picture",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              const Center(
                  child: UploadProfileImageContainer(
                iconColor: AppColors.primaryDark,
              )),
              SizedBox(
                height: getHeight(context) * 0.055,
              ),
              ProfileTextField(
                  hintText: "Enter your first name",
                  controller: _fieldCubit.firstNameController,
                  heading: "First Name"),
              SizedBox(
                height: getHeight(context) * 0.016,
              ),
              ProfileTextField(
                  hintText: "Enter your last name",
                  controller: _fieldCubit.lastNameController,
                  heading: "Last Name"),
              SizedBox(
                height: getHeight(context) * 0.018,
              ),
              const AppTextStyle(
                text: "Important Notes:",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark,
              ),
              SizedBox(
                height: getHeight(context) * 0.018,
              ),
              const BulletPointText(
                  text:
                      "Your name should be same as mentioned on your national id card. "),
              SizedBox(
                height: getHeight(context) * 0.09,
              ),
              GestureContainer(
                text: "Add",
                isNeedArrow: false,
                isValidate: _fieldCubit.firstNameController.text.isNotEmpty &&
                    _fieldCubit.lastNameController.text.isNotEmpty,
                onTap: () {
                  if (_fieldCubit.firstNameController.text.isNotEmpty &&
                      _fieldCubit.lastNameController.text.isNotEmpty) {
                    if (_imagePickerCubit.image != null) {
                      _editProfileCubit.updateProfile(context).then(
                        (value) {
                          if (value.isRight()) {
                            AutoRouter.of(context).pop();
                          } else {
                            WarningHelper.showToast(context,
                                message: "Something went wrong");
                          }
                        },
                      );
                    } else {
                      AutoRouter.of(context).pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

final TextFieldCubit _fieldCubit = Di().sl<TextFieldCubit>();
final EditProfileCubit _editProfileCubit = Di().sl<EditProfileCubit>();
final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
