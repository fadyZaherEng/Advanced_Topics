import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
class WebCircleIconWidget extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final Color borderColor;
  final Function()? onTap;

  const WebCircleIconWidget({
    Key? key,
    required this.imagePath,
    required this.borderColor,
    this.onTap,
    this.width = 48,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap;
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 32,
                color: Color.fromRGBO(0, 0, 0, 0.12))
          ],
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              imagePath,
              width: 36,
              height: 36,
              fit: BoxFit.fill,
              color: ColorSchemes.primary,
            ),
          ),
        ),
      ),
    );
  }
}
