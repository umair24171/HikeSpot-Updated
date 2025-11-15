import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';

import '../../../../../helper/dialouge_helper.dart';
import '../../../../../utils/enums.dart';
import '../../../../../widgets/confirm_dialoge.dart';

part '../state/schedule_ride_state.dart';

class ScheduleRideCubit extends Cubit<ScheduleRideState> {
  ScheduleRideCubit() : super(ScheduleRideInitial());

  TimeOfDay? selectedTime;
  DateTime? selectedDate = DateTime.now();

  // open time of day picker
  openTimeOfDayPicker(context) async {
    emit(ScheduleRideLoading());
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    // Only call getRideTime if we have a selected time
    if (selectedTime != null) {
      // Set date first if not set
      final createRideCubit = Di().sl<CreateRideCubit>();
      if (createRideCubit.rideDate == null && selectedDate != null) {
        createRideCubit.getRideDate(selectedDate!);
      }
      // Now safely call getRideTime
      createRideCubit.getRideTime(selectedTime!);
    }
    
    emit(ScheduleRideSuccess());
  }

  // open date picker
  openDatePicker(context) async {
    emit(ScheduleRideLoading());
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    
    // Only call getRideDate if we have a selected date
    if (selectedDate != null) {
      Di().sl<CreateRideCubit>().getRideDate(selectedDate!);
    }
    
    emit(ScheduleRideSuccess());
  }

  //schedule ride
  scheduleRide(context) {
    emit(ScheduleRideLoading());
    final createRideCubit = Di().sl<CreateRideCubit>();
    
    if (selectedDate != null && selectedTime != null) {
      createRideCubit.changeRideStatus(RideStatus.Scheduled);
      createRideCubit.createRide(context).then(
        (value) {
          value.fold((l) {
            log(l.toString());
            // Use ScaffoldMessenger instead of WarningHelper
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l))
            );
          }, (r) {
            DialogHelper.showNormalDialog(
                context: context,
                dialog: ConfirmDialoge(
                  buttonText: "View Schedule List",
                  heading: "Confirmed Pickup",
                  subHeading:
                      "Now your schedule pickup time is confirmed. \nYou can enjoy your time.",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ));
          });
        },
      );
    } else {
      // Use ScaffoldMessenger instead of WarningHelper
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time"))
      );
    }
    emit(ScheduleRideSuccess());
  }
}