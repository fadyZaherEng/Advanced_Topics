import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/otp/widgets/dont_recive_code_widget.dart';
import 'package:city_eye/src/presentation/screens/otp/widgets/edit_phone_number_widget.dart';
import 'package:city_eye/src/presentation/screens/otp/widgets/otp_text_feild_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPContentWidget extends StatefulWidget {
  final Function() onBackButtonPressed;
  final Function() editAction;
  final Function() verifyAction;
  final Function()? requestAgainAction;
  final String phoneNumber;
  final String otpTextFieldError;
  final void Function(String value) onOtpChange;
  final bool haseTextFieldErrorBorder;
  final int currentDuration;

  const OTPContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.editAction,
    required this.verifyAction,
    required this.requestAgainAction,
    required this.phoneNumber,
    required this.onOtpChange,
    required this.haseTextFieldErrorBorder,
    required this.otpTextFieldError,
    required this.currentDuration,
  }) : super(key: key);

  @override
  State<OTPContentWidget> createState() => _OTPContentWidgetState();
}

class _OTPContentWidgetState extends State<OTPContentWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBackButtonPressed();
        return false;
      },
      child: Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: S.of(context).verifyYourAccount,
          isHaveBackButton: true,
          onBackButtonPressed: widget.onBackButtonPressed,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                SvgPicture.asset(
                  ImagePaths.messageNotifications,
                  matchTextDirection: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: Text(
                    textAlign: TextAlign.center,
                    S.of(context).weHaveSentTheCodeVerificationToYourMobileNumber,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorSchemes.black,
                          letterSpacing: -0.24,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                EditPhoneNumberWidget(
                  editAction: widget.editAction,
                  phoneNumber: "\u200E${widget.phoneNumber}",
                ),
                const SizedBox(
                  height: 32,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomOtpFieldWidget(
                    onOtpChange: (value) {
                      widget.onOtpChange(value);
                    },
                    verifyAction: widget.verifyAction,
                    error: widget.haseTextFieldErrorBorder,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).yourCodeWillExpireIn,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                    Text(
                      '${((widget.currentDuration / 60) % 60).floor().toString().padLeft(2, '0')}:${(widget.currentDuration % 60).toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                  ],
                ),
                widget.otpTextFieldError.isNotEmpty
                    ? const SizedBox(
                        height: 17,
                      )
                    : const SizedBox(),
                widget.otpTextFieldError.isNotEmpty
                    ? Text(
                        textAlign: TextAlign.center,
                        widget.otpTextFieldError,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.redError,
                              letterSpacing: -0.13,
                            ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 32),
                DontReceiveCodeWidget(
                  requestAgainAction: widget.requestAgainAction,
                ),
                const SizedBox(
                  height: 41,
                ),
                CustomButtonWidget(
                  width: double.infinity,
                  onTap: widget.verifyAction,
                  text: S.of(context).verify,
                  backgroundColor: F.isNiceTouch ? ColorSchemes.ghadeerDarkBlue : ColorSchemes.primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
