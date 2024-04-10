part of 'otp_bloc.dart';

@immutable
abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class OtpInitialState extends OtpState {}

class ShowLoadingState extends OtpState {}

class HideLoadingState extends OtpState {}

class VerifyOTPSuccessState extends OtpState {
  final String message;

  VerifyOTPSuccessState({
    required this.message,
  });
}

class VerifyOTPErrorState extends OtpState {
  final String message;

  VerifyOTPErrorState({
    required this.message,
  });
}

class EditPhoneNumberState extends OtpState {
  final String phoneNumber;

  EditPhoneNumberState({
    required this.phoneNumber,
  });
}

class RequestOTPSuccessState extends OtpState {
  final String message;
  final String otp;

  RequestOTPSuccessState({
    required this.message,
    required this.otp,
  });
}

class RequestOTPErrorState extends OtpState {
  final String message;

  RequestOTPErrorState({
    required this.message,
  });
}

class NavigationPopState extends OtpState {}

class OTPEmptyState extends OtpState {
  final String errorMessage;
  final bool haseTextFieldErrorBorder;

  OTPEmptyState({
    required this.errorMessage,
    required this.haseTextFieldErrorBorder,
  });
}

class OTPValidState extends OtpState {
  final bool haseTextFieldErrorBorder;

  OTPValidState({
    required this.haseTextFieldErrorBorder,
  });
}

class ErrorState extends OtpState {
  final String errorMessage;

  ErrorState({
    required this.errorMessage,
  });
}

class SignInSuccessState extends OtpState {
  final List<UserUnit> userUnits;

  SignInSuccessState({
    required this.userUnits,
  });
}

class SelectCompoundState extends OtpState {}

class ChangeMobileNumberSuccessState extends OtpState {
  final String phoneNumber;
  final String message;
  final String otp;

  ChangeMobileNumberSuccessState({
    required this.phoneNumber,
    required this.message,
    required this.otp,
  });
}

class ChangeMobileNumberErrorState extends OtpState {
  final String message;

  ChangeMobileNumberErrorState({
    required this.message,
  });
}

final class TimerRunInProgressState extends OtpState {
  final int duration;

  TimerRunInProgressState({
    required this.duration,
  });

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

final class TimerRunComplete extends OtpState {
  final int finalDuration;

  TimerRunComplete({
    required this.finalDuration,
  });
}
