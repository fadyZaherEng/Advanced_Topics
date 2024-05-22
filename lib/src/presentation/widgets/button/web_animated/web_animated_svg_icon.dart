import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSvgIcon extends StatefulWidget {
  final String svgIcon;
  final double width;
  final double height;

  const AnimatedSvgIcon({
    required this.svgIcon,
    this.width = 16,
    this.height = 16,
    Key? key,
  }) : super(key: key);

  @override
  AnimatedSvgIconState createState() => AnimatedSvgIconState();
}

class AnimatedSvgIconState extends State<AnimatedSvgIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.055).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.75, // 75% of the interval is for rotation
          curve: Curves.linear,
        ),
      )),
      child: SvgPicture.asset(
        widget.svgIcon,
        width: widget.width,
        height: widget.height,
        color: ColorSchemes.white,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
