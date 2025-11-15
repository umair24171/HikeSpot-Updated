import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/cached_image_helper.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/choose_uploading.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authCubit,
      builder: (context, state) {
        return SizedBox(
          height: 135,
          width: 135,
          child: Stack(
            children: [
              CachedImageHelper(
                  imageUrl: _authCubit.authData.imageUrl,
                  height: 135,
                  width: 135),
              Positioned(
                bottom: 0,
                right: 2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    chooseUploadBottomSheet(context, UploadType.profile);
                  },
                  child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.17),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.imageIcon),
                        ],
                      ),
                    ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();