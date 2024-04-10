part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class EditPhoneNumberEvent extends OtpEvent {
  final String phoneNumber;

  EditPhoneNumberEvent({required this.phoneNumber});
}

class RequestAgainEvent extends OtpEvent {
  final RequestOTPRequest requestOTPRequest;
  final String phoneNumber;
  final int compoundId;

  RequestAgainEvent({
    required this.requestOTPRequest,
    required this.phoneNumber,
    required this.compoundId,
  });
}

class VerifyEvent extends OtpEvent {
  final int userId;
  final String phoneNumber;
  final List<int> otp;
  final int invitationId;

  VerifyEvent({
    required this.userId,
    required this.phoneNumber,
    required this.otp,
    required this.invitationId,
  });
}

class NavigationPopEvent extends OtpEvent {}

class ValidateOTPNumberEvent extends OtpEvent {
  final List<int> otpNumber;

  ValidateOTPNumberEvent({
    required this.otpNumber,
  });
}

class SelectCompoundEvent extends OtpEvent {}

class ChangeMobileNumberEvent extends OtpEvent {
  final String phoneNumber;
  final int userId;
  final int compoundId;

  ChangeMobileNumberEvent({
    required this.phoneNumber,
    required this.userId,
    required this.compoundId,
  });
}

final class TimerStartedEvent extends OtpEvent {
  TimerStartedEvent({
    required this.duration,
  });

  final int duration;
}

class _TimerTickedEvent extends OtpEvent {
  _TimerTickedEvent({
    required this.duration,
  });

  final int duration;
}
