import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/utils/enums.dart';

import '../../../../home/data/model/ride/ride_data_model.dart';
import '../../../domain/usecase/get_rides_list_usecase.dart';

part '../state/get_rides_list_state.dart';

class GetRidesListCubit extends Cubit<GetRidesListState> {
  final GetRidesListUsecase getRidesListUsecase;
  GetRidesListCubit(this.getRidesListUsecase) : super(GetRidesListInitial());

  List<RideDataModel> rides = [];
  List<RideDataModel> scheduledRides = [];
  String historyMonth = "";
  StreamSubscription? ridesSubscription;
  final ScrollController scrollController = ScrollController();

  void getRidesList() async {
    emit(GetRidesListLoading());
    ridesSubscription = getRidesListUsecase.getRidesList().listen((ridesList) {
      ridesList.docs.map((doc) {
        rides.add(RideDataModel.fromJson(doc.data()));
      }).toList();
      rides.sort((a, b) => a.rideDate.compareTo(b.rideDate));
      getScheduledRides();
      if(rides.isNotEmpty){
        _getMonthFromRide(rides[0].rideDate);
        scrollController.addListener(onScroll);
      }
      emit(GetRidesListLoaded());
    });
  }

  // add a new ride to the list
  void addRide(RideDataModel ride) {
    rides.add(ride);
    emit(GetRidesListLoaded());
  }

  // history month filter
  void filterRidesByMonth(String month) {
    emit(GetRidesListLoading());
    historyMonth = month;
    emit(GetRidesListLoaded());
  }

  void onScroll() {
    if (rides.isEmpty) return;
    for (int i = 0; i < rides.length; i++) {
      var ride = rides[i];
      double itemPositionOffset = i * 100.0;
      double currentPosition = scrollController.offset;
      if (currentPosition >= itemPositionOffset &&
          currentPosition < itemPositionOffset + 100.0) {
        String rideMonth = _getMonthFromRide(ride.rideDate);
        if (rideMonth != historyMonth) {
          filterRidesByMonth(rideMonth);
        }
        break;
      }
    }
  }

  String _getMonthFromRide(String rideDate) {
    DateTime date = DateTime.parse(rideDate);
    return _getMonthName(date.month);
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  /// get the scheduled rides
  void getScheduledRides() {
    emit(GetRidesListLoading());
    scheduledRides = rides
        .where((element) => element.rideStatus == RideStatus.Scheduled.name)
        .toList();
    scheduledRides.sort((a, b) => a.rideDate.compareTo(b.rideDate));
    emit(GetRidesListLoaded());
  }
}
