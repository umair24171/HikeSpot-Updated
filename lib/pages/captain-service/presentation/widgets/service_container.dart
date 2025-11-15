import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/sizes.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/enums.dart';

class ServiceContainer extends StatefulWidget {
  final String image;
  final String serviceName;
  final String serviceDescription;
  final CaptainService service;
  const ServiceContainer(
      {super.key,
      required this.image,
      required this.serviceName,
      required this.serviceDescription,
      required this.service});

  @override
  State<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends State<ServiceContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _createCaptainRegisterCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _createCaptainRegisterCubit.changeServiceType(widget.service);
          },
          child: Container(
            // height:  181,
            constraints: BoxConstraints(
              maxWidth: getWidth(context) * 0.9,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _createCaptainRegisterCubit.carService != widget.service
                  ? AppColors.primaryGreyColor.withOpacity(0.17)
                  : null,
              gradient: _createCaptainRegisterCubit.carService == widget.service
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                          AppColors.redColor.withOpacity(0.17),
                          AppColors.primaryDark.withOpacity(0.17)
                        ])
                  : null,
              border: _createCaptainRegisterCubit.carService == widget.service
                  ? Border.all(
                      color: AppColors.primaryDark.withOpacity(0.7), width: 1)
                  : Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    widget.image,
                    height: 88,
                    width: 222,
                  ),
                ),
                AppTextStyle(
                  text: widget.serviceName,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
                AppTextStyle(
                  text:
                      "Become a HikeSpot Captain to pick and drop customers in a ${widget.serviceDescription}",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();
