import 'package:dio/dio.dart';
import 'package:hikespot/app/constants/links.dart';

import 'app_constants.dart';

BaseOptions baseOptions() {
  return BaseOptions(
    baseUrl: AppLinks.onesignalBaseUrl,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Basic ${AppConstants.oneSignalRestApiKey}',
    },
  );
}
