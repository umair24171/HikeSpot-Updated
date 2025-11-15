import 'dart:developer';

// import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hikespot/app/constants/links.dart' as appData;

import '../../routes/routes_imports.gr.dart';

abstract class DeepLinkDatasource {
  Future<Either<String, dynamic>> createDeepLink(String endPoint, String data);
  void handleDeepLink(Uri uri, context);
}

class DeepLinkDatasourceImpl extends DeepLinkDatasource {
  FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;
  // final appLinks = AppLinks();

  @override
  Future<Either<String, dynamic>> createDeepLink(
      String endPoint, String data) async {
    try {
      final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        uriPrefix: appData.AppLinks.baseUrl,
        link: Uri.parse('${appData.AppLinks.baseUrl}/${appData.AppLinks.referEndPoint}?code=$data'),
        androidParameters: const AndroidParameters(
          packageName: appData.AppLinks.bundleId,
          minimumVersion: 1,
        ),
        iosParameters: const IOSParameters(
          bundleId: appData.AppLinks.bundleId,
          minimumVersion: '1',
        ),

        navigationInfoParameters: const NavigationInfoParameters(
          forcedRedirectEnabled: true
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: "link",
          description: "Come to hike spot",
          imageUrl: Uri.parse(appData.AppLinks.appLogoUrl),
        ),
      );
      final shortLink = await links.buildShortLink(dynamicLinkParameters);
      return Right(shortLink.shortUrl.toString());
    } catch (e) {
      log("error while creating link $e");
      return Left(e.toString());
    }
  }

  @override
  void handleDeepLink(Uri uri, context) {
    if(uri.fragment == appData.AppLinks.referEndPoint){
      log("refer code: ${uri.queryParameters['code']}");
      AutoRouter.of(context).push(const ReferPageRoute());
    }
  }
}
