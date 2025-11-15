import 'package:flutter/material.dart';
import 'package:hikespot/app/my_app.dart';
import 'package:hikespot/core/initialization/initialize.dart';


void main() async {
  await AppInit().init();
  runApp(MyApp());
}

/// 90% driver
/// 10% admin 
/// if the user want to schedule the ride the driver will also select the time and date and also the user will select the time and date also while scheduling the ride user will select about the car services 
/// if the driver is not verified the driver will not be able to enter in the app
/// cash , card , wallet 
/// same colour polylines
/// same id for chat support 
/// send notification to web and get back 
/// show the rides accroding to services and also the drivers accroding to their car service 
/// 