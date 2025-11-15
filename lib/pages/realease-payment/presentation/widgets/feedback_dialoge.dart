import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import '../../../../utils/app_colors.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(18), topLeft: Radius.circular(18)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: getWidth(context) * 1,
          decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.whiteColor),
              color: const Color(0xff1c1f24),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          padding:
              const EdgeInsets.only(top: 28, bottom: 17, left: 27, right: 27),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 13),
                width: 38,
                height: 6,
                decoration: BoxDecoration(
                    color: const Color(0xffffbc07),
                    borderRadius: BorderRadius.circular(100)),
              ),
              const AppTextStyle(
                  text: 'Feedback',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor),
              Container(
                margin: EdgeInsets.only(
                    bottom: getHeight(context) * .032,
                    top: getHeight(context) * .02),
                alignment: Alignment.topCenter,
                height: 20,
                width: getWidth(context) * .35,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star_rounded,
                      color: AppColors.primaryDark,
                    );
                  },
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeedBackOption(text: "Poor", selected: true),
                  FeedBackOption(text: "Neutral", selected: false),
                  FeedBackOption(text: "Smooth and Safe", selected: false),
                  FeedBackOption(text: "Excellent", selected: false),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: getHeight(context) * .032,
                    bottom: getHeight(context) * .026),
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.7),
                    border:
                        Border.all(width: 2.6, color: const Color(0xff725b19))),
                child: TextFormField(
                  maxLines: 4,
                  style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18.11,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w300),
                  decoration: const InputDecoration(
                      hintText: 'Write your feedback',
                      hintStyle: TextStyle(
                          color: Color(0xff9ea5af),
                          fontSize: 18.11,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              const GestureContainer(
                text: "Submit",
                isNeedArrow: false,
                textColor: AppColors.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FeedBackOption extends StatelessWidget {
  const FeedBackOption({super.key, required this.text, required this.selected});
  final String text;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(top: 9, bottom: 9, left: 7, right: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.58),
          border: Border.all(
              width: 1,
              color: selected == true
                  ? AppColors.primaryDark
                  : AppColors.borderColor)),
      child: AppTextStyle(
          text: text,
          fontSize: 11.34,
          fontWeight: FontWeight.w500,
          color:
              selected == true ? AppColors.primaryDark : AppColors.whiteColor),
    );
  }
}
