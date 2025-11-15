import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/activities/presentation/page/activities_page.dart';
import 'package:hikespot/pages/chats/presentation/page/user_chats_page.dart';
import 'package:hikespot/pages/notification/presentation/widgets/notification_setting_container.dart';
import 'package:hikespot/pages/profile/presentation/page/profile_page.dart';
import 'package:hikespot/pages/schedule/presentation/page/schedule_page.dart';
import 'package:hikespot/pages/schedule/presentation/widgets/schedule_list.dart';
import 'package:hikespot/utils/enums.dart';

import '../../page/home_page.dart';

part '../state/menue_state.dart';

class MenueCubit extends Cubit<MenueState> {
  MenueCubit() : super(MenueInitial());

  int currentIndex = 0;

  AppState _userState = authCubit.authData.appStatus == "user"
      ? AppState.user
      : AppState.captain;
  AppState get userState => _userState;

  //change the state of the app
  void changeState(AppState state,context) {
    emit(MenueLoading());
    _userState = state;
    authCubit.changeState(state,context);
    emit(MenueLoaded());
  }

  changeIndex(int index) {
    emit(MenueLoading());
    currentIndex = index;
    emit(MenueLoaded());
  }

  bool showMenu = false;

  changeMenuVisibility(bool show) {
    emit(MenueLoading());
    if (show) {
      showMenu = false;
      emit(MenueLoaded());
    } else {
      showMenu = true;
      emit(MenueLoaded());
    }
  }

  // change the current screen
  void changeScreenToSchedule() {
    emit(MenueLoading());
    screens[currentIndex] = const ScheduleList();
    emit(MenueLoaded());
  }

  // change to schedule page
  void changeScreenToSchedulePage() {
    emit(MenueLoading());
    screens[currentIndex] = const SchedulePage();
    emit(MenueLoaded());
  }

  // screens
  List<Widget> screens = [
    const HomePage(),
    const ActivitiesPage(),
    const SchedulePage(),
    const UserChatsPage(),
    const ProfilePage(),
  ];

  // captain screens
  List<Widget> riderScreen = [
    const HomePage(),
    const ActivitiesPage(),
    const UserChatsPage(),
    const ProfilePage(),
  ];
}
final AuthCubit authCubit = Di().sl<AuthCubit>();