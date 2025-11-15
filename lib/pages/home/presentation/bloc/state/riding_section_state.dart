part of '../cubit/riding_section_cubit.dart';

class RidingSectionState extends Equatable {
  @override
  List<Object?> get props => [];
}


class RidingSectionInitial extends RidingSectionState {
  final bool showEntranceContent;

  RidingSectionInitial({required this.showEntranceContent});

  @override
  List<Object?> get props => [showEntranceContent];
}

class RidingSectionEntranceContent extends RidingSectionState {
  @override
  List<Object?> get props => [];
}

class RidingSectionSecondaryContent extends RidingSectionState {
  @override
  List<Object?> get props => [];
}

class RidingSectionPassenger extends RidingSectionState {
  @override
  List<Object?> get props => [];
}

class RidingSectionPayment extends RidingSectionState {
  @override
  List<Object?> get props => [];
}

class CaptainWorkingState extends RidingSectionState {
  @override
  List<Object?> get props => [];
}
