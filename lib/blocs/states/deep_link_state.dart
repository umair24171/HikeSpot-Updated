part of '../cubits/deep_link_cubit.dart';

class DeepLinkState extends  Equatable {
  @override
  List<Object?> get props => [];
}


class DeepLinkInitial extends DeepLinkState{}
class DeepLinkLoading extends DeepLinkState{}
class DeepLinkSuccess extends DeepLinkState{}
class DeepLinkError extends DeepLinkState{}