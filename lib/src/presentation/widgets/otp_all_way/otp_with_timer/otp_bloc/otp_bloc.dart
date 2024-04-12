import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/utils/timer_ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final TimerTicker _timerTicker;

  OtpBloc(
    this._timerTicker,
  ) : super(OtpInitialState()) {
    on<VerifyEvent>(_onVerifyEvent);
    on<EditPhoneNumberEvent>(_onEditPhoneNumberEvent);
    on<RequestAgainEvent>(_onRequestAgainEvent);
    on<ValidateOTPNumberEvent>(_onValidateOTPNumberEvent);
    on<ChangeMobileNumberEvent>(_onChangeMobileNumberEvent);
    on<TimerStartedEvent>(_onTimerStartedEvent);
    on<_TimerTickedEvent>(_onTimerTickedEvent);
  }

  StreamSubscription<int>? _tickerSubscription;

  StreamSubscription<int>? get tickerSubscription => _tickerSubscription;

  FutureOr<void> _onVerifyEvent(
      VerifyEvent event, Emitter<OtpState> emit) async {}

  FutureOr<void> _onEditPhoneNumberEvent(
      EditPhoneNumberEvent event, Emitter<OtpState> emit) {
    emit(EditPhoneNumberState(
      phoneNumber: event.phoneNumber,
    ));
  }

  FutureOr<void> _onRequestAgainEvent(
      RequestAgainEvent event, Emitter<OtpState> emit) async {
    emit(ShowLoadingState());
    // final DataState<OTP> dataState =
    //     await _requestOTPUseCase(event.requestOTPRequest, event.compoundId);
    if (true) {
      print("OTP: ${Random().nextInt(9)}");
      emit(RequestOTPSuccessState(
          isFilledCode: event.isFilledCode,
          message: "Your OTP is: ",
          otp:
              "${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}"));
    } else {
      emit(RequestOTPErrorState(message: "Something went wrong"));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onValidateOTPNumberEvent(
      ValidateOTPNumberEvent event, Emitter<OtpState> emit) {
    // OTPValidationState validationState =
    //     _otpValidationUseCase.validateOtpNumber(
    //   otpNumber: event.otpNumber,
    // );
    bool isOTPValid = true;
    if (isOTPValid) {
      emit(OTPValidState(
        haseTextFieldErrorBorder: false,
      ));
    } else {
      emit(OTPEmptyState(
        errorMessage: "please Enter Availed Code",
        haseTextFieldErrorBorder: true,
      ));
    }
  }

  FutureOr<void> _onChangeMobileNumberEvent(
      ChangeMobileNumberEvent event, Emitter<OtpState> emit) async {
    emit(ShowLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(ChangeMobileNumberSuccessState(
        message: "Your OTP is: ",
        phoneNumber: event.phoneNumber,
        otp:
            "${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      ));

      emit(HideLoadingState());
    });
  }

  FutureOr<void> _onTimerStartedEvent(
      TimerStartedEvent event, Emitter<OtpState> emit) {
    emit(TimerRunInProgressState(duration: event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _timerTicker.tick(ticks: event.duration).listen((duration) {
      add(_TimerTickedEvent(duration: duration));
    });
  }

  void _onTimerTickedEvent(_TimerTickedEvent event, Emitter<OtpState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgressState(duration: event.duration)
          : TimerRunComplete(finalDuration: event.duration),
    );
  }
}
