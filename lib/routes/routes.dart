part of './routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<CustomRoute> get routes => [
        CustomRoute(
            page: SplashPageRoute.page,
            initial: true,
            path: '/',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: GetStartedPageRoute.page,
            path: '/get-started',
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: OnBoardingPageRoute.page,
            durationInMilliseconds: 200,
            path: '/onboarding',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: LoginPageRoute.page,
            durationInMilliseconds: 200,
            path: '/login',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: OtpPageRoute.page,
            durationInMilliseconds: 200,
            path: '/otp',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: VerifiedPageRoute.page,
            durationInMilliseconds: 200,
            path: '/verified',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: UploadProfilePageRoute.page,
            path: '/upload-profile',
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: UploadIdPageRoute.page,
            path: '/upload-id',
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: HomePageRoute.page,
            path: '/home',
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: DashBoardPageRoute.page,
            path: '/dashboard',
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ActivitiesPageRoute.page,
            durationInMilliseconds: 200,
            path: '/activities',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SchedulePageRoute.page,
            durationInMilliseconds: 200,
            path: '/schedule',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ScheduleListRoute.page,
            durationInMilliseconds: 200,
            path: '/schedule-list',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: UserChatsPageRoute.page,
            durationInMilliseconds: 200,
            path: '/user-chats',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ChatPageRoute.page,
            durationInMilliseconds: 200,
            path: '/chat-page',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ProfilePageRoute.page,
            durationInMilliseconds: 200,
            path: '/profile',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: EditPageRoute.page,
            durationInMilliseconds: 200,
            path: '/edit-profile',
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: PaymentPageRoute.page,
            durationInMilliseconds: 200,
            path: "/payment",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: AddCardPageRoute.page,
            durationInMilliseconds: 200,
            path: "/add-card",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: AddMoneyPageRoute.page,
            durationInMilliseconds: 200,
            path: "/add-money",
            transitionsBuilder: TransitionsBuilders.fadeIn),
            // captain routes
        CustomRoute(
            page: CaptainRegisterPageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-register",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainServicePageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-service",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainVehicleInfoPageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-vehicle-info",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainUploadDocPageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-upload-doc",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainUploadProfilePageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-upload-profile",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainVehicleUploadDocPageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-vehicle-upload-doc",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainUploadLicencePageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-upload-licence",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: CaptainGetStartedPageRoute.page,
            durationInMilliseconds: 200,
            path: "/captain-get-started",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: NotificationPageRoute.page,
            durationInMilliseconds: 200,
            path: "/notification",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SafetyPageRoute.page,
            durationInMilliseconds: 200,
            path: "/safety",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SafteyGuideTipsPageRoute.page,
            durationInMilliseconds: 200,
            path: "/safety-guide-tips",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: GuidePageRoute.page,
            durationInMilliseconds: 200,
            path: "/guide",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ReferPageRoute.page,
            path: "/refer",
            durationInMilliseconds: 200,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ReleasePaymentRoute.page,
            durationInMilliseconds: 200,
            path: "/release-payment",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: SwitchPageRoute.page,
            durationInMilliseconds: 200,
            path: "/switch-page",
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: MapPageRoute.page,
            durationInMilliseconds: 200,
            path: "/map",
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
