import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/helper/shared_prefs_helper.dart';
import 'package:hikespot/helper/warning_helper.dart';
import '../models/auth-model/auth_model.dart';

abstract class AuthDataSource {
  Future<Either<String, AuthModel>> getSelfInfo(BuildContext context);
  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context,
      {required AuthModel authModel});
}

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl();

  @override
  Future<Either<String, AuthModel>> getSelfInfo(BuildContext context) async {
    try {
      String? localUserPrefs =
          await SharedPrefsHelper.getData(key: AppConstants.userKey);
      if (localUserPrefs?.isNotEmpty ?? false) {
        Map<String, dynamic>? userData = jsonDecode(localUserPrefs!);
        AuthModel? authModel =
            AuthModel.fromJson(userData ?? <String, dynamic>{});
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection("users")
            .doc(authModel.uid)
            .get();

        if (snapshot.data()!["appStatus"] == "captain") {
          authModel = AuthModel.fromJson(snapshot.data()!);
          print("update captain${authModel.appStatus}");
          print("update captain${snapshot.data()!["appStatus"]}");
        } else {
          authModel = AuthModel.fromJson(snapshot.data()!);
        }
        return Right(authModel);
      } else {
        return const Left(AppConstants.userNotFound);
      }
    } catch (e) {
      log('auth-datasource-error: ${e.toString()}');
      // ✅ Return descriptive error instead of showing toast here
      // Let the presentation layer (BLoC/Cubit) decide when to show UI feedback
      return Left('Failed to fetch user data: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context,
      {required AuthModel authModel}) async {
    try {
      // ✅ Save to local storage
      await SharedPrefsHelper.setData(
          data: jsonEncode(authModel), key: AppConstants.userKey);
      
      // ✅ FIXED: Manually convert nested objects to JSON to avoid serialization issues
      Map<String, dynamic> updateData = authModel.toJson();
      
      // ✅ Ensure nested driverModel is properly converted to JSON
      if (updateData['driverModel'] != null && updateData['driverModel'] is! Map) {
        updateData['driverModel'] = authModel.driverModel.toJson();
      }
      
      // ✅ Ensure nested cardModel list is properly converted to JSON
      if (updateData['cardModel'] != null && updateData['cardModel'] is List) {
        updateData['cardModel'] = (authModel.cardModel as List)
            .map((card) => card.toJson())
            .toList();
      }
      
      // ✅ Update in Firebase with properly serialized data
      await AppConstants.firestore
          .collection(AppConstants.usersKey)
          .doc(authModel.uid)
          .update(updateData);
      
      return Right(authModel);
    } catch (e) {
      log('auth-update-error: ${e.toString()}');
      // ✅ Return descriptive error instead of showing toast
      return Left('Failed to update user info: ${e.toString()}');
    }
  }
}