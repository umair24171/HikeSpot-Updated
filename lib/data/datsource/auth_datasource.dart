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
      WarningHelper.showToast(context,
          message: "Please Check your internet connection and try again");
      log(e.toString());
      return const Left(AppConstants.userError);
    }
  }

  @override
  Future<Either<String, AuthModel>> updateUserInfo(BuildContext context,
      {required AuthModel authModel}) async {
    try {
      // ✅ Save to local storage
      await SharedPrefsHelper.setData(
          data: jsonEncode(authModel), key: AppConstants.userKey);
      
      // ✅ FIXED: Update ALL fields in Firebase, not just location
      await AppConstants.firestore
          .collection(AppConstants.usersKey)
          .doc(authModel.uid)
          .update(authModel.toJson()); // ✅ Use toJson() to update everything
      
      return Right(authModel);
    } catch (e) {
      WarningHelper.showToast(context,
          message: "Please Check your internet connection and try again");
      log(e.toString());
      return const Left(AppConstants.userError);
    }
  }
}