import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/helper/dialouge_helper.dart';
import 'package:hikespot/pages/realease-payment/presentation/widgets/payment_succesful_dialoge.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/images_paths.dart';

@RoutePage()
class ReleasePayment extends StatelessWidget {
  const ReleasePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                    width: 15,
                  ),
                  const AppTextStyle(
                      text: "Release Payment",
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 33,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.39,
                                    color: const Color(0xff837879))),
                            child: Container(
                              height: 78,
                              width: 78,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryDark.withOpacity(0.7)),
                            ),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              AppTextStyle(
                                text: 'Driver Details',
                                fontSize: 15,
                                color: Color(0xffffbc07),
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AppTextStyle(
                                text: 'Gregory Hayes',
                                fontSize: 15,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 94,
                                decoration: BoxDecoration(
                                    color:
                                        const Color(0xff424244).withOpacity(.6),
                                    borderRadius: BorderRadius.circular(25)),
                                padding: const EdgeInsets.only(
                                    top: 17, left: 11, right: 11, bottom: 17),
                                // width: 322,
                                child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextStyle(
                                              text: "Bike Details",
                                              fontSize: 18,
                                              color: AppColors.primaryDark,
                                              fontWeight: FontWeight.w600),
                                          AppTextStyle(
                                              text: "Honda CD 70",
                                              fontSize: 12,
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500),
                                          AppTextStyle(
                                              text: "AN 2435",
                                              fontSize: 12,
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              child: Image.asset(
                                AppImages.bikeTypeIcon,
                                height: 94,
                                width: 164,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const AppTextStyle(
                        text: 'Ride Fare',
                        fontSize: 20,
                        color: Color(0xffffbc07),
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextStyle(
                            text: 'Fare',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                          AppTextStyle(
                            text: 'ZAR600',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextStyle(
                            text: 'Promo',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                          AppTextStyle(
                            text: 'Zaro',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.primaryGreyColor,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextStyle(
                            text: 'SubTotal',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                          AppTextStyle(
                            text: 'ZAR600',
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      const PaymentMethodWidget(
                          title: "Cash Payment",
                          subTitle: "Default method",
                          svgImage: AppImages.cashPayoutIcon,
                          radioButton: true),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            AppImages.addMoneyIcon,
                            height: 15,
                            width: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const AppTextStyle(
                            text: 'Add New Card',
                            fontSize: 13,
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const PaymentMethodWidget(
                          title: "Visa Card",
                          subTitle: "** ** ** 4584",
                          svgImage: AppImages.visaPayoutIcon,
                          radioButton: false),
                      const SizedBox(
                        height: 13,
                      ),
                      const PaymentMethodWidget(
                          title: "Master Card",
                          subTitle: "** ** ** 4584",
                          svgImage: AppImages.masterPayoutIcon,
                          radioButton: false),
                      const SizedBox(
                        height: 35,
                      ),
                      GestureContainer(
                        text: "Send Payment",
                        textColor: AppColors.blackColor,
                        onTap: () {
                          DialogHelper.showGeDialog(
                              context: context,
                              dialog: const PaymentSuccessfullDialoug());
                        },
                        isNeedArrow: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.svgImage,
      required this.radioButton});
  final String title;
  final String subTitle;
  final String svgImage;
  final bool radioButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff56481e),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(svgImage),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: title,
                    fontSize: 13,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  AppTextStyle(
                    text: subTitle,
                    fontSize: 10.28,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ],
          ),
          SvgPicture.asset(radioButton == true
              ? "assets/icons/radio_on_icon.svg"
              : "assets/icons/radio_off_icon.svg"),
        ],
      ),
    );
  }
}
