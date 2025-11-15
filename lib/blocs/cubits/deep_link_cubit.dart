import 'dart:developer';

// import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/domain/usecase/deep_link_usecase.dart';
import 'package:hikespot/helper/warning_helper.dart';
import 'package:share_plus/share_plus.dart';
part '../states/deep_link_state.dart';

class DeepLinkCubit extends Cubit<DeepLinkState> {
  final DeepLinkUsecase _usecase;
  DeepLinkCubit(this._usecase) : super(DeepLinkInitial());
  // final appLinks = AppLinks();

  Future<void> createReferDeepLink(context) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    String referalCode = authCubit.authData.referCode;
    var result = await _usecase.createDeepLink("/refer", referalCode);
    result.fold((l) {
      WarningHelper.showToast(context,
          message: "Error while creating refer link please try again later");
    }, (r) async {
      Uri uri = Uri.parse(r);
      await Share.shareUri(uri);
      await Clipboard.setData(r);
    });
  }

  // handel refer code
  Future<void> checkInitialDeepLink(context) async {
    try {
      // final initialUri = await appLinks.getInitialLink();
      // if (initialUri != null) {
      //   _usecase.handleDeepLink(initialUri, context);
      // } else {
      //   log("no link found");
      // }
    } catch (e) {
      log("Error getting initial deep link: $e");
    }
  }

  // build link 
  Future<void> buildLink() async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    String referalCode = authCubit.authData.referCode;
    Uri uri = Uri(
      scheme: 'https',
      host: 'hikespottaxi.page.link',
      fragment: "refer",
      queryParameters: {
        'code': referalCode,
      },
    );
    await Share.shareUri(uri);
  }
}
