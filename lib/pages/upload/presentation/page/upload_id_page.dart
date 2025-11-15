import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/helper/tap_helper.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/widgets/choose_uploading.dart';
import '../../../../blocs/cubits/image_picker_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/warning_helper.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/images_paths.dart';
import '../../../../utils/sizes.dart';
import '../../../../widgets/gesture_container.dart';
import '../../../../widgets/widgets.dart';

@RoutePage()
class UploadIdPage extends StatelessWidget {
  const UploadIdPage({super.key});

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
                    text: "Submit your ID",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                const AppTextStyle(
                  text:
                      "Submit front and back side of your ID\n card. It is required for payment and a blue\n verification check.",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return buildInkWell(
                      context: context,
                      onTap: () {
                        chooseUploadBottomSheet(
                            context, UploadType.idCardFront);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          height: 170,
                          width: 310,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff808B9A)),
                            borderRadius: BorderRadius.circular(17),
                            color: AppColors.primaryGreyColor.withOpacity(0.5),
                          ),
                          child: _imagePickerCubit.idCardFront != null
                              ? Image.file(_imagePickerCubit.idCardFront!,
                                  fit: BoxFit.fill)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.uploadIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const AppTextStyle(
                                      text:
                                          "Upload Image  of front side of Id card",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff808B9A),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getWidth(context) * 0.02,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return buildInkWell(
                      context: context,
                      onTap: () {
                        chooseUploadBottomSheet(context, UploadType.idCardBack);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          height: 170,
                          width: 310,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff808B9A)),
                            borderRadius: BorderRadius.circular(17),
                            color: AppColors.primaryGreyColor.withOpacity(0.5),
                          ),
                          child: _imagePickerCubit.idCardBack != null
                              ? Image.file(_imagePickerCubit.idCardBack!,
                                  fit: BoxFit.fill)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.uploadIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const AppTextStyle(
                                      text:
                                          "Upload Image  of back side of Id card",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff808B9A),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
                // const Spacer(),
                SizedBox(
                  height: getHeight(context) * 0.1,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    return GestureContainer(
                      text: "Verify Account",
                      isValidate: _imagePickerCubit.idCardFront != null &&
                          _imagePickerCubit.idCardBack != null,
                      isLoading: state is ImagePickerUploading,
                      onTap: () async {
                        if (_imagePickerCubit.idCardFront == null ||
                            _imagePickerCubit.idCardBack == null) {
                          WarningHelper.showToast(context,
                              message: "Please upload your ID card",
                              color: AppColors.redColor);
                          return;
                        } else {
                          await Future.wait([
                            _imagePickerCubit
                                .uploadImage(_imagePickerCubit.idCardFront!),
                            _imagePickerCubit
                                .uploadImage(_imagePickerCubit.idCardBack!),
                          ]).then((value) {
                            _authCubit.getIdCardImageUrl(value[0], value[1]);
                            _authCubit.updateUserInfo(context);
                          });
                          AutoRouter.of(context).push(VerifiedPageRoute(
                              user: NewUser.oldUser,
                              heading: "ID Verified",
                              subHeading:
                                  "Congratulations 🎊 your ID has been\nsuccessfully verified."));
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: getHeight(context) * 0.08,
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
