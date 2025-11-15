import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/captainregister/presentation/widgets/location_bottom_sheet.dart';
import 'package:hikespot/utils/app_text_style.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_colors.dart';
import '../bloc/cubit/create_captain_register_cubit.dart';

class CaptainLocationField extends StatelessWidget {
  const CaptainLocationField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _createCaptainRegisterCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with fetch button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppTextStyle(
                  text: "Location",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                GestureDetector(
                  onTap: () async {
                    print("🔍 Fetching location...");
                    await _createCaptainRegisterCubit.getDriverLocation(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryDark,
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.my_location_rounded,
                          size: 16,
                          color: AppColors.primaryDark,
                        ),
                        SizedBox(width: 6),
                        AppTextStyle(
                          text: "Use Current",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Location display / chooser
            GestureDetector(
              onTap: () {
                print("🔍 Opening location sheet...");
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const CaptainLocationAddSheet();
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                constraints: const BoxConstraints(minHeight: 56),
                decoration: BoxDecoration(
                  color: AppColors.secContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _createCaptainRegisterCubit.placemark != null
                        ? AppColors.primaryDark.withOpacity(0.3)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: _createCaptainRegisterCubit.placemark != null
                    ? Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.primaryDark,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppTextStyle(
                                  text: "Selected Location",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(height: 4),
                                AppTextStyle(
                                  text: "${_createCaptainRegisterCubit.placemark?.locality}, ${_createCaptainRegisterCubit.placemark?.subLocality}, ${_createCaptainRegisterCubit.placemark?.country}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryDark,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.edit_outlined,
                            color: AppColors.primaryDark,
                            size: 20,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: AppColors.primaryGreyColor.withOpacity(0.5),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: AppTextStyle(
                              text: "Search or choose location",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryGreyColor,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.primaryGreyColor.withOpacity(0.5),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

final CreateCaptainRegisterCubit _createCaptainRegisterCubit =
    Di().sl<CreateCaptainRegisterCubit>();