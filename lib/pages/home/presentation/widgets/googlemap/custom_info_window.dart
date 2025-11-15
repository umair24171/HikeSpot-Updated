
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';

import '../../../../../core/di/service_locator_imports.dart';

class UserCustomInfo extends StatelessWidget {
  const UserCustomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _googleMapCubit,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: AppTextStyle(
                          text: "${_googleMapCubit.address?.locality}, ${_googleMapCubit.address?.subLocality}, ${_googleMapCubit.address?.thoroughfare}",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}

final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
