import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final String imagePath;

  const EmptyWidget({
    Key? key,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imagePath,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: 32),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
              ),
        ),
      ],
    );
  }
}
