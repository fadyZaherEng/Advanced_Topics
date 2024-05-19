import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/svg.dart';

class WebAnimatedCircleIconBorderWidget extends StatefulWidget {
  final double width;
  final double height;
  final String imagePath;
  final Color borderColor;

  const WebAnimatedCircleIconBorderWidget({
    Key? key,
    required this.imagePath,
    required this.borderColor,
    this.width = 48,
    this.height = 48,
  }) : super(key: key);

  @override
  WebAnimatedCircleIconBorderWidgetState createState() =>
      WebAnimatedCircleIconBorderWidgetState();
}

class WebAnimatedCircleIconBorderWidgetState
    extends State<WebAnimatedCircleIconBorderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: ColorSchemes.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 6 * _animation.value,
                color: ColorSchemes.primary,
              ),
            ],
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.borderColor /*.withOpacity(_animation.value)*/,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              widget.imagePath,
              width: 32,
              height: 32,
              fit: BoxFit.scaleDown,
              color: ColorSchemes.primary,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
