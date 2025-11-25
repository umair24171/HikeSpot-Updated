import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/helper/connectivity_helper.dart';

Future<String> uploadStorage(
  File file, {
  String foldername = AppConstants.imageKey,
}) async {
  final AuthCubit authCubit = Di().sl<AuthCubit>();
  try {
    // ✅ Check internet connectivity first
    bool hasConnection = await ConnectivityHelper.hasInternetConnection();
    if (!hasConnection) {
      log('hk-storage: No internet connection');
      return "NO_CONNECTION";
    }

    // ✅ Validate file exists
    if (!file.existsSync()) {
      log('hk-storage: File does not exist');
      return "FILE_NOT_FOUND";
    }

    // ✅ Validate user is authenticated
    if (authCubit.authData.uid.isEmpty) {
      log('hk-storage: User not authenticated');
      return "NOT_AUTHENTICATED";
    }

    // Getting image file extension
    final ext = file.path.split('.').last;

    // Storage file ref with path
    final ref = AppConstants.storage
        .ref()
        .child('$foldername/${authCubit.authData.uid}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    // Uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    
    // Updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    log('hk-storage: Upload successful - $imageUrl');
    return imageUrl;
  } catch (e) {
    log("hk-storage-error: ${e.toString()}");
    return "";
  }
}

Future<void> deleteStorage(String url) async {
  try {
    // ✅ CRITICAL FIX: Validate URL before attempting delete
    if (url.isEmpty) {
      log('hk-storage: Cannot delete - URL is empty');
      return;
    }

    // ✅ Validate URL format
    if (!url.startsWith('gs://') && !url.startsWith('http')) {
      log('hk-storage: Cannot delete - Invalid URL format: $url');
      return;
    }

    // ✅ Only delete if it's a Firebase Storage URL
    if (!url.contains('firebasestorage.googleapis.com')) {
      log('hk-storage: Cannot delete - Not a Firebase Storage URL: $url');
      return;
    }

    final ref = AppConstants.storage.refFromURL(url);
    await ref.delete();
    log('hk-storage: Successfully deleted old image');
  } catch (e) {
    log("hk-storage-delete-error: ${e.toString()}");
    // Don't throw error, just log it - deletion failures shouldn't block profile updates
  }
}