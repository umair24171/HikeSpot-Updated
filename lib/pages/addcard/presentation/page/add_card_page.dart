import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/pages/editprofile/presentation/widgets/text_field.dart';
import 'package:hikespot/widgets/gesture_container.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

@RoutePage()
class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

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
                          text: "Add Card",
                          fontSize: 20,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const ProfileTextField(
                    hintText: "",
                    heading: "Email Address",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const ProfileTextField(
                    hintText: "",
                    heading: "Cardholder Name",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const ProfileTextField(
                    hintText: "",
                    heading: "Card Number",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: ProfileTextField(
                        hintText: "MM/YY",
                        heading: "Expiry Date",
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: ProfileTextField(
                        hintText: "",
                        heading: "CVV",
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const ProfileTextField(
                    hintText: "Country or Region",
                    heading: "Country",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const ProfileTextField(
                    hintText: "Zip Code",
                    heading: "Zip Code  ( Optional )",
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  GestureContainer(
                    text: "Add Card",
                    isNeedArrow: false,
                    isValidate: false,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppTextStyle(text: "All payment information is stored securely", fontSize: 14, fontWeight: FontWeight.w500,color: AppColors.whiteColor,),
                ],
              ),
            ),
          ),
        ));
  }
}
