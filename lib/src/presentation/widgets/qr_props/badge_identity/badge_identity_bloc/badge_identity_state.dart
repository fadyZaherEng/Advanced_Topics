part of 'badge_identity_bloc.dart';

abstract class BadgeIdentityState {}

class BadgeIdentityInitial extends BadgeIdentityState {}

class ShowSkeletonState extends BadgeIdentityState {}

class ShowLoadingState extends BadgeIdentityState {}

class HideLoadingState extends BadgeIdentityState {}

class GetCompoundConfigurationState extends BadgeIdentityState {
  final CompoundConfiguration compoundConfiguration;

  GetCompoundConfigurationState({
    required this.compoundConfiguration,
  });

}

class GetBadgeIdentitySuccessState extends BadgeIdentityState {
  final BadgeIdentity badgeIdentity;

  GetBadgeIdentitySuccessState({
    required this.badgeIdentity,
  });
}

class GetBadgeIdentityErrorState extends BadgeIdentityState {
  final String errorMessage;

  GetBadgeIdentityErrorState({required this.errorMessage});
}

class StartCounterState extends BadgeIdentityState {}

class EndCounterState extends BadgeIdentityState {}
