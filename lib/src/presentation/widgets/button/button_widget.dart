import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String buttonTitle;
  final Color backgroundColor;
  final Color titleColor;
  final Color borderColor;

  const ButtonWidget({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.backgroundColor = ColorSchemes.primary,
    this.titleColor = ColorSchemes.white,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          backgroundColor,
          backgroundColor.withOpacity(0.5),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
            color: backgroundColor.withOpacity(0.24),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(width: 1, color: borderColor),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              } else {
                return null;
              }
            })),
        onPressed: onTap,
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: titleColor,
                letterSpacing: -0.32,
              ),
        ),
      ),
    );
  }
}
