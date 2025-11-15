import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/upload/presentation/widgets/upload_profile_image_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import '../../../../blocs/cubits/image_picker_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../../widgets/widgets.dart';

@RoutePage()
class UploadProfilePage extends StatelessWidget {
  const UploadProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getWidth(context) * 0.02,
                ),
                AppWidgets.appLogo,
                SizedBox(
                  height: getWidth(context) * 0.05,
                ),
                const AppTextStyle(
                    text: "Add Profile Picture",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                const AppTextStyle(
                  text: "Please add your profile picture\nthis mandatory.",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context) * 0.15,
                ),
                const UploadProfileImageContainer(),
                // const Spacer(),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return GestureContainer(
                      text: "Next",
                      isValidate: _imagePickerCubit.image != null,
                      isLoading: state is ImagePickerUploading,
                      onTap: () async {
                        if (state is! ImagePickerLoaded) {
                          WarningHelper.showToast(context,
                              message: "Please upload image",color: AppColors.redColor);
                          return;
                        } else {
                          String url = await _imagePickerCubit.uploadImage(_imagePickerCubit.image!);
                          _authCubit.getImageUrl(url);
                          _authCubit.updateUserInfo(context);
                          AutoRouter.of(context)
                              .push(const UploadIdPageRoute());
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
