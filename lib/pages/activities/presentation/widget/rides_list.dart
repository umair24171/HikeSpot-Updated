import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/activities/presentation/bloc/cubit/get_rides_list_cubit.dart';

import '../../../../utils/enums.dart';
import 'activity_widget.dart';

class RidesList extends StatelessWidget {
  const RidesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _getRidesListCubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            controller: _getRidesListCubit.scrollController,
            itemCount: _getRidesListCubit.rides.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var rideDataModel = _getRidesListCubit.rides[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ActivityWidget(
                  containerType: ContainerType.activities,
                  rideData: rideDataModel,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

final GetRidesListCubit _getRidesListCubit = Di().sl<GetRidesListCubit>();
