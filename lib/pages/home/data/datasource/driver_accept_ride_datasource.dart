import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/pages/home/data/model/accept-ride/accept_ride_model.dart';

abstract class DriverAcceptRideDatasource {
  Future<Either<Exception, String>> driverAcceptRide(
    String rideId,
    AcceptRideModel acceptRideModel,
  );
}

class DriverAcceptRideDatasourceImpl extends DriverAcceptRideDatasource {
  @override
  Future<Either<Exception, String>> driverAcceptRide(
      String rideId, AcceptRideModel acceptRideModel) async {
    try {
      print("💾 ===== DATASOURCE START =====");
      print("💾 Ride ID: $rideId");
      print("💾 Driver ID: ${acceptRideModel.driverData.uid}");
      
      final docRef = AppConstants.firestore
          .collection(AppConstants.ridesKey)
          .doc(rideId)
          .collection(AppConstants.ridesRequest)
          .doc(acceptRideModel.driverData.uid);
      
      print("💾 Path: ${docRef.path}");
      
      // 🔥 NUCLEAR FIX: Manually convert EVERYTHING to primitives
      final driverJson = acceptRideModel.driverData.toJson();
      
      // 🔥 Force the nested driverModel to be a Map
      if (driverJson['driverModel'] != null) {
        if (driverJson['driverModel'] is! Map) {
          print("⚠️ Converting driverModel to Map...");
          driverJson['driverModel'] = acceptRideModel.driverData.driverModel.toJson();
          print("✅ driverModel is now: ${driverJson['driverModel'].runtimeType}");
        }
      }
      
      // 🔥 Also check cardModel if it exists
      if (driverJson['cardModel'] != null && driverJson['cardModel'] is List) {
        print("⚠️ Converting cardModel list...");
        driverJson['cardModel'] = (driverJson['cardModel'] as List)
            .map((card) => card is Map ? card : (card as dynamic).toJson())
            .toList();
      }
      
      print("💾 Final driverData type check:");
      print("💾 - driverData is Map: ${driverJson is Map}");
      print("💾 - driverModel type: ${driverJson['driverModel']?.runtimeType}");
      print("💾 - driverModel is Map: ${driverJson['driverModel'] is Map}");
      
      final data = {
        "driverData": driverJson, // 🔥 Now fully serialized
        "distance": acceptRideModel.distance,
        "duration": acceptRideModel.duration,
        "fare": acceptRideModel.fare,
        "isAccepted": acceptRideModel.isAccepted,
        "isRejected": acceptRideModel.isRejected,
        "rideId": acceptRideModel.rideId,
      };
      
      print("💾 Writing to Firestore...");
      await docRef.set(data);
      
      // Verify
      final verifyDoc = await docRef.get();
      if (verifyDoc.exists) {
        print("✅ VERIFIED: Document exists!");
      }
      
      print("✅ Datasource: Write successful!");
      print("💾 ===== DATASOURCE END =====");
      
      return right('Ride Request Sent Successfully');
      
    } on FirebaseException catch (e) {
      print("❌ FIREBASE ERROR: ${e.code} - ${e.message}");
      return left(Exception("Firebase error: ${e.message}"));
      
    } catch (e, stackTrace) {
      print("❌ DATASOURCE ERROR: $e");
      print("❌ Stack: $stackTrace");
      return left(Exception(e.toString()));
    }
  }
}