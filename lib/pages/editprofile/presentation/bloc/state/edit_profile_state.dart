part of '../cubit/edit_profile_cubit.dart';

class EditProfileState extends Equatable{
  @override
  List<Object?> get props => [];
}

class EditProfile extends EditProfileState{
  @override
  List<Object?> get props => [];
}

class EditProfileLoading extends EditProfileState{
  @override
  List<Object?> get props => [];
}

class EditProfileSuccess extends EditProfileState{

}

class EditProfileFailure extends EditProfileState{
  final String message;

  EditProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}