import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/addcard/presentation/widgets/money_option_dropdown.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../utils/app_text_style.dart';
import '../bloc/cubit/payment_cubit.dart';
import 'package:payfast/payfast.dart' as  pa;
import 'package:payfast/src/models/merchant_details.dart';

@RoutePage()
class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const AppTextStyle(
                        text: "Add Money",
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 57,
                ),
                const AppTextStyle(

                  text: "Enter Amount",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
                const SizedBox(
                  height: 14,
                ),
                LocationSearchField(
                  hintText: "",
                  controller: _paymentCubit.amountController,
                  prefixIcon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextStyle(
                        text: " ZAR ",
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const AppTextStyle(
                  text: "Select Card",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
                const SizedBox(
                  height: 14,
                ),
                const CustomDropdown(
                    images: [
                      AppImages.stripeIcon,
                      AppImages.visaCard,
                      AppImages.masterCard
                    ],
                    isNeedAddCard: false,
                    items: [
                      "Payfast",
                      "Visa",
                      "Mastercard",
                    ]),
                const SizedBox(
                  height: 98,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      text: "I agree with",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                    AppTextStyle(
                      text: " terms ",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor,
                    ),
                    AppTextStyle(
                      text: "and ",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                    AppTextStyle(
                      text: "conditions",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                GestureContainer(
                  text: "Add",
                  isNeedArrow: false,
                  onTap: () async{
                      var payfast = pa.Payfast(
    passphrase: 'JoshuaMunstermann',
    paymentType: pa.PaymentType.simplePayment,
    production: false,
    merchantDetails: MerchantDetails(
      merchantId: '10026561',
      merchantKey: 'cwon220sjr9ga',
      cancelUrl: '',
      notifyUrl: 'https://b5f5-196-30-8-166.eu.ngrok.io',
      returnUrl: 'https://google.com',
    ),
  );
                  await  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({'balance':double.parse(_paymentCubit.amountController.text)});
                  },
                )
              ],
            ),
          ),
        )));
  }
}

final PaymentCubit _paymentCubit = Di().sl<PaymentCubit>();
