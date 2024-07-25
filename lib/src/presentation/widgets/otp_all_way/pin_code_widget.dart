import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:pinput/pinput.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController controllers;
  final void Function(String value) onOtpChange;
  final int otpLength;
  final bool error;
  final String errorMessage;
  final void Function(String pin) onCompleted;

  const PinCodeWidget({
    super.key,
    required this.onCompleted,
    required this.onOtpChange,
    required this.controllers,
    required this.error,
    required this.errorMessage,
    required this.otpLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.01),
          child: Pinput(
            length: otpLength,
            controller: controllers,
            defaultPinTheme: PinTheme(
              width: MediaQuery.of(context).size.width * 0.12,
              height: 55,
              // margin: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width * 0.01),
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorSchemes.primary),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.iconBackGround,
                border: Border.all(
                  color: error == true
                      ? ColorSchemes.redError
                      : Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorSchemes.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            onCompleted: (pin) => onCompleted(pin),
            onChanged: (pin) {
              onOtpChange(pin);
            },
            focusedPinTheme: PinTheme(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.12,
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorSchemes.primary),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.iconBackGround,
                border: Border.all(
                  color: error == true
                      ? ColorSchemes.redError
                      : Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorSchemes.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            errorPinTheme: PinTheme(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.12,
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorSchemes.primary),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.iconBackGround,
                border: Border.all(
                  color: error == true
                      ? ColorSchemes.redError
                      : Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorSchemes.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (errorMessage.isNotEmpty) ...[
          const SizedBox(height: 22.0),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              errorMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.redError),
            ),
          )
        ]
      ],
    );
  }
}
