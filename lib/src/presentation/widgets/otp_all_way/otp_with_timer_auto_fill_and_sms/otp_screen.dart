import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_snack_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/otp_bloc/otp_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/utils/show_edit_number_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/widgets/otp_content_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//with SMS autofill and timer
// To USe SMS autofill Should Use Package to Read SMS
// Then make Reqex for SMS
// then check it if this massage of Verification code
// i will get code and fill it in the PinField

class OTPScreen extends BaseStatefulWidget {
  final int userId;
  final String phoneNumber;
  final int invitationId;
  final String otp;
  final int compoundID;
  final bool isFromDeepLink;

  const OTPScreen({
    super.key,
    required this.userId,
    required this.phoneNumber,
    this.invitationId = 0,
    this.otp = "Your OTP is: 1234",
    this.compoundID = 0,
    this.isFromDeepLink = false,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _OTPScreenState();
}

class _OTPScreenState extends BaseState<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OtpBloc get _bloc => BlocProvider.of<OtpBloc>(context);
  bool _haseTextFieldErrorBorder = false;
  List<int> _otpNumber = [];
  String _otpTextFieldError = '';
  bool _isDebouncing = false;
  String mobileNumber = '';
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(TimerStartedEvent(duration: 30));
    mobileNumber = widget.phoneNumber;
    Future.delayed(Duration.zero, () {
      Timer.run(() {
        if (widget.otp.isNotEmpty) {
          if (context.mounted) {
            CustomSnackBarWidget.show(
              context: _scaffoldKey.currentContext ?? context,
              message: widget.otp,
              backgroundColor: ColorSchemes.barGreen,
              path: ImagePaths.success,
            );
          }
        }
      });
    });
    _controllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
  }

  bool isEnableResendCode = false;

  int currentDuration = 0;

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(listener: (context, state) {
      if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is VerifyOTPSuccessState) {
      } else if (state is VerifyOTPErrorState) {
      } else if (state is EditPhoneNumberState) {
        _onEditPhoneNumberState(
          phoneNumber: state.phoneNumber,
        );
      } else if (state is RequestOTPSuccessState) {
        isEnableResendCode = false;
        _bloc.add(TimerStartedEvent(duration: 30));
        CustomSnackBarWidget.show(
          context: _scaffoldKey.currentContext ?? context,
          message: "${state.message} ${state.otp}",
          backgroundColor: ColorSchemes.barGreen,
          path: ImagePaths.success,
        );
        if (state.isFilledCode) {
          for (int i = 0; i < _controllers.length; i++) {
            _controllers[i].text = state.otp[i].toString();
          }
        }
      } else if (state is TimerRunInProgressState) {
        currentDuration = state.duration;
      } else if (state is TimerRunComplete) {
        currentDuration = state.finalDuration;
        isEnableResendCode = true;
      } else if (state is RequestOTPErrorState) {
        _dialogMessage(
          text: state.message,
          icon: ImagePaths.error,
          action: () {
            Navigator.pop(context);
          },
        );
      } else if (state is NavigationPopState) {
        Navigator.pop(context);
      } else if (state is OTPValidState) {
        _haseTextFieldErrorBorder = false;
        _otpTextFieldError = '';
      } else if (state is OTPEmptyState) {
        _haseTextFieldErrorBorder = state.haseTextFieldErrorBorder;
        _otpTextFieldError = state.errorMessage;
      } else if (state is ChangeMobileNumberSuccessState) {
        mobileNumber = state.phoneNumber;
        CustomSnackBarWidget.show(
          context: _scaffoldKey.currentContext ?? context,
          message: "${state.message} ${state.otp}",
          backgroundColor: ColorSchemes.barGreen,
          path: ImagePaths.success,
        );
        Navigator.pop(context);
        _controllers = List.generate(
          4,
          (index) => TextEditingController(),
        );
      } else if (state is ChangeMobileNumberErrorState) {
        _dialogMessage(
          text: state.message,
          icon: ImagePaths.error,
          action: () {
            Navigator.pop(context);
          },
        );
      }
    }, builder: (context, state) {
      return OTPContentWidget(
        key: _scaffoldKey,
        controllers: _controllers,
        currentDuration: currentDuration,
        isFilledCode:
            state is RequestOTPSuccessState ? state.isFilledCode : false,
        onBackButtonPressed: () {
          _bloc.tickerSubscription?.cancel();
          Navigator.pop(context);
        },
        editAction: () {
          _bloc.add(
            EditPhoneNumberEvent(
              phoneNumber: mobileNumber,
            ),
          );
        },
        verifyAction: () {
          if (!_isDebouncing) {
            setState(() {
              _isDebouncing = true;
            });
            _bloc.add(
              VerifyEvent(
                userId: widget.userId,
                phoneNumber: '',
                otp: _otpNumber,
                invitationId: widget.invitationId,
              ),
            );
            Timer(const Duration(seconds: 1), () {
              setState(() {
                _isDebouncing = false;
              });
            });
          }
        },
        requestAgainAction: isEnableResendCode
            ? () => _bloc.add(RequestAgainEvent(isFilledCode: false))
            : null,
        requestAgainActionWithFilledCode: isEnableResendCode
            ? () => _bloc.add(RequestAgainEvent(isFilledCode: true))
            : null,
        phoneNumber: mobileNumber,
        onOtpChange: (String value) async {
          List<int> otpNumber = convertStringToOTP(value);
          _otpNumber = otpNumber;
          _bloc.add(ValidateOTPNumberEvent(
            otpNumber: otpNumber,
          ));
        },
        haseTextFieldErrorBorder: _haseTextFieldErrorBorder,
        otpTextFieldError: _otpTextFieldError,
      );
    });
  }

  void _dialogMessage({
    required Function() action,
    required String text,
    required String icon,
  }) {
    showMassageDialogWidget(
        context: context,
        text: text,
        icon: icon,
        buttonText: "OK",
        onTap: action);
  }

  void _onEditPhoneNumberState({
    required String phoneNumber,
  }) {
    showEditNumberBottomSheet(
      context: context,
      phoneNumber: "\u200E$phoneNumber",
      userId: widget.userId,
      onEditPhoneNumber: (userId, phoneNumber) {
        _bloc.add(ChangeMobileNumberEvent(
          phoneNumber: phoneNumber,
          userId: userId,
          compoundId: widget.compoundID,
        ));
      },
    );
  }

  List<int> convertStringToOTP(String value) {
    List<int> otpNumber = [];
    for (int i = 0; i < value.length; i++) {
      otpNumber.add(int.parse(value[i]));
    }
    return otpNumber;
  }
}
