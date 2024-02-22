import 'package:flutter/material.dart';
import 'package:talent_link/src/config/theme/color_schemes.dart';

class CustomGradientButtonWidget extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double height;
  final double width;
  final Color textColor;

  const CustomGradientButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 48,
    this.width = double.infinity,
    this.textColor = ColorSchemes.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              ColorSchemes.primary,
              ColorSchemes.secondary,
            ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}
