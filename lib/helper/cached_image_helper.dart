import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/utils/app_colors.dart';
import '../utils/images_paths.dart';

class CachedImageHelper extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const CachedImageHelper(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context, url) => Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
                height: height,
                width: width,
                color: AppColors.whiteColor,
                child: Image.asset(AppImages.appLogoPng)),
          ),
        ),
      ),
    ));
  }
}
