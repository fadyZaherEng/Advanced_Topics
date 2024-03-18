import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/presentation/blocs/otp/otp_bloc.dart';
import 'package:city_eye/src/presentation/screens/otp/utils/show_edit_number_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/otp/widgets/otp_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    this.otp = "",
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

  @override
  void initState() {
    super.initState();
    _bloc.add(TimerStartedEvent(duration: 30));
    mobileNumber = widget.phoneNumber;
    Future.delayed(Duration.zero, () {
      Timer.run(() {
        if (widget.otp.isNotEmpty) {
          if (context.mounted) {
            showSnackBar(
              context: _scaffoldKey.currentContext ?? context,
              message: widget.otp,
              color: ColorSchemes.green,
            );
          }
        }
      });
    });
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
        // _onOtpSuccessState(successMessage: state.message);
        if (widget.invitationId != 0) {
          _dialogMessage(
              text: state.message,
              icon: ImagePaths.success,
              action: () {
                Navigator.pushNamed(
                  context,
                  Routes.signIn,
                  arguments: {
                    "unitId": -1,
                    "isFromDeepLink": widget.isFromDeepLink,
                  },
                );
              });
        } else {
          _bloc.tickerSubscription?.cancel();
          _bloc.add(SelectCompoundEvent());
          _dialogMessage(
              text: state.message,
              icon: ImagePaths.success,
              action: () {
                _bloc.add(NavigationPopEvent());
              });
        }
      } else if (state is VerifyOTPErrorState) {
        _onOtpErrorState(
          errorMessage: state.message,
        );
        _haseTextFieldErrorBorder = true;
        _otpTextFieldError = "";
      } else if (state is ErrorState) {
        _dialogMessage(
            text: state.errorMessage,
            icon: ImagePaths.info,
            action: () {
              _bloc.add(NavigationPopEvent());
              _bloc.add(NavigationPopEvent());
            });
      } else if (state is EditPhoneNumberState) {
        _onEditPhoneNumberState(
          phoneNumber: state.phoneNumber,
        );
      } else if (state is RequestOTPSuccessState) {
        isEnableResendCode = false;
        _bloc.add(TimerStartedEvent(duration: 30));
        showSnackBar(
          context: context,
          message: state.otp,
          color: ColorSchemes.green,
        );
      } else if (state is SelectCompoundState) {
        _onSelectCompoundState();
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
            _bloc.add(NavigationPopEvent());
          },
        );
      } else if (state is NavigationPopState) {
        _onNavigationPopState();
      } else if (state is OTPValidState) {
        _haseTextFieldErrorBorder = false;
        _otpTextFieldError = '';
      } else if (state is OTPEmptyState) {
        _haseTextFieldErrorBorder = state.haseTextFieldErrorBorder;
        _otpTextFieldError = state.errorMessage;
      } else if (state is ChangeMobileNumberSuccessState) {
        mobileNumber = state.phoneNumber;
        showSnackBar(
          context: context,
          message: state.otp,
          color: ColorSchemes.green,
        );
        _bloc.add(NavigationPopEvent());
      } else if (state is ChangeMobileNumberErrorState) {
        _dialogMessage(
          text: state.message,
          icon: ImagePaths.error,
          action: () {
            _bloc.add(NavigationPopEvent());
          },
        );
      }
    }, builder: (context, state) {
      return OTPContentWidget(
        key: _scaffoldKey,
        currentDuration: currentDuration,
        onBackButtonPressed: () {
          _bloc.tickerSubscription?.cancel();
          _onBack();
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
            Timer(Duration(seconds: 1), () {
              setState(() {
                _isDebouncing = false;
              });
            });
          }
        },
        requestAgainAction: isEnableResendCode
            ? () {
                _bloc.add(
                  RequestAgainEvent(
                    requestOTPRequest: RequestOTPRequest(
                      userId: widget.userId,
                    ),
                    phoneNumber: mobileNumber,
                    compoundId: widget.compoundID,
                  ),
                );
              }
            : null,
        phoneNumber: mobileNumber,
        onOtpChange: (String value) async {
          List<int> otpNumber = convertStringToOTP(value);
          _otpNumber = otpNumber;

          // _bloc.add(ValidateOTPNumberEvent(
          //   otpNumber: otpNumber,
          // ));
        },
        haseTextFieldErrorBorder: _haseTextFieldErrorBorder,
        otpTextFieldError: _otpTextFieldError,
      );
    });
  }

  void _onOtpErrorState({required String errorMessage}) {
    _dialogMessage(
        icon: ImagePaths.error,
        action: () {
          _bloc.add(
            NavigationPopEvent(),
          );
        },
        text: errorMessage);
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
        buttonText: S.of(context).ok,
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

  void _onNavigationPopState() => Navigator.pop(context);

  List<int> convertStringToOTP(String value) {
    List<int> otpNumber = [];
    for (int i = 0; i < value.length; i++) {
      otpNumber.add(int.parse(value[i]));
    }
    return otpNumber;
  }

  void _onSelectCompoundState() {
    _bloc.tickerSubscription?.cancel();
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false,
        arguments: {
          "selectIndex": 0,
        });
  }

  void _onBack() {
    if (widget.isFromDeepLink) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.signIn,
        arguments: {
          "unitId": -1,
          "isFromDeepLink": widget.isFromDeepLink,
        },
        (route) => false,
      );
    } else {
      _bloc.add(NavigationPopEvent());
    }
  }
}
