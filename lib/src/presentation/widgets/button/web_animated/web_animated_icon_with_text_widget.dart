import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/svg.dart';

class WebAnimatedIconWithTextWidget extends StatefulWidget {
  final String imagePath;
  final Color borderColor;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final String text;

  const WebAnimatedIconWithTextWidget({
    Key? key,
    required this.imagePath,
    required this.borderColor,
    required this.text,
    this.minWidth = 36,
    this.minHeight = 36,
    this.maxWidth = 140,
    this.maxHeight = 36,
  }) : super(key: key);

  @override
  WebAnimatedIconWithTextWidgetState createState() =>
      WebAnimatedIconWithTextWidgetState();
}

class WebAnimatedIconWithTextWidgetState
    extends State<WebAnimatedIconWithTextWidget> {
  late double _width;
  late double _height;

  bool _isCursorPointer = false;
  bool _isCanPerformAnimation = true;

  @override
  void initState() {
    super.initState();
    _width = widget.minWidth;
    _height = widget.minHeight;
  }

  @override
  Widget build(BuildContext context) {
    _isCanPerformAnimation = MediaQuery.of(context).size.width > 1020;
    return MouseRegion(
      onHover: (event) => setState(() {
        _width = widget.maxWidth;
        _height = widget.maxHeight;
        _isCursorPointer = true;
      }),
      onExit: (event) => setState(() {
        _width = widget.minWidth;
        _height = widget.minHeight;
        _isCursorPointer = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _isCanPerformAnimation ? _width : widget.minWidth,
        height: _isCanPerformAnimation ? _height : widget.minHeight,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 32,
              color: Color.fromRGBO(0, 0, 0, 0.12),
            )
          ],
          borderRadius: BorderRadius.circular(_height / 2),
          border: Border.all(
            color: widget.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              widget.imagePath,
              width: 22,
              height: 22,
              fit: BoxFit.scaleDown,
              color: ColorSchemes.primary,
            ),
            Visibility(
              visible: _isCanPerformAnimation && _isCursorPointer,
              child: Expanded(
                child: Text(
                  " ${widget.text}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.primary,
                        letterSpacing: -0.13,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
