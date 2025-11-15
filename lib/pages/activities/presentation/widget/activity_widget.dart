import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';

class ActivityWidget extends StatelessWidget {
  final ContainerType containerType;
  final RideDataModel rideData;
  const ActivityWidget(
      {super.key, required this.containerType, required this.rideData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.secContainerColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryGreyColor.withOpacity(0.37)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppTextStyle(
                text: rideData.rideDate,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              const Spacer(),
              if (containerType == ContainerType.activities)
                const Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: AppColors.greenColor,
                ),
              if (containerType == ContainerType.activities)
                AppTextStyle(
                  text: " ${rideData.rideStatus}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greenColor,
                ),
              if (containerType == ContainerType.schedule)
                AppTextStyle(
                  text: " ${rideData.rideTime}",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
            ],
          ),
          AppTextStyle(
            text: "ZAR${rideData.fare.toInt().toString()}",
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryDark,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.enteranceIcon,
                height: 20,
                width: 20,
              ),
              AppTextStyle(
                text: rideData.pickupAddress,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          if (rideData.stepOverAddress.isNotEmpty)
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.mapIcon,
                  height: 20,
                  width: 20,
                ),
                AppTextStyle(
                  text: rideData.stepOverAddress,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.lineIcon,
                height: 20,
                width: 20,
              ),
              AppTextStyle(
                text: rideData.destinationAddress,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
