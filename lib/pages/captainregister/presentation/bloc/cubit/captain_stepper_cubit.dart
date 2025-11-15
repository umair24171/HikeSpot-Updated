import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../state/captain_stepper_state.dart';

class CaptainStepperCubit extends Cubit<CaptainStepperState> {
  CaptainStepperCubit() : super(CaptainStepperInitial());

  int currentStep = 0;

  void nextStep(int step) {
    emit(CaptainStepperLoading());
    currentStep = step;
    emit(CaptainStepperLoaded());
  }
}
