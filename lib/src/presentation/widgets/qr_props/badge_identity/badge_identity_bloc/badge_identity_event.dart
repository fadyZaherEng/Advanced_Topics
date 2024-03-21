part of 'badge_identity_bloc.dart';

abstract class BadgeIdentityEvent {}

class GetCompoundConfigurationEvent extends BadgeIdentityEvent {}

class GetBadgeIdentityEvent extends BadgeIdentityEvent {
  final bool isShowSkeleton;

  GetBadgeIdentityEvent({
    required this.isShowSkeleton,
  });
}

class StartCounterEvent extends BadgeIdentityEvent {}

class EndCounterEvent extends BadgeIdentityEvent {}
