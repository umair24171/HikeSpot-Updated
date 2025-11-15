import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';

import '../../../../core/di/service_locator_imports.dart';

abstract class GetRidesListDatasource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesList();
}

class GetRidesListDatasourceImpl implements GetRidesListDatasource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesList() {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    try {
      var stream = AppConstants.firestore
          .collection(AppConstants.ridesKey)
          .where("userId", isEqualTo: authCubit.authData.uid)
          .snapshots();
      return stream;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
