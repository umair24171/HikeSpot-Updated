import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikespot/pages/realease-payment/presentation/widgets/feedback_dialoge.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import '../../../../utils/app_colors.dart';

class PaymentSuccessfullDialoug extends StatelessWidget {
  const PaymentSuccessfullDialoug({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 310,
            decoration: BoxDecoration(
                border: Border.all(width: 0.1, color: AppColors.whiteColor),
                color: const Color(0xff424244).withOpacity(.6),
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.only(top: 28, bottom: 17),
            // width: 322,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.verifiedIcon),
                const SizedBox(
                  height: 7,
                ),
                const Text(
                  "Payment Successfully Received by Customer Side",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: const EdgeInsets.only(
                        left: 60, right: 60, top: 5, bottom: 20),
                    child: const Text(
                      "Your fare successfully received by customer Gregory Hayes",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    )),
                const Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "ZAR215",
                  style: TextStyle(
                    fontSize: 29.2,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 13,
                ),
                const MySeparator(
                  height: 1,
                  color: AppColors.primaryDark,
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  "How is your trip?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: const EdgeInsets.only(
                        left: 60, right: 60, top: 5, bottom: 20),
                    child: const Text(
                      "Your feedback will help us to improve your driving experience better",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: GestureContainer(
                    text: "Provide Feedback",
                    height: 47,
                    textSize: 16,
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(Duration.zero, () {
                        showModalBottomSheet(
                          context: context, 
                          isScrollControlled: true,
                          builder: (context) {
                            return const FeedbackDialog();
                          },
                        );
                      });
                    },
                    isNeedArrow: false,
                    textColor: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(100)),
              ),
            );
          }),
        );
      },
    );
  }
}
