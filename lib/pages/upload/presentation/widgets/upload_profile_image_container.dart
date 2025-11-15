import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/helper/cached_image_helper.dart';
import 'package:hikespot/widgets/choose_uploading.dart';

import '../../../../blocs/cubits/image_picker_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/images_paths.dart';

class UploadProfileImageContainer extends StatelessWidget {
  final Color? iconColor;
  const UploadProfileImageContainer({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(110),
      splashColor: AppColors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.transparent),
      onTap: () {
        chooseUploadBottomSheet(context, UploadType.profile);
      },
      child: BlocBuilder(
        bloc: _imagePickerCubit,
        builder: (context, state) {
          return _authCubit.authData.imageUrl.isNotEmpty &&
                  _imagePickerCubit.image == null
              ? CachedImageHelper(
                  imageUrl: _authCubit.authData.imageUrl,
                  height: 220,
                  width: 220)
              : _imagePickerCubit.image != null
                  ? SizedBox(
                      height: 220,
                      width: 220,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _imagePickerCubit.image ?? File(""),
                            fit: BoxFit.cover,
                          )),
                    )
                  : DottedBorder(
                      color: const Color(0xff808B9A),
                      strokeWidth: 1,
                      borderPadding: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(4),
                      borderType: BorderType.Circle,
                      strokeCap: StrokeCap.round,
                      radius: const Radius.circular(3),
                      dashPattern: const [6],
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryGreyColor.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.uploadIcon,
                              color: iconColor ?? const Color(0xff808B9A),
                            ),
                            AppTextStyle(
                              text: "Upload Profile Picture",
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: iconColor ?? const Color(0xff808B9A),
                            ),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}

final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
