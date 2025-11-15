import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppConstants {
  // Firebase instance
  static final firestore = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;
  static final auth = FirebaseAuth.instance;
  static User? get user => auth.currentUser;

  // Collection names
  static const String usersKey = "users";
  static const String chatsKey = "chats";
  static const String messagesKey = "messages";
  static const String ridesKey = "rides";
  static const String ridesRequest = "ridesRequest";

  // paths extension
  static const String imageKey = "image";
  static const String videoKey = "video";
  static const String filesKey = "file";

  /// user getting errors ext
  static const String userNotFound = "userNotFound";
  static const String userError = "userError";
  static const String userExists = "userExists";

  /// local storage keys
  static const String userKey = "user-key-data";

  /// user storage foldernames
  static const String profileKey = "profiles";
  static const String chatKey = "chats";
  static const String messageKey = "messages";
  static const String carRegistrationImages = "carRegistrationImages";
  static const String drivingLicence = "drivingLicence";

  /// constants app keys or api keys
  static const String googleMapApiKey =
      "AIzaSyAqsjlnsVFsSygWPsO0ebpVj0w4a2vsFpc";
  static const String oneSignalRestApiKey =
      'MDE0NDc1YzgtMGFiNy00YjdhLWExMjItMDlmZWU4MTBhOTQ1';

  // app channel ids
  static const String messagesChannelId = 'messages';
  static const String ridesChannelId = 'rides';
  static const String chatsChannelId = 'chats';
  static const String promotionsChannelId = 'promotions';
  static const String paymentChannelId = 'payment';
} 
