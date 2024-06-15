import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';

class OtpWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final int length;
  final void Function(String pin)onCompleted;


  const OtpWidget({super.key,
  required this.length,
  required this.textEditingController,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Pinput(
        length: length,
        controller: textEditingController,
        defaultPinTheme:  PinTheme(
          width: 60,
          height: 60,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorSchemes.black,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorSchemes.iconBackGround,
            border: Border.all(
                color:Colors.transparent),
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
        onCompleted: (pin)=>onCompleted(pin),
        focusedPinTheme: PinTheme(
          height: 60,
          width: 60,
          textStyle:  Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorSchemes.black,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorSchemes.iconBackGround,
            border: Border.all(
                color:Colors.transparent),
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
          height: 60,
          width: 60,
          textStyle:  Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorSchemes.black,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorSchemes.iconBackGround,
            border: Border.all(
                color:Colors.transparent),
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
    );
  }
}
