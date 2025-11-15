// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i37;
import 'package:flutter/material.dart' as _i38;
import 'package:hikespot/pages/activities/presentation/page/activities_page.dart'
    as _i1;
import 'package:hikespot/pages/addcard/presentation/page/add_card_page.dart'
    as _i2;
import 'package:hikespot/pages/addcard/presentation/page/add_money_page.dart'
    as _i3;
import 'package:hikespot/pages/captain-doc/presentation/page/captain_upload_licence_page.dart'
    as _i8;
import 'package:hikespot/pages/captain-doc/presentation/page/captain_upload_profile_page.dart'
    as _i9;
import 'package:hikespot/pages/captain-doc/presentation/page/captain_upload_vehicle_doc_page.dart'
    as _i11;
import 'package:hikespot/pages/captain-service/presentation/page/captain_service_page.dart'
    as _i6;
import 'package:hikespot/pages/captain-service/presentation/page/captain_upload_doc_page.dart'
    as _i7;
import 'package:hikespot/pages/captain-service/presentation/page/captain_vehicle_information.dart'
    as _i10;
import 'package:hikespot/pages/captainregister/presentation/page/captain_getstarted_page.dart'
    as _i4;
import 'package:hikespot/pages/captainregister/presentation/page/captain_register_page.dart'
    as _i5;
import 'package:hikespot/pages/chats/presentation/page/chat_page.dart' as _i12;
import 'package:hikespot/pages/chats/presentation/page/user_chats_page.dart'
    as _i35;
import 'package:hikespot/pages/dashboard/presentation/page/dashboard_page.dart'
    as _i13;
import 'package:hikespot/pages/editprofile/presentation/page/edit_page.dart'
    as _i14;
import 'package:hikespot/pages/getstarted/get_started_page.dart' as _i15;
import 'package:hikespot/pages/home/presentation/page/home_page.dart' as _i17;
import 'package:hikespot/pages/login/presentation/page/login_page.dart' as _i18;
import 'package:hikespot/pages/map/page/map_page.dart' as _i19;
import 'package:hikespot/pages/notification/presentation/page/notification_page.dart'
    as _i20;
import 'package:hikespot/pages/onboarding/presentation/page/on_boarding_page.dart'
    as _i21;
import 'package:hikespot/pages/otp/presentation/page/otp_page.dart' as _i22;
import 'package:hikespot/pages/payment/presentation/page/payment_page.dart'
    as _i23;
import 'package:hikespot/pages/profile/presentation/page/profile_page.dart'
    as _i24;
import 'package:hikespot/pages/realease-payment/presentation/page/realease_payment_page.dart'
    as _i26;
import 'package:hikespot/pages/refer/presentation/page/refer_page.dart' as _i25;
import 'package:hikespot/pages/safety/presentation/page/guide_page.dart'
    as _i16;
import 'package:hikespot/pages/safety/presentation/page/saftey_page.dart'
    as _i27;
import 'package:hikespot/pages/safety/presentation/page/saftey_tips_guide.dart'
    as _i28;
import 'package:hikespot/pages/schedule/presentation/page/schedule_page.dart'
    as _i30;
import 'package:hikespot/pages/schedule/presentation/widgets/schedule_list.dart'
    as _i29;
import 'package:hikespot/pages/splash/splash_page.dart' as _i31;
import 'package:hikespot/pages/switch-page/switch_page.dart' as _i32;
import 'package:hikespot/pages/upload/presentation/page/upload_id_page.dart'
    as _i33;
import 'package:hikespot/pages/upload/presentation/page/upload_profile_page.dart'
    as _i34;
import 'package:hikespot/pages/verified/presentation/page/account_verified_page.dart'
    as _i36;
import 'package:hikespot/utils/enums.dart' as _i39;

