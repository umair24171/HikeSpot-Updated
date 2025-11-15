import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  @override
  void initState() {
   Future.delayed(const Duration(seconds: 2), () {
      _authCubit.checkInitialDeepLink(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(
          AppImages.splashImg,
          height: 346,
          width: getWidth(context),
        ),
      ),
    );
  }
}
