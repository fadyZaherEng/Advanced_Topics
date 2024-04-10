import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/validation/otp_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/edit_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/verify_otp_request.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/usecase/edit_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/otp_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/request_otp_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/verify_otp_use_case.dart';
import 'package:city_eye/src/presentation/screens/otp/utils/timer_ticker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OTPValidationUseCase _otpValidationUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final RequestOTPUseCase _requestOTPUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;
  final SetUserUnitUseCase _setUserUnitUseCase;
  final EditMobileNumberUseCase _editMobileNumberUseCase;

  final TimerTicker _timerTicker;

  StreamSubscription<int>? _tickerSubscription;

  OtpBloc(
    this._otpValidationUseCase,
    this._verifyOTPUseCase,
    this._requestOTPUseCase,
    this._saveUserInformationUseCase,
    this._setUserUnitUseCase,
    this._editMobileNumberUseCase,
    this._timerTicker,
  ) : super(OtpInitialState()) {
    on<VerifyEvent>(_onVerifyEvent);
    on<EditPhoneNumberEvent>(_onEditPhoneNumberEvent);
    on<RequestAgainEvent>(_onRequestAgainEvent);
    on<NavigationPopEvent>(_onNavigationPopEvent);
    on<ValidateOTPNumberEvent>(_onValidateOTPNumberEvent);
    on<SelectCompoundEvent>(_onSelectCompoundEvent);
    on<ChangeMobileNumberEvent>(_onChangeMobileNumberEvent);
    on<TimerStartedEvent>(_onTimerStartedEvent);
    on<_TimerTickedEvent>(_onTimerTickedEvent);
  }

  StreamSubscription<int>? get tickerSubscription => _tickerSubscription;
  User user = User();

  FutureOr<void> _onVerifyEvent(
      VerifyEvent event, Emitter<OtpState> emit) async {
    OTPValidationState validationState =
        _otpValidationUseCase.validateOtpNumber(
      otpNumber: event.otp,
    );

    if (validationState == OTPValidationState.valid) {
      emit(ShowLoadingState());
      final DataState<User> dataState = await _verifyOTPUseCase(
          VerifyOTPRequest(
            otpNumber: event.otp.join(''),
            invitationID: event.invitationId,
            isInvitation: event.invitationId != 0,
          ),
          event.userId);
      if (dataState is DataSuccess) {
        user = dataState.data!;
        if (event.invitationId == 0) {
          if (user.userInformation.status == false) {
            emit(ErrorState(
              errorMessage: dataState.message ?? "",
            ));
          } else {
            if (user.userUnits.first.isCompoundVerified == false ||
                user.userUnits.first.isActive == false) {
              emit(ErrorState(
                errorMessage: user.userUnits.first.message,
              ));
            } else {
              emit(VerifyOTPSuccessState(message: dataState.message ?? ""));
            }
          }
        } else {
          emit(VerifyOTPSuccessState(message: dataState.message ?? ""));
        }
      } else {
        emit(VerifyOTPErrorState(
          message: dataState.message ?? "",
        ));
      }
      emit(HideLoadingState());
    } else {
      emit(OTPEmptyState(
        haseTextFieldErrorBorder: true,
        errorMessage: S.current.pleaseEnterAvailedCode,
      ));
    }
  }

  FutureOr<void> _onEditPhoneNumberEvent(
      EditPhoneNumberEvent event, Emitter<OtpState> emit) {
    emit(EditPhoneNumberState(
      phoneNumber: event.phoneNumber,
    ));
  }

  FutureOr<void> _onRequestAgainEvent(
      RequestAgainEvent event, Emitter<OtpState> emit) async {
    emit(ShowLoadingState());
    final DataState<OTP> dataState =
        await _requestOTPUseCase(event.requestOTPRequest,event.compoundId);
    if (dataState is DataSuccess) {
      emit(RequestOTPSuccessState(
          message: dataState.message ?? "", otp: dataState.data!.number));
    } else {
      emit(RequestOTPErrorState(message: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onNavigationPopEvent(
      NavigationPopEvent event, Emitter<OtpState> emit) {
    emit(NavigationPopState());
  }

  FutureOr<void> _onValidateOTPNumberEvent(
      ValidateOTPNumberEvent event, Emitter<OtpState> emit) {
    OTPValidationState validationState =
        _otpValidationUseCase.validateOtpNumber(
      otpNumber: event.otpNumber,
    );
    if (validationState == OTPValidationState.valid) {
      emit(OTPValidState(
        haseTextFieldErrorBorder: false,
      ));
    } else {
      emit(OTPEmptyState(
        errorMessage: S.current.pleaseEnterAvailedCode,
        haseTextFieldErrorBorder: true,
      ));
    }
  }

  FutureOr<void> _onSelectCompoundEvent(
      SelectCompoundEvent event, Emitter<OtpState> emit) {
    _saveUserInformationUseCase(user);
    _setUserUnitUseCase(user.userUnits.first);
    emit(SelectCompoundState());
  }

  FutureOr<void> _onChangeMobileNumberEvent(
      ChangeMobileNumberEvent event, Emitter<OtpState> emit) async {
    emit(ShowLoadingState());
    final dataState = await _editMobileNumberUseCase(EditMobileNumberRequest(
      mobileNumber: event.phoneNumber,
      userId: event.userId,
      compoundId: event.compoundId,
    ));

    if (dataState is DataSuccess) {
      emit(ChangeMobileNumberSuccessState(
        message: dataState.message ?? "",
        phoneNumber: event.phoneNumber,
        otp: dataState.data?.newOTPnumber ?? "",
      ));
    } else {
      emit(ChangeMobileNumberErrorState(
        message: dataState.message ?? "",
      ));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onTimerStartedEvent(
      TimerStartedEvent event, Emitter<OtpState> emit) {
    emit(TimerRunInProgressState(duration: event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _timerTicker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTickedEvent(duration: duration)));
  }

  void _onTimerTickedEvent(_TimerTickedEvent event, Emitter<OtpState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgressState(duration: event.duration)
          : TimerRunComplete(finalDuration: event.duration),
    );
  }
}
