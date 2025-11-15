import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';

import '../../../../../core/di/service_locator_imports.dart';
import '../../bloc/cubit/google_map_cubit.dart';

class RidesWidget extends StatelessWidget {
  final String icon;
  final String heading;
  final String subHeading;
  final String? secIcon;
  final int index;
  final CaptainService service;
  const RidesWidget(
      {super.key,
      required this.icon,
      required this.heading,
      required this.subHeading,
      this.secIcon,
      required this.index, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _createRideCubit,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            _createRideCubit.changeCarService(service);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Stack(
              children: [
                const SizedBox(
                  height: 65,
                  width: 170,
                ),
                Container(
                  // height: 65,
                  width: 144,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _createRideCubit.selectedService ==  service
                        ? AppColors.redColor.withOpacity(0.34)
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                        text: heading,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      AppTextStyle(
                        text: subHeading,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                      ),
                      if (secIcon != null)
                        Image.asset(
                          secIcon!,
                          height: 20,
                          width: 20,
                        ),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      icon,
                      height: 40,
                      width: 80,
                      fit: index == 9 ? null :BoxFit.cover,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();