abstract class $AppRouter extends _i37.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i37.PageFactory> pagesMap = {
    ActivitiesPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ActivitiesPage(),
      );
    },
    AddCardPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddCardPage(),
      );
    },
    AddMoneyPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddMoneyPage(),
      );
    },
    CaptainGetStartedPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CaptainGetStartedPage(),
      );
    },
    CaptainRegisterPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CaptainRegisterPage(),
      );
    },
    CaptainServicePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CaptainServicePage(),
      );
    },
    CaptainUploadDocPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CaptainUploadDocPage(),
      );
    },
    CaptainUploadLicencePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CaptainUploadLicencePage(),
      );
    },
    CaptainUploadProfilePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CaptainUploadProfilePage(),
      );
    },
    CaptainVehicleInfoPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.CaptainVehicleInfoPage(),
      );
    },
    CaptainVehicleUploadDocPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.CaptainVehicleUploadDocPage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ChatPage(),
      );
    },
    DashBoardPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.DashBoardPage(),
      );
    },
    EditPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.EditPage(),
      );
    },
    GetStartedPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.GetStartedPage(),
      );
    },
    GuidePageRoute.name: (routeData) {
      final args = routeData.argsAs<GuidePageRouteArgs>();
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.GuidePage(
          key: args.key,
          isRiderTips: args.isRiderTips,
        ),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.HomePage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.LoginPage(),
      );
    },
    MapPageRoute.name: (routeData) {
      final args = routeData.argsAs<MapPageRouteArgs>(
          orElse: () => const MapPageRouteArgs());
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.MapPage(key: args.key),
      );
    },
    NotificationPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.NotificationPage(),
      );
    },
    OnBoardingPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.OnBoardingPage(),
      );
    },
    OtpPageRoute.name: (routeData) {
      final args = routeData.argsAs<OtpPageRouteArgs>();
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.OtpPage(
          key: args.key,
          state: args.state,
        ),
      );
    },
    PaymentPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.PaymentPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.ProfilePage(),
      );
    },
    ReferPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.ReferPage(),
      );
    },
    ReleasePaymentRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.ReleasePayment(),
      );
    },
    SafetyPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.SafetyPage(),
      );
    },
    SafteyGuideTipsPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.SafteyGuideTipsPage(),
      );
    },
    ScheduleListRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.ScheduleList(),
      );
    },
    SchedulePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.SchedulePage(),
      );
    },
    SplashPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.SplashPage(),
      );
    },
    SwitchPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.SwitchPage(),
      );
    },
    UploadIdPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.UploadIdPage(),
      );
    },
    UploadProfilePageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.UploadProfilePage(),
      );
    },
    UserChatsPageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.UserChatsPage(),
      );
    },
    VerifiedPageRoute.name: (routeData) {
      final args = routeData.argsAs<VerifiedPageRouteArgs>();
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i36.VerifiedPage(
          key: args.key,
          user: args.user,
          heading: args.heading,
          needButton: args.needButton,
          subHeading: args.subHeading,
          onTap: args.onTap,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActivitiesPage]
class ActivitiesPageRoute extends _i37.PageRouteInfo<void> {
  const ActivitiesPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ActivitiesPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActivitiesPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddCardPage]
class AddCardPageRoute extends _i37.PageRouteInfo<void> {
  const AddCardPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          AddCardPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCardPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddMoneyPage]
class AddMoneyPageRoute extends _i37.PageRouteInfo<void> {
  const AddMoneyPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          AddMoneyPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMoneyPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CaptainGetStartedPage]
class CaptainGetStartedPageRoute extends _i37.PageRouteInfo<void> {
  const CaptainGetStartedPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainGetStartedPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainGetStartedPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CaptainRegisterPage]
class CaptainRegisterPageRoute extends _i37.PageRouteInfo<void> {
  const CaptainRegisterPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainRegisterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainRegisterPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CaptainServicePage]
class CaptainServicePageRoute extends _i37.PageRouteInfo<void> {
  const CaptainServicePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainServicePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainServicePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CaptainUploadDocPage]
class CaptainUploadDocPageRoute extends _i37.PageRouteInfo<void> {
  const CaptainUploadDocPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainUploadDocPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainUploadDocPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CaptainUploadLicencePage]
class CaptainUploadLicencePageRoute extends _i37.PageRouteInfo<void> {
  const CaptainUploadLicencePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainUploadLicencePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainUploadLicencePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CaptainUploadProfilePage]
class CaptainUploadProfilePageRoute extends _i37.PageRouteInfo<void> {
  const CaptainUploadProfilePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainUploadProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainUploadProfilePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i10.CaptainVehicleInfoPage]
class CaptainVehicleInfoPageRoute extends _i37.PageRouteInfo<void> {
  const CaptainVehicleInfoPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainVehicleInfoPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainVehicleInfoPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i11.CaptainVehicleUploadDocPage]
class CaptainVehicleUploadDocPageRoute extends _i37.PageRouteInfo<void> {
  const CaptainVehicleUploadDocPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          CaptainVehicleUploadDocPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaptainVehicleUploadDocPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ChatPage]
class ChatPageRoute extends _i37.PageRouteInfo<void> {
  const ChatPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ChatPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i13.DashBoardPage]
class DashBoardPageRoute extends _i37.PageRouteInfo<void> {
  const DashBoardPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          DashBoardPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i14.EditPage]
class EditPageRoute extends _i37.PageRouteInfo<void> {
  const EditPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          EditPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i15.GetStartedPage]
class GetStartedPageRoute extends _i37.PageRouteInfo<void> {
  const GetStartedPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          GetStartedPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i16.GuidePage]
class GuidePageRoute extends _i37.PageRouteInfo<GuidePageRouteArgs> {
  GuidePageRoute({
    _i38.Key? key,
    required bool isRiderTips,
    List<_i37.PageRouteInfo>? children,
  }) : super(
          GuidePageRoute.name,
          args: GuidePageRouteArgs(
            key: key,
            isRiderTips: isRiderTips,
          ),
          initialChildren: children,
        );

  static const String name = 'GuidePageRoute';

  static const _i37.PageInfo<GuidePageRouteArgs> page =
      _i37.PageInfo<GuidePageRouteArgs>(name);
}

class GuidePageRouteArgs {
  const GuidePageRouteArgs({
    this.key,
    required this.isRiderTips,
  });

  final _i38.Key? key;

  final bool isRiderTips;

  @override
  String toString() {
    return 'GuidePageRouteArgs{key: $key, isRiderTips: $isRiderTips}';
  }
}

/// generated route for
/// [_i17.HomePage]
class HomePageRoute extends _i37.PageRouteInfo<void> {
  const HomePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i18.LoginPage]
class LoginPageRoute extends _i37.PageRouteInfo<void> {
  const LoginPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i19.MapPage]
class MapPageRoute extends _i37.PageRouteInfo<MapPageRouteArgs> {
  MapPageRoute({
    _i38.Key? key,
    List<_i37.PageRouteInfo>? children,
  }) : super(
          MapPageRoute.name,
          args: MapPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MapPageRoute';

  static const _i37.PageInfo<MapPageRouteArgs> page =
      _i37.PageInfo<MapPageRouteArgs>(name);
}

class MapPageRouteArgs {
  const MapPageRouteArgs({this.key});

  final _i38.Key? key;

  @override
  String toString() {
    return 'MapPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.NotificationPage]
class NotificationPageRoute extends _i37.PageRouteInfo<void> {
  const NotificationPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          NotificationPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i21.OnBoardingPage]
class OnBoardingPageRoute extends _i37.PageRouteInfo<void> {
  const OnBoardingPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          OnBoardingPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i22.OtpPage]
class OtpPageRoute extends _i37.PageRouteInfo<OtpPageRouteArgs> {
  OtpPageRoute({
    _i38.Key? key,
    required _i39.AppState state,
    List<_i37.PageRouteInfo>? children,
  }) : super(
          OtpPageRoute.name,
          args: OtpPageRouteArgs(
            key: key,
            state: state,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpPageRoute';

  static const _i37.PageInfo<OtpPageRouteArgs> page =
      _i37.PageInfo<OtpPageRouteArgs>(name);
}

class OtpPageRouteArgs {
  const OtpPageRouteArgs({
    this.key,
    required this.state,
  });

  final _i38.Key? key;

  final _i39.AppState state;

  @override
  String toString() {
    return 'OtpPageRouteArgs{key: $key, state: $state}';
  }
}

/// generated route for
/// [_i23.PaymentPage]
class PaymentPageRoute extends _i37.PageRouteInfo<void> {
  const PaymentPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          PaymentPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i24.ProfilePage]
class ProfilePageRoute extends _i37.PageRouteInfo<void> {
  const ProfilePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i25.ReferPage]
class ReferPageRoute extends _i37.PageRouteInfo<void> {
  const ReferPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ReferPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReferPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i26.ReleasePayment]
class ReleasePaymentRoute extends _i37.PageRouteInfo<void> {
  const ReleasePaymentRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ReleasePaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReleasePaymentRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i27.SafetyPage]
class SafetyPageRoute extends _i37.PageRouteInfo<void> {
  const SafetyPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SafetyPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SafetyPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i28.SafteyGuideTipsPage]
class SafteyGuideTipsPageRoute extends _i37.PageRouteInfo<void> {
  const SafteyGuideTipsPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SafteyGuideTipsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SafteyGuideTipsPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i29.ScheduleList]
class ScheduleListRoute extends _i37.PageRouteInfo<void> {
  const ScheduleListRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ScheduleListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScheduleListRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i30.SchedulePage]
class SchedulePageRoute extends _i37.PageRouteInfo<void> {
  const SchedulePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SchedulePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SchedulePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i31.SplashPage]
class SplashPageRoute extends _i37.PageRouteInfo<void> {
  const SplashPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SplashPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i32.SwitchPage]
class SwitchPageRoute extends _i37.PageRouteInfo<void> {
  const SwitchPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SwitchPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SwitchPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i33.UploadIdPage]
class UploadIdPageRoute extends _i37.PageRouteInfo<void> {
  const UploadIdPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          UploadIdPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UploadIdPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i34.UploadProfilePage]
class UploadProfilePageRoute extends _i37.PageRouteInfo<void> {
  const UploadProfilePageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          UploadProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UploadProfilePageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i35.UserChatsPage]
class UserChatsPageRoute extends _i37.PageRouteInfo<void> {
  const UserChatsPageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          UserChatsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserChatsPageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i36.VerifiedPage]
class VerifiedPageRoute extends _i37.PageRouteInfo<VerifiedPageRouteArgs> {
  VerifiedPageRoute({
    _i38.Key? key,
    required _i39.NewUser user,
    required String heading,
    bool needButton = true,
    required String subHeading,
    dynamic Function()? onTap,
    List<_i37.PageRouteInfo>? children,
  }) : super(
          VerifiedPageRoute.name,
          args: VerifiedPageRouteArgs(
            key: key,
            user: user,
            heading: heading,
            needButton: needButton,
            subHeading: subHeading,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifiedPageRoute';

  static const _i37.PageInfo<VerifiedPageRouteArgs> page =
      _i37.PageInfo<VerifiedPageRouteArgs>(name);
}

class VerifiedPageRouteArgs {
  const VerifiedPageRouteArgs({
    this.key,
    required this.user,
    required this.heading,
    this.needButton = true,
    required this.subHeading,
    this.onTap,
  });

  final _i38.Key? key;

  final _i39.NewUser user;

  final String heading;

  final bool needButton;

  final String subHeading;

  final dynamic Function()? onTap;

  @override
  String toString() {
    return 'VerifiedPageRouteArgs{key: $key, user: $user, heading: $heading, needButton: $needButton, subHeading: $subHeading, onTap: $onTap}';
  }
}
