import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '../state/riding_section_state.dart';

class RidingSectionCubit extends Cubit<RidingSectionState> {
  RidingSectionCubit() : super(RidingSectionEntranceContent());

  double locationButtonGap = 0;

  void showEntranceContent() {
    locationButtonGap = 0;
    emit(RidingSectionEntranceContent());
  }

  void showSecondaryContent() {
    locationButtonGap = 0;
    emit(RidingSectionSecondaryContent());
  }

  void showPassengerSection() {
    locationButtonGap = 100;
    emit(RidingSectionPassenger());
  }

  void togglePassenger() {
    if (state is RidingSectionPassenger) {
      showSecondaryContent();
    } else {
      showPassengerSection();
    }
  }

  void toggleContent() {
    if (state is RidingSectionEntranceContent) {
      showSecondaryContent();
    } else {
      showEntranceContent();
    }
  }

  // toggle to the riding section payment
  void showPaymentSection() {
    locationButtonGap = 100;
    emit(RidingSectionPayment());
  }

  void togglePayment() {
    if (state is RidingSectionPayment) {
      showEntranceContent();
    } else {
      showPaymentSection();
    }
  }

  // captain working state
  void showCaptainWorkingSection() {
    emit(CaptainWorkingState());
  }

  // toggle between the entrance content and the captain working state
  void toggleCaptainWorking() {
    if (state is CaptainWorkingState) {
      showSecondaryContent();
    } else {
      showCaptainWorkingSection();
    }
  }

  // searching the riders 
  void showSearchRiders() {
    if(state is RidingSectionEntranceContent){
      showCaptainWorkingSection();
    }else{
      showSecondaryContent();
    }
  }

  //pop scope function to pop to main
  void onPopScope(){
    showEntranceContent();
  }
}
