import 'package:flutter/material.dart';
import 'package:hikespot/routes/routes_imports.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Hike Spot Taxi",
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
