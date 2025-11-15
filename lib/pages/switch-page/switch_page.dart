import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/screen_sizes.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/menue_cubit.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final MenueCubit _menueCubit = Di().sl<MenueCubit>();
  changeState() async {
    _menueCubit.changeIndex(0);
    if (_menueCubit.userState == AppState.captain) {
      _menueCubit.changeState(AppState.user,context);
    } else {
      _menueCubit.changeState(AppState.captain,context);
    }
    Future.delayed(const Duration(milliseconds: 4500), () {
      AutoRouter.of(context).pushAndPopUntil(const DashBoardPageRoute(),
          predicate: (route) => false);
    });
  }

  @override
  void initState() {
    changeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.containerColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Card(
              color: AppColors.secContainerColor,
              elevation: 10,
              shadowColor: AppColors.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: getHeight(context),
                width: getWidth(context),
                decoration: BoxDecoration(
                  color: AppColors.secContainerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(AppImages.loadingAnim,
                        height: 100, width: 100),
                    const SizedBox(height: 20),
                    const AppTextStyle(
                        text: "Please While Changing Your\n Account",
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
