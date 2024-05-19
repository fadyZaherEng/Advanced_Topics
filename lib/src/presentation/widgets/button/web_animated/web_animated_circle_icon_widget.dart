import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class WebAnimatedCircleIconWidget extends StatefulWidget {
  final double width;
  final double height;
  final String imagePath;
  final double animatedBorderWidth;
  final Function onTap;

  const WebAnimatedCircleIconWidget({
    super.key,
    required this.width,
    required this.height,
    required this.imagePath,
    required this.onTap,
    this.animatedBorderWidth = 4,
  });

  @override
  State<WebAnimatedCircleIconWidget> createState() =>
      _WebAnimatedCircleIconWidgetState();
}

class _WebAnimatedCircleIconWidgetState
    extends State<WebAnimatedCircleIconWidget> {
  bool _isCursorsEnter = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isCursorsEnter = true;
        setState(() {});
      },
      onExit: (_) {
        _isCursorsEnter = false;
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          Visibility(
            visible: _isCursorsEnter,
            child: Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorSchemes.primary.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.animatedBorderWidth,
            bottom: widget.animatedBorderWidth,
            left: widget.animatedBorderWidth,
            right: widget.animatedBorderWidth,
            child: WebCircleIconWidget(
                width: widget.width,
                height: widget.height,
                imagePath: widget.imagePath,
                borderColor: ColorSchemes.primary,
                onTap: () {
                  widget.onTap();
                }),
          ),
        ],
      ),
    );
  }
}
