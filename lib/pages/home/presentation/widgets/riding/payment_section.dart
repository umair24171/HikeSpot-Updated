import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/addcard/presentation/widgets/money_option_dropdown.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/riding_section_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_style.dart';
import '../../../../../utils/images_paths.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _ridingSectionCubit.togglePayment();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.37),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded,
                    color: AppColors.whiteColor),
              ),
            ),
            const AppTextStyle(
              text: "Offer your fare",
              fontSize: 20,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
            GestureDetector(
              onTap: () {
                _ridingSectionCubit.togglePayment();
              },
              child: Container(
                height: 29,
                width: 29,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.65),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.cancelIcon),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
         LocationSearchField(
          hintText: "Offer your fare",
          controller:_createRideCubit.fareController ,
          keyboardType: TextInputType.number,
          prefixIcon: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextStyle(
                text: " ZAR ",
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 11,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: AppTextStyle(
            text: "Recommended fare ZAR700",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.redColor,
          ),
        ),
        const SizedBox(
          height: 23,
        ),
        const CustomDropdown(hint: "Cash", items: [
          "Cash",
          // "Card",
          // "Wallet",
          // "Mastercard"
        ], 
        isNeedAddCard: false,
        images: [
          AppImages.cashIcon,
          AppImages.visaCard,
          AppImages.walletIcon
        ]),
        const SizedBox(
          height: 91,
        ),
          GestureContainer(
          text: "Done",
          textColor: AppColors.blackColor,
          isNeedArrow: false,
          onTap: () {
             _ridingSectionCubit.togglePayment();
          },
          isValidate: true,
        )
      ],
    );
  }
}


final RidingSectionCubit _ridingSectionCubit = Di().sl<RidingSectionCubit>();
final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();