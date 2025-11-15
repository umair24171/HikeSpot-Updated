import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: getHeight(context) * 0.78,
      // width: getWidth(context),
      child: ListView.builder(
        itemCount: 10, 
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.secContainerColor.withOpacity(0.4),
                  highlightColor: AppColors.primaryGreyColor.withOpacity(0.7),
                  child: const CircleAvatar(
                    radius: 24.0,
                    backgroundColor: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: AppColors.secContainerColor.withOpacity(0.4),
                  highlightColor: AppColors.primaryGreyColor.withOpacity(0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 14.0,
                           decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
