part of "./service_locator_imports.dart";

class Di {
  final sl = GetIt.I;

  Future<void> setup() async {
    // clients
    sl.registerLazySingleton<Dio>(
      () => Dio(baseOptions()),
    );

    // services
    sl.registerLazySingleton<EncryptionHelper>(() => EncryptionHelper(key, iv));
    sl.registerLazySingleton<NotificationHelper>(
      () => NotificationHelperImpl(sl()),
    );

    // cubits
    sl.registerLazySingleton<TextFieldCubit>(() => TextFieldCubit());
    sl.registerLazySingleton<GoogleMapCubit>(() => GoogleMapCubit());
    sl.registerLazySingleton<MenueCubit>(() => MenueCubit());
    sl.registerLazySingleton<RidingSectionCubit>(() => RidingSectionCubit());
    sl.registerLazySingleton<CaptainStepperCubit>(() => CaptainStepperCubit());
    sl.registerLazySingleton<LoginCreateCubit>(() => LoginCreateCubit(sl()));
    sl.registerLazySingleton<OtpVerifyCubit>(() => OtpVerifyCubit(sl()));
    sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
    sl.registerLazySingleton<ImagePickerCubit>(() => ImagePickerCubit(sl()));
    sl.registerLazySingleton<EditProfileCubit>(() => EditProfileCubit(sl()));
    sl.registerLazySingleton<SendMessageCubit>(() => SendMessageCubit(sl()));
    sl.registerLazySingleton<SendFileMessageCubit>(
        () => SendFileMessageCubit(sl()));
    sl.registerLazySingleton<GetChatsCubit>(() => GetChatsCubit(sl()));
    sl.registerLazySingleton<DeepLinkCubit>(
      () => DeepLinkCubit(sl()),
    );
    sl.registerLazySingleton<CreateCaptainRegisterCubit>(
      () => CreateCaptainRegisterCubit(sl()),
    );

    sl.registerLazySingleton<GetMessagesCubit>(
      () => GetMessagesCubit(sl()),
    );
    sl.registerLazySingleton<CreateRideCubit>(
      () => CreateRideCubit(sl()),
    );
    sl.registerLazySingleton<DriverRidesRequestsCubit>(
      () => DriverRidesRequestsCubit(sl()),
    );
    sl.registerLazySingleton<SendNotificationCubit>(
      () => SendNotificationCubit(sl()),
    );
    sl.registerLazySingleton<GetRidesListCubit>(
      () => GetRidesListCubit(sl()),
    );
    sl.registerLazySingleton<PaymentCubit>(
      () => PaymentCubit(),
    );
    sl.registerLazySingleton<ScheduleRideCubit>(
      () => ScheduleRideCubit(),
    );
    sl.registerLazySingleton<MapControllerCubit>(
      () => MapControllerCubit(),
    );
    

    // usecases
    sl.registerLazySingleton<LoginCreateUseCase>(
        () => LoginCreateUseCase(sl()));
    sl.registerLazySingleton<OtpVerifyUseCase>(() => OtpVerifyUseCase(sl()));
    sl.registerLazySingleton<AuthUseCase>(() => AuthUseCase(sl()));
    sl.registerLazySingleton<EditingProfileUsecase>(
        () => EditingProfileUsecase(sl()));
    sl.registerLazySingleton<SendMessageUsecase>(
        () => SendMessageUsecase(sl()));
    sl.registerLazySingleton<DeepLinkUsecase>(
      () => DeepLinkUsecase(sl()),
    );
    sl.registerLazySingleton<GetChatsUsecase>(
      () => GetChatsUsecase(sl()),
    );
    sl.registerLazySingleton<SendFileMessageUseCase>(
      () => SendFileMessageUseCase(sl()),
    );
    sl.registerLazySingleton<GetMessagesUsecase>(
      () => GetMessagesUsecase(sl()),
    );
    sl.registerLazySingleton<CreateRideUsecase>(
      () => CreateRideUsecase(sl()),
    );
    sl.registerLazySingleton<DriverAcceptRideUsecase>(
      () => DriverAcceptRideUsecase(sl()),
    );
    sl.registerLazySingleton<GetRidesListUsecase>(
      () => GetRidesListUsecase(sl()),
    );

    // repository
    sl.registerLazySingleton<LoginCreateRepository>(
        () => LoginCreateRepositoryImpl(sl()));
    sl.registerLazySingleton<OtpVerifyRepository>(
        () => OtpVerifyRepositoryImp(sl()));
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
    sl.registerLazySingleton<SendMessageRepository>(
        () => SendMessageRepositoryImpl(sl()));
    sl.registerLazySingleton<EditingProfileRepository>(
        () => EditingProfileRepositoryImpl(sl()));
    sl.registerLazySingleton<DeepLinkRepository>(
      () => DeepLinkRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<GetChatsRepository>(
      () => GetChatsRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<SendFileMessageRepository>(
      () => SendFileMessageRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<GetMessagesRepository>(
      () => GetMessagesRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<CreateRideRepository>(
      () => CreateRideRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<DriverAcceptRideRepository>(
      () => DriverAcceptRideRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<GetRidesListRepository>(
      () => GetRidesListRepositoryImpl(sl()),
    );

    // datasource
    sl.registerLazySingleton<LoginCreateDataSource>(
        () => LoginCreateDataSourceImpl());
    sl.registerLazySingleton<OtpVerifyDataSource>(
        () => OtpVerifyDataSourceImpl());
    sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
    sl.registerLazySingleton<ImagePickerHelper>(() => ImagePickerHelperImpl());
    sl.registerLazySingleton<SendMessageDataSource>(
        () => SendMessageDataSourceImpl());
    sl.registerLazySingleton<EditingProfileDataSource>(
        () => EditingProfileDataSourceImpl());
    sl.registerLazySingleton<DeepLinkDatasource>(
      () => DeepLinkDatasourceImpl(),
    );
    sl.registerLazySingleton<GetChatsDatasource>(
      () => GetChatsDatasourceImpl(),
    );
    sl.registerLazySingleton<SendFileMessageDataSource>(
      () => SendFileMessageDataSourceImpl(),
    );
    sl.registerLazySingleton<GetMessagesDataSource>(
      () => GetMessagesDatasourceImpl(),
    );
    sl.registerLazySingleton<CreateRideDatasource>(
      () => CreateRideDatasourceImpl(),
    );
    sl.registerLazySingleton<DriverAcceptRideDatasource>(
      () => DriverAcceptRideDatasourceImpl(),
    );
    sl.registerLazySingleton<GetRidesListDatasource>(
        () => GetRidesListDatasourceImpl());
  }
}
