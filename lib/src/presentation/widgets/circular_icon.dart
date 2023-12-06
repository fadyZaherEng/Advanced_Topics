import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIcon extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadows;
  final double iconSize;

  const CircularIcon({
    Key? key,
    required this.imagePath,
    required this.backgroundColor,
    this.boxShadows,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: boxShadows,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        imagePath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
