import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hikespot/blocs/cubits/send_notification_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/server/firebase_options.dart';

class AppInit {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Di().setup();
    await _createChannels();
  }
}



// create channels
Future<void> _createChannels() async {
  final SendNotificationCubit sendNotificationCubit =
      Di().sl<SendNotificationCubit>();
  await sendNotificationCubit.initOneSignal();
  await sendNotificationCubit.createNotificationChannels();
}
